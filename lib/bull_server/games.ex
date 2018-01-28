defmodule BullServer.Games do
  use Agent
  # alias BullServerWeb.Presence
  alias BullServer.Games.{
    Game,
    Id,
    Words
  }

  @correct_answer_points 2
  @guessed_answer_points 1

  @doc """
  Starts the games supervisor.
  """
  @spec start_link() :: Agent.on_start()
  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  @doc """
  Clears a game from memory.
  """
  @spec clear(game_id :: String.t) :: :ok
  def clear(game_id) do
    game_id
    |> get()
    |> Game.delete()

    Agent.update(__MODULE__, &Map.delete(&1, game_id))
  end

  # @doc """
  # Clears all games where all players have left.
  # """
  # @spec clear_empty() :: :ok
  # def clear_empty do
  #   Enum.each(list(), fn({game_id, _}) ->
  #     "game:#{game_id}"
  #     |> Presence.list
  #     |> clear_if_empty(game_id)
  #   end)
  # end
  #
  # defp clear_if_empty(players, game_id) when players == %{}, do: clear(game_id)
  # defp clear_if_empty(_, _), do: nil

  @doc """
  Clears all games from memory.
  """
  @spec clear_all() :: :ok
  def clear_all do
    Enum.each(list(), fn({_, pid}) ->
      Agent.stop(pid)
    end)
    Agent.update(__MODULE__, fn(_) -> %{} end)
  end

  @doc """
  Creates a new game and returns the game ID.
  """
  @spec create() :: String.t
  def create do
    id = Id.generate()
    case exists?(id) do
      true -> create()
      false ->
        {:ok, game} = Game.create(id)
        Agent.update(__MODULE__, &Map.put(&1, id, game))
        id
    end
  end

  @doc """
  Checks if the specified Game ID exists.
  """
  @spec exists?(game_id :: String.t) :: boolean
  def exists?(game_id) do
    case get(game_id) do
      nil -> false
      _ -> true
    end
  end

  @doc """
  Checks if the specified Game ID can be joined.
  """
  @spec is_joinable?(game_id :: String.t) :: boolean
  def is_joinable?(game_id) do
    with game when is_pid(game) <- Agent.get(__MODULE__, &Map.get(&1, game_id)),
      false <- Game.has_started?(game)
    do
      true
    else
      _ -> false
    end
  end

  @doc """
  Gets a game by its ID.
  """
  @spec get(game_id :: String.t) :: pid | nil
  def get(game_id) do
    Agent.get(__MODULE__, &Map.get(&1, game_id))
  end

  @doc """
  Get the list of definitions for a game.
  """
  @spec get_definitions(game_id :: String.t) :: map
  def get_definitions(game_id) do
    game_id
    |> get()
    |> Game.definitions()
  end

  @doc """
  Gets the list of votes for the current round of a game.
  """
  @spec get_votes(game_id :: String.t) :: map
  def get_votes(game_id) do
    game_id
    |> get()
    |> Game.votes()
  end

  @doc """
  Gets the list of scores for a game.
  """
  @spec get_scores(game_id :: String.t) :: map
  def get_scores(game_id) do
    game_id
    |> get()
    |> Game.scores()
  end

  @doc """
  List all games in memory.
  """
  @spec list() :: map
  def list do
    Agent.get(__MODULE__, fn(state) -> state end)
  end

  @doc """
  Save a definition to the list of definitions for a game.
  """
  @spec save_definition(game_id :: String.t, player_name :: String.t, definition :: String.t) :: :ok
  def save_definition(game_id, player_name, definition) do
    game_id
    |> get()
    |> Game.save_definition(player_name, definition)
  end

  @doc """
  Save a vote to the list of votes for a definition in the game.
  """
  @spec save_vote(game_id :: String.t, player_name :: String.t, definition :: String.t) :: :ok | nil
  def save_vote(game_id, player_name, definition) do
    game = get(game_id)
    Game.save_vote(game, player_name, definition)

    case definition do
      ^player_name -> nil
      "correct" -> Game.add_to_score(game, player_name, @correct_answer_points)
      _ -> Game.add_to_score(game, definition, @guessed_answer_points)
    end
  end

  @doc """
  Start a game with the given game ID and return the first word.
  """
  @spec start_game(game_id :: String.t, players :: list(String.t)) :: String.t
  def start_game(game_id, players) do
    game = get(game_id)
    Game.start(game, players)
    start_next_round(game_id)
  end

  @doc """
  Start the next round of the game with the specified game ID and return the new word.
  """
  @spec start_next_round(game_id :: String.t) :: String.t
  def start_next_round(game_id) do
    game = get(game_id)
    {word, definition} = random_word(game)
    Game.start_next_round(game, word, definition)
  end

  defp random_word(game) do
    {word, definition} = Words.random()
    case Game.used_word?(game, word) do
      false -> {word, definition}
      _ -> random_word(game)
    end
  end

  @doc """
  Start the next stage of the game with the specified game ID.
  """
  @spec start_next_stage(game_id :: String.t) :: {atom, map}
  def start_next_stage(game_id) do
    game_id
    |> get()
    |> Game.next_stage()
    |> start_stage(game_id)
  end

  defp start_stage(:defining, game_id) do
    data = %{
      word: start_next_round(game_id)
    }
    {:defining, data}
  end
  defp start_stage(:results, game_id) do
    game = get(game_id)
    Game.start_next_stage(game, :results)
    data = %{
      scores: Game.scores(game),
      votes: Game.votes(game)
    }

    {:results, data}
  end
  defp start_stage(:voting, game_id) do
    game = get(game_id)
    Game.start_next_stage(game, :voting)
    data = %{
      definitions: Game.definitions(game)
    }
    {:voting, data}
  end

  @doc """
  Get the state of the game with the specified ID.
  """
  @spec state(game_id :: String.t) :: map
  def state(game_id) do
    game_id
    |> get
    |> Game.state
  end
end
