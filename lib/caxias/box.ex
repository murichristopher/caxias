defmodule Caxias.Box do
  alias Caxias.Box
  alias Caxias.Entry

  defstruct auto_id: 1, entries: %{}

  def new, do: %Box{}

  def add_entry(%Box{auto_id: auto_id, entries: entries} = box, %Entry{} = entry) do
    entry = Map.put(entry, :id, auto_id)

    new_entries = Map.put(entries, auto_id, entry)

    %Box{box | entries: new_entries, auto_id: auto_id + 1}
  end

  def entries(%Box{entries: entries}) do
    Map.values(entries)
  end

  def entry_by_id(%Box{} = box, id) do
    entries(box)
    |> Enum.find(fn entry -> entry.id == id end)
  end

  def update_entry(%Box{entries: entries} = box, %Entry{} = entry, updater) do
    case Map.get(entries, entry.id) do
      nil ->
        box

      %Entry{} = entry ->
        updated_entry = updater.(entry)

        new_entries = Map.put(entries, entry.id, updated_entry)

        %Box{box | entries: new_entries}
    end
  end
end

# {:ok, pid} = Caxias.Server.start()

# Caxias.Server.entries(pid)

# entry = Caxias.Entry.new("teste2", :debit, 2.5)

# Caxias.Server.add_entry(pid, entry)

# # entry2 = Caxias.Entry.new("teste2", :debit, 10.5)

# # box = Caxias.Box.add_entry(box, entry)
# # box = Caxias.Box.add_entry(box, entry2)

# # entry = Caxias.Box.entry_by_id(box, 1)

# # box = Caxias.Box.update_entry(box, entry, &Map.put(&1, :description, "novo teste"))

# # dbg(box)
