json.extract! pet, :id, :nome, :idade, :info_extra, :cidade, :estado, :status, :created_at, :updated_at
json.url pet_url(pet, format: :json)
