class AddEmailToInstituicao < ActiveRecord::Migration[5.1]
  def change
    add_column :instituicaos, :email, :string
    add_index :instituicaos, :email, unique: true
  end
end
