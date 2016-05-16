Factory.define :user do |user|
  user.first_name 'John'
  user.last_name  'Doe'
  user.email 'test1@1.com'
  user.password 'toto'
  user.password_confirmation 'toto'
  user.single_access_token "xYz0odTRdEoooEEE"
end

Factory.define :user2, :class=>:user do |user|
  user.first_name 'John2'
  user.last_name  'Doe2'
  user.email 'test2@2.com'
  user.password 'toto'
  user.password_confirmation 'toto'
  user.single_access_token "zzzxYz0odTRdEoooEEE"
end

Factory.define :profile, :class=>:profile do |profile|
  profile.user {|u| u.association(:user) }
  profile.city 'Paris'
  profile.country 'France'
  profile.statuses []
end

Factory.define :profile2, :class=>:profile do |profile|
  profile.user {|u| u.association(:user2) }
  profile.city 'Paris'
  profile.country 'France'
  profile.statuses []
end

Factory.define :status do |status|
  status.message 'Mon statut'
end

