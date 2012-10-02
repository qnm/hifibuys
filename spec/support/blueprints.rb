require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

Item.blueprint do
  name { "Product #{sn}" }
  url { Faker::Internet.domain_name }
end

Entity.blueprint do
  category { "Category #{sn}" }
  name { "Name #{sn}" }
end
