require "faker"

3.times do
  u = User.create!(email: Faker::Internet.unique.email, password: "password123")
  u.posts.create!(body: Faker::Quote.famous_last_words)
end

puts "Users: #{User.count}, Posts: #{Post.count}"
