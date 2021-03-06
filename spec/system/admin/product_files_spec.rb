require 'spec_helper'

describe "Product Files" do
  stub_authorization!

  let(:file_path) { Spree::Core::Engine.root + "spec/fixtures/thinking-cat.jpg" }

  context "uploading, editing, and deleting a product file" do
    it "should allow an admin to upload and edit an product file for a product" do
      create(:product)

      visit spree.admin_products_path
      click_icon(:edit)
      click_link "Files"
      click_link "new_product_file_link"
      attach_file('product_file_attachment', file_path)
      click_button "Create"
      expect(page).to have_content("successfully created!")
      expect(page).to have_content('thinking-cat.jpg')

      click_icon(:edit)
      fill_in "product_file_alt", with: "data file 1"
      click_button "Update"
      expect(page).to have_content("successfully updated!")
      expect(page).to have_content("data file 1")

      page.accept_alert do
        click_icon :delete
      end
      expect(page).not_to have_content("data file 1")
    end

    it "should require the file to exist" do
      create(:product)
      visit spree.admin_products_path
      click_icon(:edit)
      click_link "Files"
      click_link "new_product_file_link"
      click_button "Create"
      expect(page).to have_content("Attachment must be present")
    end
  end


end
