class SeenController < ApplicationController
    before_action :set_seen, only: %i[ show edit update destroy ]
    before_action :set_pet, only: [ :new, :show, :edit, :update, :destroy, :create ]
    before_action :authenticate_user!, except: [:new, :create]
   
    def new
        @seen = Seen.new
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
 
    def destroy
      @seen.destroy
      @all_seens = Seen.where(pet_id: params[:pet_id] )

      if @all_seens.blank?
        @pet.status = 0
        @pet.save
      end
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Seen was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_pet
        @pet = Pet.find(params[:pet_id])
      end

      def set_seen
        @seen = Seen.find(params[:id])
      end
  
      def seen_params
        params.require(:seen).permit(:nome, :telefone, :pet_id)
      end
  end
  