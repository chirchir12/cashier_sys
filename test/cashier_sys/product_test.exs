defmodule CashierSys.ProductTest do
  use ExUnit.Case
  alias CashierSys.Product

  test "list products" do
    products = Product.list_products()
    assert length(products) == 3

    # let get products codes
    product_codes = Enum.map(products, & &1.code)

    # ensute our products exists
    assert "GR1" in product_codes
    assert "SR1" in product_codes
    assert "CF1" in product_codes
  end


  test "get product by code" do
    product = Product.get_product("GR1")

    assert product != nil
    assert product.code == "GR1"
    assert product.name == "Green tea"
    assert product.price == Decimal.new("3.11")

  end




end
