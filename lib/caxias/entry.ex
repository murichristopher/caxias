defmodule Caxias.Entry do
  defstruct [:id, :description, :type, :value]

  @type t :: %__MODULE__{
          id: integer(),
          description: String.t(),
          type: :debit | :credit,
          value: float()
        }

  @spec new(String.t(), :debit | :credit, float()) :: t()
  def new(description, type, value) when type in [:debit, :credit] and is_float(value) do
    %__MODULE__{
      id: nil,
      description: description,
      type: type,
      value: value
    }
  end

  def new(_description, _type, _value) do
    {:error, "Invalid type or value. Type must be :debit or :credit, and value must be a float."}
  end
end
