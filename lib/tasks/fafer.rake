unless Rails.env.production? || Rails.env.staging?
  require 'rspec/core/rake_task'

  namespace :fafer do
    desc 'Simple way to setup the project'
    task setup: ["db:create", "db:migrate", "db:seed"]

    desc 'Reset and seed the database'
    task reset: ["db:migrate:reset", "db:seed"]

    namespace :ci do
      desc 'Run test suite'
      task tests: [:spec]
    end
  end
end
