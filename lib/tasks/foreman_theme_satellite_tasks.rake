require 'rake/testtask'

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
  desc 'Validate documentation links against given TOC file'
  task :validate_docs do
    toc_file = ENV['TOC']
    unless toc_file
      toc_file = File.expand_path('../foreman_theme_satellite/documentation-toc.json', __dir__)
      puts "Using default TOC: #{toc_file}, to override please specify TOC=<toc_file>"
    end

    require_relative '../../test/link_checker'
    checker = LinksChecker.new(toc: toc_file)

    require_relative '../foreman_theme_satellite/documentation'

    all_links = ForemanThemeSatellite::Documentation::USER_GUIDE_DICTIONARY
                .merge(ForemanThemeSatellite::Documentation::PLUGINS_DOCUMENTATION)

    failed = all_links.filter { |_key, doc_address| doc_address.include?('/html/') && !checker.test_link(doc_address) }

    abort((failed.map { |key, doc_address| "FAILED: Cannot find #{doc_address} in TOC for entry: #{key}" } + ["Total failed: #{failed.count} entries"]).join("\n")) unless failed.empty?

    puts "Successfully tested #{all_links.count + docs_guide_mapping.each_value.sum(&:length)} links"
  end
end

Rake::Task[:test].enhance ['test:foreman_theme_satellite']
Rake::Task['test:foreman_theme_satellite'].enhance ['foreman_theme_satellite:validate_docs']
