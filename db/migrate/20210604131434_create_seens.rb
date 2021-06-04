class CreateSeens < ActiveRecord::Migration[6.1]
  def change
    create_table :seens do |t|
      t.string :nome
      t.string :telefone

      t.timestamps
    end
  end
end
