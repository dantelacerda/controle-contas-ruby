class CreateConta < ActiveRecord::Migration[5.1]
  def change
    create_table :conta do |t|
      t.string :nome
      t.integer :numero
      t.bigint :saldo
      t.string :tipoconta
      t.date :datacriacao
      t.string :situacao
      t.references :conta,foreign_key: true, null: true
      t.references :cliente, foreign_key: true
      
      t.timestamps
    end
  end
end
