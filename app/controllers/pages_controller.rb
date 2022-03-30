class PagesController < ApplicationController
  def dashboard
    render locals: {
      donations: Donation.order(created_at: :asc).last(5),
      donation_total: Donation.sum(:amount),
    }
  end
end
