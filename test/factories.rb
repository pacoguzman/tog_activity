Factory.define :user do |u|
  u.login "chavez"
  u.password {|a| a.login + "pass"}
  u.password_confirmation {|a| a.login + "pass"}
  u.activation_code '8f24789ae988411ccf33ab0c30fe9106fab32e9a'
  u.state 'pending'
  u.email {|a| "#{a.login}@example.com".downcase }
end

Factory.define :member, :parent => :user do |u|
  u.after_create {|u| u.activate! }
end

Factory.define :profile do |u|
end

Factory.define :group do |g|
  g.name 'group name'
  g.association :author, :factory => :user
  g.state 'pending'
end

Factory.define :membership do |g|
  g.state 'pending'
end

Factory.define :wall do |w|
end

Factory.define :graffity do |g|
  g.comment "Commentario del graffity"
  g.approved true
  g.spam false
end

Factory.define :activity do |f|
  f.association :author
  f.actions      'kill'
  f.association :object, :factory => :user
end