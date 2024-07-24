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
    assert product.price == 3.11

    product = Product.get_product("SR1")
    assert product != nil
    assert product.code == "SR1"
    assert product.name == "Strawberries"
    assert product.price == 5.00

    product = Product.get_product("CF1")
    assert product != nil
    assert product.code == "CF1"
    assert product.name == "Coffee"
    assert product.price == 11.23

  end




end
