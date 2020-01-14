# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email: 'yamada@gmail.com',
   password: '000000',
   name: '山田太郎',
   name_kana: 'ヤマダタロウ',
  )


User.create!(
   email: 'hanako@gmail.com',
   password: '000000',
   name: '山田花子',
   name_kana: 'ヤマダハナコ',
)


Genre.create!(
   genre_name: 'ラーメン',
   created_at: "2019-06-09 05:58:56",
   updated_at: "2019-06-09 05:58:57"
)

Want.create!(
   user_id: 1,
   restaurant_id: 1
)


Repeat.create!(
   user_id: 1,
   restaurant_id: 1
)
