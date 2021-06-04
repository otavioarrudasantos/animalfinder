class HomeController < ApplicationController
  def index
    @pets = Pet.where(status: 0).paginate(page: params[:page], per_page:10)
  end
end
