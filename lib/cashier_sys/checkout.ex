defmodule CashierSys.Checkout do
  @moduledoc """
  The `CashierSys.Checkout` module handles the checkout process for the supermarket
  """
  alias CashierSys.Product

  defstruct items: []

  @doc """
  Returns empty busket
  Examples

    iex> CashierSys.Checkout.new()
    %CashierSys.Checkout{items: []}
  """
  @spec new() :: %__MODULE__{items: []}
  def new do
    %__MODULE__{}
  end

  @doc """
    Adds item to a busket and retun the busket

    ## Examples

      iex> busket = CashierSys.Checkout.new()
      iex> busket = CashierSys.Checkout.add_item(busket, "GR1")
      %CashierSys.Checkout{items: [%CashierSys.Product{code: "GR1", name: "Green tea", price: 3.11}]}
  """
  @spec add_item(%__MODULE__{}, String.t()) :: %__MODULE__{}
  def add_item(%__MODULE__{items: items} = busket, code) do
    product = Product.get_product(code)
    %__MODULE__{busket | items: [product | items]}
  end

  @doc """
  Calculate total price of all the items in the busket, including discounts

  ## Examples

      iex> busket = CashierSys.Checkout.new()
      iex> busket = CashierSys.Checkout.add_item(busket, "GR1")
      iex> CashierSys.Checkout.total(checkout)
      3.11

  """

  @spec total(%__MODULE__{}) :: float
  def total(%__MODULE__{items: items}) do
    items
    |> Enum.group_by(& &1.code)
    |> Enum.map(&apply_discounts/1)
    |> Enum.sum()
    |> Float.round(2)
  end

  defp apply_discounts({"CF1", products}) do
    price_drop(products, 3, 2 / 3)
  end

  defp apply_discounts({"SR1", products}) do
    bulk_discount(products, 3, 4.50)
  end

  defp apply_discounts({"GR1", products}) do
    buy_one_get_one_free(products)
  end

  defp apply_discounts({_code, products}) do
    Enum.sum(Enum.map(products, &get_product_price/1))
  end

  defp bulk_discount(products, threshhold, discount_price) do
    if length(products) >= threshhold do
      length(products) * discount_price
    else
      Enum.sum(Enum.map(products, &get_product_price/1))
    end
  end

  defp price_drop(products, threshold, discount_rate) do
    if length(products) >= threshold do
      Enum.sum(Enum.map(products, &get_product_price/1)) * discount_rate
    else
      Enum.sum(Enum.map(products, &get_product_price/1))
    end
  end

  defp buy_one_get_one_free(products) do
    Enum.chunk_every(products, 2)
    |> Enum.map(fn
      [product, _product] -> product.price
      [product] -> product.price
    end)
    |> Enum.sum()
  end

  defp get_product_price(%Product{price: price}) do
    price
  end

  defp get_product_price(_) do
    0
  end
end
