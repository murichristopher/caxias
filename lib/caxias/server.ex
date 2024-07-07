defmodule Caxias.Server do
  use GenServer
  alias Caxias.Box
  alias Caxias.Entry

  def init(_) do
    {:ok, Caxias.Box.new()}
  end

  def start do
    GenServer.start(__MODULE__, nil)
  end

  def add_entry(pid, %Entry{} = entry) do
    GenServer.cast(pid, {:add_entry, entry})
  end

  def entries(pid) do
    GenServer.call(pid, :entries)
  end

  def entry_by_id(pid, id) do
    GenServer.call(pid, {:entry_by_id, id})
  end

  def update_entry(pid, %Entry{} = entry, updater) do
    GenServer.cast(pid, {:update_entry, entry, updater})
  end

  def handle_call(:entries, _from, state) do
    {:reply, Box.entries(state), state}
  end

  def handle_call({:entry_by_id, id}, _from, state) do
    {:reply, Box.entry_by_id(state, id), state}
  end

  def handle_cast({:add_entry, %Entry{} = entry}, state) do
    {:noreply, Box.add_entry(state, entry)}
  end

  def handle_cast({:update_entry, %Entry{} = entry, updater}, state) do
    {:noreply, Box.update_entry(state, entry, updater)}
  end

  def handle_info(_, state) do
    {:noreply, state}
  end
end
