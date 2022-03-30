require "rails_helper"

RSpec.describe "Pages#Dashboard", type: :feature do
  before do
    Donation.create!(name: "Blake Astley", amount: 50_00)
    Donation.create!(name: "John Brown", amount: 99_50)
    Donation.create!(name: "Jian Yang", amount: 45)
    Donation.create!(name: "Gilfoyle", amount: 5)
  end

  it "displays all relevant information" do
    visit("/")

    expect(page.text).to include("Total Raised")
    expect(page.text).to include("$150.00")
    expect(page.text).to include("Latest Donations")
    expect(page.text).to include("Blake Astley - $50.00")
    expect(page.text).to include("John Brown - $99.50")
    expect(page.text).to include("Jian Yang - $0.45")
    expect(page.text).to include("Gilfoyle - $0.05")
  end
end
