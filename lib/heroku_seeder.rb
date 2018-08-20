class HerokuSeeder
  def self.run

    user1 = User.where(
      email: 'michael@bluespot.io'
    ).first_or_create(
      username: 'Michael',
      password: 'password'
    )

    user2 = User.where(
      email: 'neil@bluespot.io'
    ).first_or_create(
      username: 'Neil',
      password: 'password'
    )

    collection1 = Collection.where(
      name: 'Dog Collection'
    ).first_or_create(
      user_id: user1.id
    )

    Collection.where(
      name: 'Cat Collection'
    ).first_or_create(
      user_id: user2.id
    )

    topic1 = Topic.where(
      name: 'Dalmatian'
    ).first_or_create(
      user_id: user1.id
    )

    topic2 = Topic.where(
      name: 'Poodle'
    ).first_or_create(
      user_id: user1.id
    )

    Topic.where(
      name: 'Siamese'
    ).first_or_create(
      user_id: user2.id
    )

    Topic.where(
      name: 'Bengal'
    ).first_or_create(
      user_id: user2.id
    )

    collection1.topics << topic1 unless collection1.topics.include?(topic1)
    collection1.topics << topic2 unless collection1.topics.include?(topic2)
  end
end
