class AddNomeArquitoToInstituicao < ActiveRecord::Migration[5.1]
  def change
    add_column :instituicaos, :nome_arquivo, :string
  end
end
