@user = User.create(email: "test@test.com", 
                          password: '123456', 
                          password_confirmation: '123456',
                          first_name: 'Jon',
                          last_name: 'snow')
puts '1 user created'

100.times do |post|
    Post.create(date: Date.today, rationale: "#{post} rationale content", user_id:@user.id)
end 
puts "100 posts created"