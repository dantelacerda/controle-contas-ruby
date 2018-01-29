class Contum < ApplicationRecord
  belongs_to :conta, optional: true
  has_one :cliente
  has_many :historicos
  
end
