class HomeController < ApplicationController
  def index
    @pets = Pet.where.not(status: 2).paginate(page: params[:page], per_page:10)
  end
end
