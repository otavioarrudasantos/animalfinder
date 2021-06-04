class SeenController < ApplicationController
    before_action :set_seen, only: %i[ show edit update destroy ]
    before_action :set_pet, only: [ :new, :show, :edit, :update, :destroy, :create ]
    before_action :authenticate_user!, except: [:new, :create]
    # before_action :correct_user, only: [:destroy]
  
    # GET /pets/1/seen 
    def index
      @pets = Pet.where(user_id: current_user.id, id: params[:pet_id])
    end
  
    # GET /pets/1 or /pets/1.json
    def show
    end
  
    # GET /pets/new
    def new
        @seen = Seen.new
    end
  
    # GET /pets/1/edit
    def edit
    end
  
    # POST /pets or /pets.json
    def create
      # @pet = Pet.new(pet_params)
      @seen = @pet.seens.build(seen_params)
      
      respond_to do |format|
        if @seen.save
          @pet.status = 1
          @pet.save
          format.html { redirect_to root_path, notice: "Seen was successfully created." }
          format.json { render :show, status: :created, location: @seen }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @seen.errors, status: :unprocessable_entity }
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
      @seen.destroy
      @all_seens = Seen.where(pet_id: :pet_id )
      if @all_seens.blank?
        @pet.status = 0
        @pet.save
      end
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Seen was successfully destroyed." }
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
        @pet = Pet.find(params[:pet_id])
      end

      def set_seen
        @seen = Seen.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
    #   def pet_params
    #     params.require(:seen).permit(:nome, :telefone, :pet_id)
    #   end

      def seen_params
        params.require(:seen).permit(:nome, :telefone, :pet_id)
      end
  end
  