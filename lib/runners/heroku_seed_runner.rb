# frozen_string_literal: true

require 'heroku_seeder'

ActiveRecord::Base.logger = Logger.new($stdout)

HerokuSeeder.run
