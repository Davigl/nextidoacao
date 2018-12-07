class CreateRelatorios < ActiveRecord::Migration[5.1]
  def change
    create_table :relatorios do |t|
      t.date :data_inicio
      t.date :data_final
      t.string :nome_arquivo
      t.references :user, foreign_key: true
      t.references :instituicao, foreign_key: true

      t.timestamps
    end
  end
end
