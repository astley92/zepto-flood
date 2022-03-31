class PagesController < ApplicationController
  def dashboard
    render locals: {
      donations: Donation.order(created_at: :desc).first(5),
      donation_total: Donation.sum(:amount),
    }
  end
end
