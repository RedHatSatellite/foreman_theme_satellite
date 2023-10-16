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
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
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

Rake::Task[:test].enhance do
  Rake::Task['test:foreman_theme_satellite'].invoke
end

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task['jenkins:unit'].enhance do
    Rake::Task['test:foreman_theme_satellite'].invoke
    Rake::Task['foreman_theme_satellite:rubocop'].invoke
  end
end
