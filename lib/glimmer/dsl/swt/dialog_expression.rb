require 'glimmer/dsl/static_expression'
require 'glimmer/dsl/parent_expression'
require 'glimmer/dsl/top_level_expression'
require 'glimmer/swt/shell_proxy'

module Glimmer
  module DSL
    module SWT
      class DialogExpression < StaticExpression
        include TopLevelExpression
        include ParentExpression

        def can_interpret?(parent, keyword, *args, &block)
          keyword == 'dialog' and
            (parent.nil? or parent.is_a?(Glimmer::SWT::ShellProxy))
        end
  
        def interpret(parent, keyword, *args, &block)
          args = [parent] + args unless parent.nil?
          args += [:dialog_trim, :application_modal]
          Glimmer::SWT::ShellProxy.send(:new, *args)
        end
      end
    end
  end
end