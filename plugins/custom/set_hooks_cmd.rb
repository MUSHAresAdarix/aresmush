module AresMUSH
  module Custom
    class SetHooksCmd
      include CommandHandler

      attr_accessor :hooks

      def parse_args
        self.hooks = trim_arg(cmd.args)
      end

      def handle
        enactor.update(hooks: self.hooks)
        client.emit_success "New hooks list set."
      end
    end
  end
end
