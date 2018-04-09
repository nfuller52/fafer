# require 'coveralls'
# Coveralls.wear!
if ENV["CI"]
  require "codeclimate-test-reporter"
  SimpleCov.start "rails" do
    formatter SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      CodeClimate::TestReporter::Formatter
    ]
  end
else
  require "simplecov"
  SimpleCov.start "rails"
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.default_formatter = "doc" if config.files_to_run.one?
  config.order = :random
  Kernel.srand config.seed
  # config.example_status_persistence_file_path = "spec/examples.txt"
  # config.profile_examples = 10
end
