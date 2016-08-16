class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about]

  def home
    # Geocoder gem provides additional method to request like location
    @city = request.location.city #Will return in english Lisbon
  end

  def about
  end

end
