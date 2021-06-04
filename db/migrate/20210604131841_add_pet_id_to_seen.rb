class AddPetIdToSeen < ActiveRecord::Migration[6.1]
  def change
    add_column :seens, :ped_id, :integer
    add_index :seens, :ped_id
  end
end
