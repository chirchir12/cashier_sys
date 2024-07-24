defmodule CashierSys.Product do
  @moduledoc """
  the `CashierSys.Product` module handles the products available in the supermarket
  """
  defstruct code: "", name: "", price: 0.0

  @doc """
  Returns a list of all available products

  ## Examples
    iex> CashierSys.Product.list_products()
    [
      %CashierSys.Product{code: "GR1", name: "Green tea", price: 3.11},
      %CashierSys.Product{code: "SR1", name: "Strawberries", price: 5.00},
      %CashierSys.Product{code: "CF1", name: "Coffee", price: 11.23}
    ]
  """
  @spec list_products() :: [%__MODULE__{}]
  def list_products do
    [
      %__MODULE__{code: "GR1", name: "Green tea", price: 3.11},
      %__MODULE__{code: "SR1", name: "Strawberries", price: 5.00},
      %__MODULE__{code: "CF1", name: "Coffee", price: 11.23}
    ]
  end

  @doc """
  Return the product with the given code

  ## Examples

    iex> CashierSys.Product.get_product("GR1")
      %CashierSys.Product{code: "GR1", name: "Green tea", price: 3.11}

    iex> YourApp.Product.get_product("NON_EXISTENT_CODE")
    nil
  """
  @spec get_product(String.t()) :: %__MODULE__{} | nil
  def get_product(code) do
    Enum.find(list_products(), fn product -> product.code == code end)
  end
end
