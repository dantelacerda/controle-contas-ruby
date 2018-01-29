class AddStatusToHistoricos < ActiveRecord::Migration[5.1]
  def change
    add_column :historicos, :status, :string
  end
end
