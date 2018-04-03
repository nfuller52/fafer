Dir[Rails.root.join("db/seeds/**/*_seed.rb")].each { |f| require f }
