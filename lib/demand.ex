defmodule Demand do
  @moduledoc """
  Documentation for `Demand`.
  """

  def owner(key) do
    GenServer.call(Demand.Worker, {:owner, key})
  end
end
