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

  Composer.create!(name_kana: 'ショパン',name_lang_en:  'Chopin, Frederic',image: File.open('./public/composer_images/135.jpeg'),year_of_birth:  1810,year_of_death: 1849,reference_url: 'https://enc.piano.or.jp/persons/135',is_active: true)
  Composer.create!(name_kana:"バッハ",name_lang_en: "Bach, Johann Sebastian",image: File.open("./public/composer_images/233.jpeg"),year_of_birth: 1685,year_of_death:1750,reference_url: "https://enc.piano.or.jp/persons/233",is_active: true)
  Composer.create!(name_kana:"ラヴェル",name_lang_en: "Ravel, Maurice",image: File.open("./public/composer_images/387.jpeg"),year_of_birth: 1875,year_of_death:1937,reference_url: "https://enc.piano.or.jp/persons/387",is_active: true)
  Composer.create!(name_kana:"ベートーヴェン",name_lang_en: "Beethoven, Ludwig van",image: File.open("./public/composer_images/302.jpeg"),year_of_birth: 1770,year_of_death:1827,reference_url: "https://enc.piano.or.jp/persons/302",is_active: true)
  Composer.create!(name_kana:"リスト",name_lang_en: "Liszt, Franz",image: File.open("./public/composer_images/399.jpeg"),year_of_birth: 1811,year_of_death:1886,reference_url: "https://enc.piano.or.jp/persons/399",is_active: true)
  Composer.create!(name_kana:"ラフマニノフ",name_lang_en: "Rakhmaninov, Sergei Vasil'evich",image: File.open("./public/composer_images/392.jpeg"),year_of_birth: 1873,year_of_death:1943,reference_url: "https://enc.piano.or.jp/persons/392",is_active: true)
  Composer.create!(name_kana:"モーツァルト",name_lang_en: "Mozart, Wolfgang Amadeus",image: File.open("./public/composer_images/367.jpeg"),year_of_birth: 1756,year_of_death:1791,reference_url: "https://enc.piano.or.jp/persons/367",is_active: true)
  Composer.create!(name_kana:"プロコフィエフ",name_lang_en: "Prokof'ev, Sergei Sergeevich",image: File.open("./public/composer_images/296.jpeg"),year_of_birth: 1891,year_of_death:1953,reference_url: "https://enc.piano.or.jp/persons/296",is_active: true)
  Composer.create!(name_kana:"シューベルト",name_lang_en: "Schubert, Franz",image: File.open("./public/composer_images/129.jpeg"),year_of_birth: 1797,year_of_death:1828,reference_url: "https://enc.piano.or.jp/persons/129",is_active: true)
  Composer.create!(name_kana:"シューマン",name_lang_en: "Schumann, Robert",image: File.open("./public/composer_images/130.jpeg"),year_of_birth: 1810,year_of_death:1856,reference_url: "https://enc.piano.or.jp/persons/130",is_active: true)
  Composer.create!(name_kana:"ドビュッシー",name_lang_en: "Debussy, Claude Achille",image: File.open("./public/composer_images/196.jpeg"),year_of_birth: 1862,year_of_death:1918,reference_url: "https://enc.piano.or.jp/persons/196",is_active: true)
  Composer.create!(name_kana:"スカルラッティ",name_lang_en: "Scarlatti, Domenico",image: File.open("./public/composer_images/147.jpeg"),year_of_birth: 1685,year_of_death:1757,reference_url: "https://enc.piano.or.jp/persons/147",is_active: true)
  Composer.create!(name_kana:"ブラームス",name_lang_en: "Brahms, Johannes",image: File.open("./public/composer_images/282.jpeg"),year_of_birth: 1833,year_of_death:1897,reference_url: "https://enc.piano.or.jp/persons/282",is_active: true)
  Composer.create!(name_kana:"ハイドン",name_lang_en: "Haydn, Franz Joseph",image: File.open("./public/composer_images/219.jpeg"),year_of_birth: 1732,year_of_death:1809,reference_url: "https://enc.piano.or.jp/persons/219",is_active: true)
  Composer.create!(name_kana:"スクリャービン",name_lang_en: "Scriabin, Alexander",image: File.open("./public/composer_images/150.jpeg"),year_of_birth: 1872,year_of_death:1915,reference_url: "https://enc.piano.or.jp/persons/150",is_active: true)
  Composer.create!(name_kana:"チャイコフスキー",name_lang_en: "Tchaikovsky, Pytr Il'ich",image: File.open("./public/composer_images/178.jpeg"),year_of_birth: 1840,year_of_death:1893,reference_url: "https://enc.piano.or.jp/persons/178",is_active: true)