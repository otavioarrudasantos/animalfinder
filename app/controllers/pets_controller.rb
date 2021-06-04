class PetsController < ApplicationController
  before_action :set_pet, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  # GET /pets or /pets.json
  def index
    @pets = Pet.where(user_id: current_user.id)
  end

  # GET /pets/1 or /pets/1.json
  def show
  end

  # GET /pets/new
  def new
    # @pet = Pet.new
    @pet = current_user.pets.build 
  end

  # GET /pets/1/edit
  def edit
    @seens = Seen.where(pet_id: params[:id])
  end

  # POST /pets or /pets.json
  def create
    # @pet = Pet.new(pet_params)
    @pet = current_user.pets.build(pet_params)

    respond_to do |format|
      if @pet.save
        format.html { redirect_to @pet, notice: "Pet was successfully created." }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pets/1 or /pets/1.json
  def update
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to @pet, notice: "Pet was successfully updated." }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pets/1 or /pets/1.json
  def destroy
    @pet.destroy
    respond_to do |format|
      format.html { redirect_to pets_url, notice: "Pet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @pet = current_user.pets.find_by(id: params[:id])
    redirect_to root_path, notice:"Não Permitido" if @pet.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pet
      @pet = Pet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pet_params
      params.require(:pet).permit(:nome, :idade, :info_extra, :cidade, :estado, :status, :photo, :user_id)
    end
end
