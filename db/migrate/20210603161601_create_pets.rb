class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.string :nome
      t.integer :idade
      t.text :info_extra
      t.string :cidade
      t.string :estado
      t.integer :status

      t.timestamps
    end
  end
end
