unless Rails.env.production?
  title = "SEEDING #{Rails.env.upcase}"
  line_length = 79
  padding = (line_length - 8 - title.length) / 2
  printf(("#" * line_length) + "\n")
  printf("####" + (" " * padding) + "%s" + (" " * padding) + "####\n", title)
  printf(("#" * line_length) + "\n\n")

  Dir[Rails.root.join("db/seeds/**/*_seed.rb")].each { |f| require f }
end
