require 'faker'

namespace :fake_data do

  desc 'generate fake cats for all users'
  task generate: :environment do
    User.all.each do |user|
      10.times do
        ct = user.cats.new
        ct.cat_type_id = Faker::Number.between(1,5)
        ct.location_id = Faker::Number.between(1,4)
        ct.name = Faker::Pokemon.name
        ct.age = Faker::Number.between(1,15)
        ct.color = Faker::Color.color_name
        ct.gender = Faker::Boolean.boolean ? 1 : 0
        ct.hyperactivity = Faker::Number.between(1,3)
        ct.health = Faker::Number.between(1,5)
        ct.about = Faker::Lorem.paragraph(3)
        ct.save
      end
    end
  end
end
