# メインユーザーを登録しておく
User.create!(name:  "Sato",
             email: "satomi.haruna1124@gmail.com",
             password:              "ss4649hh00",
             password_confirmation: "ss4649hh00",
             introduction: "自己紹介を入力しましょう!",
             image_id: "duck.jpg")

# カテゴリーは3種類
Category.create!(category_name: "バックエンド")
Category.create!(category_name: "フロントエンド")
Category.create!(category_name: "インフラ")

# スキル サンプルデータ
[
  [1, 1, "Ruby",       40],
  [1, 1, "Rails",      40],
  [1, 1, "MySQL",      30],
  [1, 2, "HTML",       50],
  [1, 2, "CSS",        50],
  [1, 2, "JavaScript", 20],
  [1, 3, "Heroku",     30],
  [1, 3, "AWS",        40],
  [1, 3, "Firebase",   40]
].each do |user_id, category_id, skill_name, level|
  Skill.create!(
    { user_id: user_id, category_id: category_id, skill_name: skill_name, level: level }
  )
end
