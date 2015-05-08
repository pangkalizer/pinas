namespace :pinas do
  desc "Load Philippines locations, includes Region, provinces, towns and barangays"
  task :load_data => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE locations")
    sql = File.read(File.expand_path("../../pinas/data/locations.sql", __FILE__))
    sql.split(';').each do |sql_statement|
      ActiveRecord::Base.connection.execute(sql_statement) unless sql_statement.blank?
    end
  end
end