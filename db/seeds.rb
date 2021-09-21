# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#管理者テストデータ生成する

  #admins = Admin.create([{email: 'admin@admin'},{encrypted_password: 'adminadmin'}])
  Admin.create!(
    email: ENV['ADMIN_EMAIL'],
    password: ENV['ADMIN_PASSWORD']
  )

  require "csv"

  CSV.foreach('db/composer_data.csv', headers: false) do |row|
    composer = Composer.create(
      name_kana: row[0],
      name_lang_en: row[1],
      year_of_birth: row[3],
      year_of_death: row[4],
      reference_url: "https://enc.piano.or.jp/persons/#{row[2]}",
      is_active: row[6] == "TRUE" ? true : false
      )
    if row[5] != nil
      composer.image.attach(io: File.open("db/composer_images/#{row[5]}.jpeg"), filename: "#{row[5]}.jpeg")
    end
  end