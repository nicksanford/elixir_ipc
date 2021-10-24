defmodule ElixirIpc.Server do
  use GenServer
  defstruct [:socket, :path, :send_timeout, :recv_timeout, :accept_timeout]

  def start_link(opts) do
    state = %__MODULE__{
      path: Keyword.get(opts, :path, "/tmp/elixir_test.ipc"),
      send_timeout: Keyword.get(opts, :send_timeout, 4000),
      accept_timeout: Keyword.get(opts, :accept_timeout, 4000),
      recv_timeout: Keyword.get(opts, :recv_timeout, 4000)
    }

    GenServer.start_link(__MODULE__, state)
  end

  def send(pid, msg), do: GenServer.call(pid, {:send, msg})
  def recv(pid), do: GenServer.call(pid, :recv)

  @impl GenServer
  def init(state = %__MODULE__{path: path, send_timeout: send_timeout}) do
    File.rm(path)
    opts = [:binary, active: false, send_timeout: send_timeout, ip: {:local, path}]
    {:ok, socket} = :gen_tcp.listen(0, opts)
    {:ok, %__MODULE__{state | socket: socket}, {:continue, :accept}}
  end

  @impl GenServer
  def handle_continue(
        :accept,
        state = %__MODULE__{socket: listening_socket, accept_timeout: accept_timeout}
      ) do
    {:ok, socket} = :gen_tcp.accept(listening_socket, accept_timeout)
    {:noreply, %__MODULE__{state | socket: socket}}
  end

  @impl GenServer
  def handle_call({:send, packet}, _from, state = %__MODULE__{socket: socket}) do
    {:reply, :gen_tcp.send(socket, packet), state}
  end

  @impl GenServer
  def handle_call(:recv, _from, state = %__MODULE__{socket: socket, recv_timeout: recv_timeout}) do
    {:reply, :gen_tcp.recv(socket, 0, recv_timeout), state}
  end

  @impl GenServer
  def terminate(_reason, %__MODULE__{path: path, socket: socket}) do
    :gen_tcp.close(socket)
    File.rm(path)
    :ok
  end
end
