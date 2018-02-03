defmodule BullWebServer.GameChannel do
  @moduledoc """
  This channel handles all the communication coming in from the players.
  """
  use BullServerWeb, :channel
  alias BullServer.Games

  intercept ["start_game"]

  @doc """
  Handles users joining a game channel. Using `new` as the game ID will create a new game.
  """
  def join("game:new", _message, socket) do
    send(self(), :create_game)
    {:ok, socket}
  end
  def join("game:" <> game_id, _message, %{assigns: assigns} = socket) do
    player_name = Map.get(assigns, :name)
    key = Map.get(assigns, :key)

    with {:ok, _} <- Games.can_join?(game_id, player_name, key) do
      send(self(), :after_join)
      {:ok, socket}
    end
  end

  @doc """
  Handles the actual logic of creating or joining a game.
  """
  def handle_info(:create_game, socket) do
    game_id = Games.create()
    push socket, "new_game", %{game_id: game_id}
    {:noreply, socket}
  end
  def handle_info(:after_join, socket) do
    push socket, "presence_state", Presence.list(socket)
    {:ok, _} = Presence.track(socket, socket.assigns.name, %{
      status: "online"
    })
    {:noreply, socket}
  end

  @doc """
  Handle messages sent in from users. The following messages are permissible:

  "all_ready"
    - Description: Signals that all players are ready for the next stage of the game.
    - Payload: none
  "define_word"
    - Description: Saves a user's definition for the round.
    - Payload: %{"definition" => ""}
  "new_status"
    - Description: Updates the user's status ("ready" or "thinking")
    - Payload: %{"status" => ""}
  "start_game"
    - Description: Starts the game
    - Payload: None
  "submit_vote"
    - Description: Saves a vote for the specified writer.
    - Payload: %{"writer" => ""}
  """
  def handle_in("all_ready", _payload, socket) do
    socket
    |> game_id
    |> Games.start_next_stage
    |> broadcast_next_stage(socket)

    {:noreply, socket}
  end
  def handle_in("define_word", %{"definition" => definition}, socket) do
    game_id = game_id(socket)
    player_name = socket.assigns.name
    Games.save_definition(game_id, player_name, definition)

    {:noreply, socket}
  end
  def handle_in("new_status", %{"status" => status}, socket) do
    {:ok, _} = Presence.update(socket, socket.assigns.name, %{
      status: status
    })
    {:noreply, socket}
  end
  def handle_in("start_game", _payload, socket) do
    game_id = game_id(socket)
    players =
      "game:#{game_id}"
      |> Presence.list()
      |> Map.keys()

    word = Games.start_game(game_id, players)

    broadcast socket, "start_game", %{word: word}

    {:noreply, socket}
  end
  def handle_in("submit_vote", %{"writer" => writer}, socket) do
    game_id = game_id(socket)
    player_name = socket.assigns.name
    Games.save_vote(game_id, player_name, writer)

    {:noreply, socket}
  end

  @doc """
  Handle messages being broadcast to users. The following messages are being intercepted:

  "start_game"
    - Description: Being sent down when the game is started.
    - Interception Reason: We want to append a secret key that will allow the user to rejoin the
        game if they leave at any point.
  """
  def handle_out("start_game", word, socket) do
    game_id = game_id(socket)
    player_name = player_name(socket)
    key = Games.key(game_id, player_name)
    payload = Map.put(word, :rejoin_key, key)

    push socket, "start_game", payload
    {:noreply, socket}
  end

  defp broadcast_next_stage({:defining, word}, socket) do
    broadcast socket, "start_defining", word
  end
  defp broadcast_next_stage({:results, results}, socket) do
    broadcast socket, "show_results", results
  end
  defp broadcast_next_stage({:voting, definitions}, socket) do
    broadcast socket, "start_voting", definitions
  end

  defp game_id(%{topic: "game:" <> game_id}), do: game_id

  defp player_name(%{assigns: %{name: name}}), do: name
end
