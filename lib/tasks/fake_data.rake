namespace :fake_data do

  desc 'generate fake cats for all usersss'
  task :generate do
    User.all.each do |user|
      10.times do
        ct = Cat.new
        ct.name = Faker::Name.first_name
        ct.color = Faker::Commerce.color
      end
    end
  end
end
