# Bull Server ![Bull Server Build Status](https://img.shields.io/circleci/project/github/dnsbty/bull_server/master.svg)
![Bull](https://user-images.githubusercontent.com/3421625/34645447-bd9022d0-f30a-11e7-8526-497db235c6d5.gif)

Bull is a real-time group game in which players invent definitions for unknown words, and then guess which of the many definitions is correct.
The server for the game is built using Phoenix Channels to handle the communication layer, and with Agents to handle game state.

## Running the server

1. Make sure you have [Elixir 1.5 and OTP 20 installed](https://elixir-lang.org/install.html)
2. Clone the repo onto your local machine: `git clone git@github.com:dnsbty/bull_server.git`
3. Install the project's dependencies: `cd bull-server && mix deps.get`
4. Start the server: `mix phx.server`

Now you can connect to the websocket with [`localhost:3333/socket/websocket`](http://localhost:3333/socket/websocket)
