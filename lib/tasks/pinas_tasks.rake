require 'fileutils'

namespace :pinas do
  desc "Load Philippines locations, includes Region, provinces, towns and barangays"
  task :load_data => :environment do
    data_file = File.expand_path("../../pinas/data/data.yml", __FILE__)
    data_dir = "#{Rails.root}/db/"
    FileUtils.cp(data_file, data_dir)
    Rake::Task["db:data:load"].execute
    File.delete("#{data_dir}data.yml")
  end
end