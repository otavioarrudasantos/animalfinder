class HomeController < ApplicationController
  def index
    @pets = Pet.where.not(status: 2)
  end
end
