task sample_data: :environment do
  p "creating sample data"
  
  if Rails.env.development?
    FollowRequest.destroy_all
    User.destroy_all
  end 

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

  users = User.all
  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample 
        )
      end
      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample 
        )
      end
    end
  end
  p "#{FollowRequest.count} follow requests have been created"
  # create a bunch of photos for each user
  users.each do |user|
    rand(3..7).times do 
      user.own_photos.create(
        caption: Faker::Quote.famous_last_words,
        image: "https://robohash.org/#{rand(1..100)}.png"
      )
    end
  end
  p "#{Photo.count} photos have been created"
end
