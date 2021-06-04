class FixSeenPetIdName < ActiveRecord::Migration[6.1]
  def change
    rename_column :seens, :ped_id, :pet_id
  end
end
