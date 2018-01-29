json.extract! cliente, :id, :nome, :tipocliente, :data, :cpfcnpj, :nomefantasia, :created_at, :updated_at
json.url cliente_url(cliente, format: :json)
