module AresMUSH
  module Login
    class Create
      include AresMUSH::Plugin

      def want_anon_command?(cmd)
        cmd.root_is?("create")
      end

      def on_command(client, cmd)      
        args = cmd.crack_args!(/(?<name>\S+) (?<password>\S+)/)
        
        if (args.nil?)
          client.emit_failure(t('login.invalid_create_syntax'))
          return
        end
        
        name = args[:name]
        password = args[:password]
        
        existing_player = Player.find_by_name(name)
        if (!existing_player.empty?)
          client.emit_failure(t('login.player_name_taken'))
          return
        end
          
          player = Player.create("name" => name, "password" => password)
          client.emit_success(t('login.player_created', :name => name))
          client.player = player
          container.dispatcher.on_event(:player_created, :client => client)
      end
    end
  end
end
