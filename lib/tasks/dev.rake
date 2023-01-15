task sample_data: :environment do
  starting = Time.now
  p "creating sample data"
  if Rails.env.development?
    p "destroying previous data"
    Like.destroy_all
    p "#{Like.count} likes remain"
    Comment.destroy_all
    p "#{Comment.count} comments remain"

    Photo.destroy_all
    p "#{Photo.count} photos remain"

    FollowRequest.destroy_all
    p "#{FollowRequest.count} follow requests remain"

    User.destroy_all
    p "#{User.count} users remain"

  end 

  p "creating new users"
  
  usernames = Array.new { Faker::Name.first_name }

  usernames << "matt"
  usernames << "alice"
  usernames << "bob"
  10.times do |username|
    usernames << Faker::Name.first_name
  end

  usernames.each do |username|
    name = Faker::Name.first_name
    u = User.create(
      email: "#{username}@example.com",
      username: username.downcase,
      password: "password",
      private: [true,false].sample
    )
    p u.errors.full_messages
    # n = User.new
    # n.email = Faker::Internet.email
    # n.username = Faker::Internet.username(specifier: 5..8)
    # n.save
  end

  users = User.all
  p "adding follow requests"
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
  # create a bunch of photos for each user
  p "adding photos, likes and comments"
  users.each do |user|
    rand(15).times do 

      photo = user.own_photos.create(
        caption: Faker::Quote.famous_last_words,
        image: "https://robohash.org/#{rand(9999)}"
      )

      user.followers.each do |follower|
        # adds likes to each added photo above
        if rand < 0.8
          n = Like.new
          n.fan = follower
          n.photo = photo
          n.save
          # photo.fans << follower # shovel operator pushes into the likes table
        end

        # adds comments to each photo above one by one
        if rand < 0.33
          photo.comments.create(
            body: Faker::Quote.jack_handey,
            author: follower
          )
        end
      end

    end
  end

  ending = Time.now
  p "it took #{(ending - starting).to_i} seconds to create sample data"
  p "#{FollowRequest.count} follow requests have been created"
  p "#{User.count} users have been created"
  p "#{Photo.count} photos have been created"
  p "#{Like.count} likes have been liked"
  p "#{Comment.count} comments have been made"


end
