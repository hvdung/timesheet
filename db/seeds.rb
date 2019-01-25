100.times do |n|
  first_name  = Faker::Name.first_name
  last_name  = Faker::Name.last_name
  email = "example#{n+1}#{ENV["EMAIL_SUFFIX"]}"
  password = "123456"
  User.create_with(first_name: first_name,
                   last_name: last_name,
                   password: password,
                   password_confirmation: password,).find_or_create_by(email: email)
end
