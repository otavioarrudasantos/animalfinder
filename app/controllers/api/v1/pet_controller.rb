module Api 
    module V1
        class PetController < ApplicationController
            def index
                pets = Pet.order('created_at DESC')
                
                render json: pets, include: ['photo'], status: :ok
            end
            def show
                pet = Pet.find(params[:id])
                pet_hash = pet.as_json
                if pet.photo.attached?
                    pet_hash['photo_url'] = url_for(pet.photo)
                else
                    pet_hash['photo_url'] = ''
                end
                pet = pet_hash.to_json
                render json: pet, status: :ok
            end
        end
    end
end