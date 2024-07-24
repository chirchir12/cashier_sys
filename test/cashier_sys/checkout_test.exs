defmodule CashierSys.CheckoutTest do
  use ExUnit.Case
  alias CashierSys.Checkout

  test "products are added to a busket" do
    busket =
      Checkout.new()
      |> Checkout.add_item("GR1")
      |> Checkout.add_item("SR1")
      |> Checkout.add_item("CF1")

    assert length(busket.items) == 3

    product_codes = Enum.map(busket.items, & &1.code)

    assert "GR1" in product_codes
    assert "SR1" in product_codes
    assert "CF1" in product_codes
  end
end
