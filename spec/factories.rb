FactoryGirl.define do
  factory :user do |user|
    user.name                   "rvc"
    user.email                  "rvc@rvc.com"
    user.password               "rvc123"
    user.password_confirmation  "rvc123"
  end
end