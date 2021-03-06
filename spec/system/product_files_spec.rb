require 'spec_helper'

describe "Product Files" do
  before do
    @product = FactoryBot.create :product
    @product_file = FactoryBot.create :product_file, viewable: @product, alt: 'Data File 1'
  end
  it "should display the link to the file" do
    visit spree.product_path(@product)
    expect(page).to have_content 'Data File 1'
  end
end
