# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180127154958) do

  create_table "clientes", force: :cascade do |t|
    t.string "nome"
    t.string "tipocliente"
    t.date "data"
    t.string "cpfcnpj"
    t.string "nomefantasia"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conta", force: :cascade do |t|
    t.string "nome"
    t.integer "numero"
    t.bigint "saldo"
    t.string "tipoconta"
    t.date "datacriacao"
    t.string "situacao"
    t.integer "conta_id"
    t.integer "cliente_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cliente_id"], name: "index_conta_on_cliente_id"
    t.index ["conta_id"], name: "index_conta_on_conta_id"
  end

  create_table "historicos", force: :cascade do |t|
    t.integer "contaorigem_id"
    t.integer "contadestino_id"
    t.date "datatransacao"
    t.string "tipotransacao"
    t.string "aporte"
    t.bigint "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["contadestino_id"], name: "index_historicos_on_contadestino_id"
    t.index ["contaorigem_id"], name: "index_historicos_on_contaorigem_id"
  end

end
