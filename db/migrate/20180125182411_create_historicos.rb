class CreateHistoricos < ActiveRecord::Migration[5.1]
  def change
    create_table :historicos do |t|
      t.references :contaorigem , foreign_key: true
      t.references :contadestino, foreign_key: true
      t.date :datatransacao
      t.string :tipotransacao
      t.string :aporte
      t.bigint :valor

      t.timestamps
    end
  end
end
