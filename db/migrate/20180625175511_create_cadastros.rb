class CreateCadastros < ActiveRecord::Migration[5.1]
  def change
    create_table :cadastros do |t|
      t.string :id_cliente_enel
      t.string :digito_verificador_cliente_enel
      t.string :codigo_ocorrencia
      t.date :data_ocorrencia
      t.float :valor
      t.integer :parcelas
      t.text :livre
      t.boolean :doador_ativo
      t.integer :parcelas_controle

      t.timestamps
    end
  end
end
