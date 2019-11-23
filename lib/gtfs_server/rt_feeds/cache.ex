defmodule GtfsServer.RtFeeds.Cache do
  use GenServer

  @default_name TrimetVehiclePositionsCache

  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :name, @default_name)
    table_name = Keyword.fetch!(opts, :name)

    GenServer.start_link(__MODULE__, table_name, opts)
  end

  def init(table) do
    cache = :ets.new(table, [:named_table, :set, :protected, read_concurrency: true])
    {:ok, cache}
  end

  @doc """
    Check if a key is already in the cache. Returns
  """
  def lookup(key, cache) do
    case :ets.lookup(cache, key) do
      [{^key}] -> false
      [] -> true
    end
  end

  def insert(key, name \\ @default_name) do
    GenServer.call(name, {:insert, key})
  end

  def handle_call({:insert, key}, _from, cache) do
    :ets.insert(cache, {key})
    {:reply, :ok, cache}
  end
end
