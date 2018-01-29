class CreateClientes < ActiveRecord::Migration[5.1]
  def change
    create_table :clientes do |t|
      t.string :nome
      t.string :tipocliente
      t.date :data
      t.string :cpfcnpj
      t.string :nomefantasia

      t.timestamps
    end
  end
end
