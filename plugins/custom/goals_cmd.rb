module AresMUSH
  module Custom
    class ViewHooksCmd
      include CommandHandler

      attr_accessor :name

      def parse_args
        self.name = cmd.args ? titlecase_arg(cmd.args) : enactor_name
      end

      def check_can_view
        return nil if self.name == enactor.name
        return nil if enactor.has_permission?("view_bgs")
        return "You may only view your own hooks."
      end


      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          template = BorderedDisplayTemplate.new model.hooks, "#{model.name}'s Plot Hooks"
          client.emit template.render
        end
      end
    end
  end
end
