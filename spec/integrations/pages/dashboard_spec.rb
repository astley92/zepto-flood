require "rails_helper"

RSpec.describe "Pages#Dashboard", type: :feature do
  before do
    Donation.create!(name: "Blake Astley", amount: 50_00)
    Donation.create!(name: "John Brown", amount: 99_50)
    Donation.create!(name: "Jian Yang", amount: 45)
    Donation.create!(name: "Gilfoyle", amount: 5)
    Donation.create!(name: "Erlich", amount: 10_00)
  end

  it "displays all relevant information" do
    visit("/")

    expect(page.text).to include("Total Raised")
    expect(page.text).to include("$160.00")
    expect(page.text).to include("Latest Donations")
    expect(page.text).to include("Blake Astley - $50.00")
    expect(page.text).to include("John Brown - $99.50")
    expect(page.text).to include("Jian Yang - $0.45")
    expect(page.text).to include("Gilfoyle - $0.05")
    expect(page.text).to include("Erlich - $10.00")

    Zepto::NotificationHandler.call(
      Zepto::Notifications::PaymentRequestApproved.new(
        name: "Anonymous",
        amount: 500_00,
        request_id: "something",
      )
    )

    # TODO: This should happen automatically without refresh
    visit(current_path)

    expect(page.text).not_to include("Blake Astley - $50.00")
    expect(page.text).to include("Anonymous - $500.00")
  end
end
