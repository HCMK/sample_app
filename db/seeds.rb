User.create! name: "Ho Khoi",
            email: "a@a.a",
            password: "123123",
            password_confirmation: "123123",
            admin: true,
            activated: true,
            activated_at: Time.zone.now 

99.times do |n|
  name = Faker::Games::LeagueOfLegends.champion
  email = "example-#{n+1}@railstutorial.org"
  password = "123456"
  User.create! name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now
end

users = User.order(:created_at).take(6)
10.times do
  content = Faker::Sports::Football.team
  users.each { |user| user.microposts.create!(content: content) }
end
