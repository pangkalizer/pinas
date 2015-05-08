require 'rails/generators/active_record'

module Pinas
  class InstallGenerator < Rails::Generators::Base  
    include Rails::Generators::Migration
    source_root File.expand_path('../../templates', __FILE__)
    desc "Install Pinas"
    
    def install
      migration_template 'migration.rb', 'db/migrate/create_pinas_tables.rb'
      readme 'README'
    end

    def self.next_migration_number(dirname)
      ActiveRecord::Generators::Base.next_migration_number(dirname)
    end

  end
end