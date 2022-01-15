defmodule ElixirIpc do
  alias ElixirIpc.Server
  alias ElixirIpc.Client

  def start() do
    {:ok, s_pid} = Server.start_link()
    {:ok, c_pid} = Client.start_link()
    %{client: c_pid, server: s_pid}
  end

  def demo() do
    %{client: c_pid, server: s_pid} = start()
    :ok = Client.send(c_pid, "hi server!")
    {:error, :timeout} = Client.recv(c_pid)
    {:ok, "hi server!"} = Server.recv(s_pid)
    {:error, :timeout} = Server.recv(s_pid)
    :ok = Server.send(s_pid, "hi client!")
    {:error, :timeout} = Server.recv(s_pid)
    {:ok, "hi client!"} = Client.recv(c_pid)
    :ok
  end
end
