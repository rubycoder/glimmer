require 'glimmer/dsl/expression'

module Glimmer
  module DSL
    class WidgetListenerExpression < Expression
      include_package 'org.eclipse.swt.widgets'

      def can_interpret?(parent, keyword, *args, &block)
        Glimmer.logger.debug "keyword starts with on_: #{keyword.start_with?('on_')}"
        return unless keyword.start_with?('on_')
        Glimmer.logger.debug "block exists?: #{!block.nil?}"
        return unless !block.nil?
        widget_parentage = widget?(parent)
        Glimmer.logger.debug "parent is a widget: #{widget_parentage}"
        return unless widget_parentage
        Glimmer.logger.debug "args are empty?: #{args.empty?}"
        return unless args.empty?
        result = parent.can_handle_observation_request?(keyword)
        Glimmer.logger.debug "can add listener? #{result}"
      end

      def interpret(parent, keyword, *args, &block)
        parent.handle_observation_request(keyword, &block)
      end
    end
  end
end