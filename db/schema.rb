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

ActiveRecord::Schema.define(version: 20180914200236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cadastros", force: :cascade do |t|
    t.string "id_cliente_enel"
    t.string "digito_verificador_cliente_enel"
    t.string "codigo_ocorrencia"
    t.date "data_ocorrencia"
    t.float "valor"
    t.integer "parcelas"
    t.text "livre"
    t.boolean "doador_ativo"
    t.integer "parcelas_controle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "instituicao_id"
    t.bigint "user_id"
    t.string "autor"
    t.index ["instituicao_id"], name: "index_cadastros_on_instituicao_id"
    t.index ["user_id"], name: "index_cadastros_on_user_id"
  end

  create_table "enderecos", force: :cascade do |t|
    t.string "logradouro"
    t.string "tipo_logradouro"
    t.string "numero"
    t.string "bairro"
    t.string "cidade"
    t.string "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "instituicao_id"
    t.index ["instituicao_id"], name: "index_enderecos_on_instituicao_id"
  end

  create_table "instituicaos", force: :cascade do |t|
    t.string "nome_instituicao"
    t.string "nome_relatorio_instituicao"
    t.string "codigo_instituicao"
    t.string "codigo_produto"
    t.string "logo"
    t.string "cnpj"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "token"
    t.string "nome_arquivo"
    t.index ["email"], name: "index_instituicaos_on_email", unique: true
  end

  create_table "relatorios", force: :cascade do |t|
    t.date "data_inicio"
    t.date "data_final"
    t.string "nome_arquivo"
    t.bigint "user_id"
    t.bigint "instituicao_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instituicao_id"], name: "index_relatorios_on_instituicao_id"
    t.index ["user_id"], name: "index_relatorios_on_user_id"
  end

  create_table "telefones", force: :cascade do |t|
    t.integer "codigo_area"
    t.string "numero"
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "instituicao_id"
    t.index ["instituicao_id"], name: "index_telefones_on_instituicao_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "login"
    t.bigint "instituicao_id"
    t.boolean "ativo"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["instituicao_id"], name: "index_users_on_instituicao_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "usuario_nextis", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "login"
    t.index ["email"], name: "index_usuario_nextis_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuario_nextis_on_reset_password_token", unique: true
  end

  add_foreign_key "cadastros", "instituicaos"
  add_foreign_key "cadastros", "users"
  add_foreign_key "enderecos", "instituicaos"
  add_foreign_key "relatorios", "instituicaos"
  add_foreign_key "relatorios", "users"
  add_foreign_key "telefones", "instituicaos"
  add_foreign_key "users", "instituicaos"
end
