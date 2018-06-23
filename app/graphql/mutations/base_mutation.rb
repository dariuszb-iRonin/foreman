module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    private

    def authorize!(resource, action)
      user = context[:current_user]
      authorizer = Authorizer.new(user)
      permission_name = resource.permission_name(action)

      unless authorizer.can?(permission_name, resource)
        raise GraphQL::ExecutionError.new(
          _('Unauthorized. You do not have the required permission %s.') % permission_name
        )
      end
    end

    def validate_object(resource, type)
      raise GraphQL::ExecutionError.new("Resource mismatch, expected #{type.name}, got #{resource.class.name}") unless resource.class.name == type.name
    end
  end
end
