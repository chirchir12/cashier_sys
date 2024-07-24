defmodule CashierSys.Checkout do
  alias CashierSys.Product

  defstruct items: []

  def new do
    %__MODULE__{}
  end

  def add_item(%__MODULE__{items: items} = busket, code) do
    product = Product.get_product(code)
    %__MODULE__{busket | items: [product | items]}
  end
end
