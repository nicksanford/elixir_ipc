# ElixirIpc
Small demo of a unix socket (ipc) client &amp; server for personal learning.

This demo shows how one can communicate between two elixir processes (a client & a server) using unix sockets.

Either the client or the server could be swapped out for another program in any programming language that supports unix sockets. This could be a light weight approach to allow bi directional communication between OS processes on the same host, without needing to set up a web server or even a tcp connection.


## Install

```
git clone git@github.com:nicksanford/elixir_ipc.git
cd elixir_ipc
```

## Run demo

```
iex -S mix
iex(1)> ElixirIpc.demo
```

TODO:
1. A pool of node.js echo servers which can be checked out & sentmessages over ipc using https://github.com/discord/erlpack.
2. A pool of python echo servers which can be checked out & sentmessages over ipc using https://github.com/discord/erlpack.
3. A pool of rust echo servers which can be checked out & sentmessages over ipc using https://docs.rs/erlang-term/0.1.1/erlang_term/.
4. A pool of golang echo servers which can be checked out & sentmessages over ipc using https://github.com/okeuday/erlang_go/blob/master/v2/erlang/erlang.go.
