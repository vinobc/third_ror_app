require 'faker'

namespace :db do
  desc "fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name=>"R. Vinob chander",
                 :email=>"vinobchanderr@ssn.edu.in",
                 :password=>"rvc123",
                 :password_confirmation=>"rvc123")
    admin.toggle!(:admin)
    99.times do |n|
      name=Faker::Name.name
      email="example#{n+1}@example.com"
      password="password"
      User.create!(:name=>name,
                   :email=>email,
                   :password=>password,
                   :password_confirmation=>password)
    end
  end
end
