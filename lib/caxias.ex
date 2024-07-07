defmodule Caxias do
  alias Caxias.Server
  alias Caxias.Entry

  def main(_args) do
    {:ok, pid} = Server.start()

    entry1 = Entry.new("teste1", :debit, 2.5)
    entry2 = Entry.new("teste2", :credit, 24.22)

    Server.add_entry(pid, entry1)
    Server.add_entry(pid, entry2)

    entry = Server.entry_by_id(pid, 1)

    Server.update_entry(pid, entry, &Map.put(&1, :value, 22.55))

    entries = Server.entries(pid)

    dbg(entries)
  end
end
