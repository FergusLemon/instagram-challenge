FactoryGirl.define do  factory :comment do
    thoughts "MyString"
  end
  factory :photo do
    description "MyString"
  end

  factory :user do
    email "fergus@email.com"
    password  "password2"
    password_confirmation "password2"
  end

  factory :user2, class: User do
    email "tom@email.com"
    password  "password3"
    password_confirmation "password3"
  end
end
