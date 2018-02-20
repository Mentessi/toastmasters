class HerokuSeeder
  def self.run
    topic = Topic.create!(name: "Where do you live?")
  end
end

ActiveRecord::Base.logger = Logger.new($stdout)

HerokuSeeder.run
