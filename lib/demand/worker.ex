defmodule Demand.Worker do
  use GenServer

  require Logger

  @weight 2

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    ring = HashRing.new(Node.self(), @weight)

    # Monitor new node subscriptions
    :ok = :net_kernel.monitor_nodes(true, node_type: :all)

    {:ok, %{ring: ring}}
  end

  def handle_call({:owner, key}, _from, state) do
    {:reply, HashRing.key_to_node(state.ring, key), state}
  end

  def handle_info({:nodeup, node, _info}, state) do
    Logger.debug("Node #{inspect node} has joined")

    {:noreply, dbg(update_in(state.ring, &HashRing.add_node(&1, node, @weight)))}
  end

  def handle_info({:nodedown, node, _info}, state) do
    Logger.debug("Node #{inspect node} has left")

    {:noreply, update_in(state.ring, &HashRing.remove_node(&1, node))}
  end

end
