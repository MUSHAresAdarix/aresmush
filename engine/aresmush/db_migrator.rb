module AresMUSH
  class DatabaseMigrator
    attr_accessor :messages
    
    def migrate(mode)
      path = File.join(AresMUSH.root_path, "install", "migrations")
      migrations = Dir["#{path}/*.rb"].sort
      applied_migrations_path = File.join(path, 'applied.txt')
      self.messages = []
      if (File.exist?(applied_migrations_path))
        applied_migrations = File.readlines(applied_migrations_path).map { |l| l.chomp }
      else
        applied_migrations = []
      end
      
      migrations.each do |file|
        migration_name = File.basename(file, ".rb")
        if applied_migrations.include?(migration_name)
          Global.logger.info "Migration #{migration_name} already applied."
          next
        end
        
        Global.logger.info "Applying migration #{migration_name}"
        
        load file
        
        migrator_class = find_migrator_class(migration_name)
        migrator = migrator_class.new
        
        if (migrator.require_restart && mode == :online)
          raise "Migration #{migration_name} requires a restart.  You can't run it while the game is running.  Shut down and use bin/migrate instead."
        end
        
        migrator.migrate

        applied_migrations << migration_name
        
        Global.logger.info "Migration #{migration_name} applied."
      end

      File.open(applied_migrations_path, 'w') do |file|
        file.write applied_migrations.join("\n")
      end
      
      Global.logger.info "Migrations complete."
    end
      
    def find_migrator_class(migration_name)
      search = migration_name.after("_").camelize
      search = "Migration#{search}"
      class_name = AresMUSH::Migrations.constants.select { |c| c.upcase == search.to_sym.upcase }.first
      if (!class_name)
        raise "Migration #{migration_name} appears to be misnamed.  The migrator class can't be found."
      end
        
      Object.const_get("AresMUSH::Migrations::#{class_name}")
    end
    
    
    def self.read_config_file(file)
      YAML::load( File.read(File.join(AresMUSH.root_path, "game", "config", file)))
    end
    
    def self.read_distr_config_file(file)
      YAML::load( File.read(File.join(AresMUSH.root_path, "game.distr", "config", file)))
    end
    
    def self.write_config_file(file, config_hash)
      path = File.join(AresMUSH.root_path, "game", "config", file)
      File.open(path, 'w') do |f|
        f.write(config_hash.to_yaml)
      end
    end
  end
end