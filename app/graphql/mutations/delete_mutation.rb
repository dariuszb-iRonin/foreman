module Mutations
  class DeleteMutation < BaseMutation
    argument :id, ID, required: true

    field :id, ID, 'The deleted object ID.', null: false

    def resolve(id:)
      object = ForemanGraphqlSchema.object_from_id(id, context)

      raise GraphQL::ExecutionError.new(
        _('Could not resolve ID.')
      ) unless object

      authorize!(object, :destroy)

      validate_object(object, resource_class)

      User.as(context[:current_user]) do
        object.destroy!

        unless object.destroyed?
          raise GraphQL::ExecutionError.new(
            _('Could not destroy the record.')
          )
        end

        {
          id: id
        }
      end
    end
  end
end
