namespace :pinas do
  desc "Load Philippines locations, includes Region, provinces, towns and barangays"
  task :load_data => :environment do
    Pinas::Loader.run
  end
end