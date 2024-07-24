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

  test "calculate total for a basket of products" do
    busket =
      Checkout.new()
      |> Checkout.add_item("GR1")
      |> Checkout.add_item("SR1")
      |> Checkout.add_item("GR1")
      |> Checkout.add_item("GR1")
      |> Checkout.add_item("CF1")

    assert Checkout.total(busket) == 22.45
  end

  test "calculates total for GR1 buy-one-get-one-free offer" do
    checkout =
      Checkout.new()
      |> Checkout.add_item("GR1")
      |> Checkout.add_item("GR1")

    assert Checkout.total(checkout) == 3.11
  end

  test "calculates total for SR1 bulk discount" do
    busket =
      Checkout.new()
      |> Checkout.add_item("SR1")
      |> Checkout.add_item("SR1")
      |> Checkout.add_item("GR1")
      |> Checkout.add_item("SR1")

    assert Checkout.total(busket) == 16.61
  end

  test "calculates total for CF1 price drop" do
    busket =
      Checkout.new()
      |> Checkout.add_item("GR1")
      |> Checkout.add_item("CF1")
      |> Checkout.add_item("SR1")
      |> Checkout.add_item("CF1")
      |> Checkout.add_item("CF1")

    assert Checkout.total(busket) == 30.57
  end
end
