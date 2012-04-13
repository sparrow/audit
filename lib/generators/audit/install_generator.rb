require 'rails/generators'
require 'rails/generators/migration'

module Audit
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include ::Rails::Generators::Migration

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def self.next_migration_number(dirname)
        if ::ActiveRecord::Base.timestamped_migrations
          Time.new.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      def create_migration_file
        migration_template 'migration.rb', 'db/migrate/create_audit_tables.rb'
      end

    end
  end
end