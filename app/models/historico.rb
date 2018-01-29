class Historico < ApplicationRecord
  belongs_to :contaorigem, :class_name => "Contum"
  belongs_to :contadestino, :class_name => "Contum"
end
