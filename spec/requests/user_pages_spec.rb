require 'spec_helper'

describe "User pages" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/welcome/index'
      expect(page).to have_content('Sample App')
    end
  end
end