class AddAutorToCadastros < ActiveRecord::Migration[5.1]
  def change
  	add_column :cadastros, :autor, :string
  end
end
