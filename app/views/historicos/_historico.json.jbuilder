json.extract! historico, :id, :contaorigem, :contadestino, :datatransacao, :tipotransacao, :aporte, :valor, :created_at, :updated_at
json.url historico_url(historico, format: :json)
