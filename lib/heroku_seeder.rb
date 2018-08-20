class HerokuSeeder
  def self.run

    user_1 = User.where(
      email: 'michael@bluespot.io'
    ).first_or_create(
      username: 'Michael',
      password: 'password'
    )

    user_2 = User.where(
      email: 'neil@bluespot.io'
    ).first_or_create(
      username: 'Neil',
      password: 'password'
    )

    collection_1 = Collection.where(
      name: 'Dog Collection'
    ).first_or_create(
      user_id: user_1.id
    )

    Collection.where(
      name: 'Cat Collection'
    ).first_or_create(
      user_id: user_2.id
    )

    topic_1 = Topic.where(
      name: 'Dalmatian'
    ).first_or_create(
      user_id: user_1.id
    )

    topic_2 = Topic.where(
      name: 'Poodle'
    ).first_or_create(
      user_id: user_1.id
    )

    Topic.where(
      name: 'Siamese'
    ).first_or_create(
      user_id: user_2.id
    )

    Topic.where(
      name: 'Bengal'
    ).first_or_create(
      user_id: user_2.id
    )

    collection_1.topics << topic_1 unless collection_1.topics.include?(topic_1)
    collection_1.topics << topic_2 unless collection_1.topics.include?(topic_2)
  end
end
