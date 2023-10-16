require 'rake/testtask'

# Tasks
namespace :foreman_theme_satellite do
  namespace :example do
    desc 'Example Task'
    task task: :environment do
      # Task goes here
    end
  end
end

# Tests
namespace :test do
  desc 'Test ForemanThemeSatellite'
  Rake::TestTask.new(:foreman_theme_satellite) do |t|
    test_dir = File.expand_path('../../test', __dir__)
    t.libs << 'test'
    t.libs << test_dir
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
    t.warning = false
  end
end

namespace :foreman_theme_satellite do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_theme_satellite) do |task|
        task.patterns = ["#{ForemanThemeSatellite::Engine.root}/app/**/*.rb",
                         "#{ForemanThemeSatellite::Engine.root}/lib/**/*.rb",
                         "#{ForemanThemeSatellite::Engine.root}/test/**/*.rb"]
      end
    rescue
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_theme_satellite'].invoke
  end
end

Rake::Task[:test].enhance ['test:foreman_theme_satellite']

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task['jenkins:unit'].enhance ['test:foreman_theme_satellite', 'foreman_theme_satellite:rubocop']
end
