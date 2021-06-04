class AddTelefoneToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :telefone, :string
  end
end
