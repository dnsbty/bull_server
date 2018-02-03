defmodule BullServer.Games.Game do
  use Agent

  @doc """
  Adds to the score of a player in a game.
  """
  @spec add_to_score(game :: pid, player_name :: String.t, points :: integer) :: :ok
  def add_to_score(game, player_name, points) do
    current_score = Agent.get(game, &Kernel.get_in(&1, [:scores, player_name]))
    new_score = current_score + points
    Agent.update(game, &Kernel.put_in(&1, [:scores, player_name], new_score))
  end

  @doc """
  Creates a new game.
  """
  @spec create(game_id :: String.t) :: Agent.on_start()
  def create(game_id) do
    data = %{
      current_round: 0,
      current_stage: :start,
      id: game_id,
      players: %{},
      scores: %{},
      started: false,
      words: []
    }
    Agent.start(fn -> data end)
  end

  @doc """
  Gets the current stage of a game.
  """
  @spec current_stage(game :: pid) :: atom
  def current_stage(game) do
    Agent.get(game, &Map.get(&1, :current_stage))
  end

  @doc """
  Gets the list of definitions.
  """
  @spec definitions(game :: pid) :: map
  def definitions(game) do
    Agent.get(game, &Map.get(&1, :definitions))
  end

  @doc """
  Deletes the process for a game.
  """
  @spec delete(game :: pid) :: :ok
  def delete(game) do
    Agent.stop(game)
  end

  @doc """
  Checks if a game has started.
  """
  @spec has_started?(game :: pid) :: boolean
  def has_started?(game) do
    Agent.get(game, &Map.get(&1, :started))
  end

  @doc """
  Gets the next stage of the game.
  """
  @spec next_stage(game :: pid) :: atom
  def next_stage(game) when is_pid(game) do
    game
    |> current_stage()
    |> next_stage()
  end

  @spec next_stage(current_stage :: atom) :: atom
  def next_stage(current_stage) when is_atom(current_stage) do
    case current_stage do
      :start -> :defining
      :defining -> :voting
      :voting -> :results
      :results -> :defining
    end
  end

  @doc """
  Adds a definition to the list.
  """
  @spec save_definition(game :: pid, player_name :: String.t, definition :: String.t) :: :ok
  def save_definition(game, player_name, definition) do
    Agent.update(game, &Kernel.put_in(&1, [:definitions, player_name], definition))
    Agent.update(game, &Kernel.put_in(&1, [:votes, player_name], []))
  end

  @doc """
  Adds a vote to a definition in the list.
  """
  @spec save_vote(game :: pid, player_name :: String.t, definition :: String.t) :: :ok
  def save_vote(game, player_name, definition) do
    votes = Agent.get(game, &Kernel.get_in(&1, [:votes, definition]))
    Agent.update(game, &Kernel.put_in(&1, [:votes, definition], [player_name | votes]))
  end

  @doc """
  Gets the list of scores for a game.
  """
  @spec scores(game :: pid) :: map
  def scores(game) do
    Agent.get(game, &Map.get(&1, :scores))
  end

  @doc """
  Marks a game as started.
  """
  @spec start(game :: pid, players :: list(String.t)) :: :ok
  def start(game, players) do
    Agent.update(game, &Map.put(&1, :started, true))
    add_players(game, players)
    add_players_to_scores(game, players)
  end

  @spec add_players(game :: pid, players :: list(String.t)) :: :ok
  defp add_players(game, players) do
    join_keys = Enum.reduce(players, %{}, fn(player, keys) ->
      Map.put(keys, player, join_key())
    end)
    Agent.update(game, &Map.put(&1, :players, join_keys))
  end

  @spec join_key() :: String.t
  defp join_key, do: 8 |> :crypto.strong_rand_bytes |> Base.url_encode64 |> binary_part(0, 8)

  @spec add_players_to_scores(game :: pid, players :: list(String.t)) :: :ok
  defp add_players_to_scores(game, players) do
    scores = Enum.reduce(players, %{}, fn(player, scores) ->
      Map.put(scores, player, 0)
    end)
    Agent.update(game, &Map.put(&1, :scores, scores))
  end

  @doc """
  Get all state from the specified game.
  """
  @spec state(game :: pid) :: map
  def state(game) do
    Agent.get(game, fn(state) -> state end)
  end

  @doc """
  Clears current round info and increments round number.
  """
  @spec start_next_round(game :: pid, word :: String.t, definition :: String.t) :: String.t
  def start_next_round(game, word, definition) do
    Agent.update(game, &Map.merge(&1, %{
      current_round: &1.current_round + 1,
      current_stage: :defining,
      current_word: word,
      definitions: %{"correct" => definition},
      votes: %{"correct" => []},
      words: [word | &1.words]
    }))
    word
  end

  @doc """
  Updates the current_stage of a game to the one specified.
  """
  @spec start_next_stage(game :: pid, stage :: atom) :: :ok
  def start_next_stage(game, stage) do
    Agent.update(game, &Map.put(&1, :current_stage, stage))
  end

  @doc """
  Returns whether the given word has been used already this game.
  """
  @spec used_word?(game :: pid, word :: String.t) :: boolean
  def used_word?(game, word) do
    game
    |> Agent.get(&Map.get(&1, :words))
    |> Enum.member?(word)
  end

  @doc """
  Gets the list of votes for the current round.
  """
  @spec votes(game :: pid) :: map
  def votes(game) do
    Agent.get(game, &Map.get(&1, :votes))
  end

  @doc """
  Returns the list of words that have been used so far.
  """
  @spec words(game :: pid) :: list(String.t)
  def words(game) do
    Agent.get(game, &Map.get(&1, :words))
  end
end
