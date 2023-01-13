task sample_data: :environment do
  p "creating sample data"
  12.times do 
    name = Faker::Name.first_name
    u = User.create(
      email: "#{name}@example.com",
      username: name,
      password: "password",
      private: [true,false].sample
    )
    p u.errors.full_messages
    # n = User.new
    # n.email = Faker::Internet.email
    # n.username = Faker::Internet.username(specifier: 5..8)
    # n.save
  end
  p "#{User.count} users have been created"

  

end
