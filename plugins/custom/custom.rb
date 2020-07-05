$:.unshift File.dirname(__FILE__)

module AresMUSH
  module Custom
    def self.plugin_dir
      File.dirname(__FILE__)
    end
 
    def self.shortcuts
      Global.read_config("custom", "shortcuts")
    end
 
    def self.get_cmd_handler(client, cmd, enactor)      
      case cmd.root
      when "hooks"
        case cmd.switch
        when "set"
          return SetHooksCmd
        else
          return ViewHooksCmd
        end
      end
      return nil
    end
  end
end
