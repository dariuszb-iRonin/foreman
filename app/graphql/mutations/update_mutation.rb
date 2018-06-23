module Mutations
  class UpdateMutation < BaseMutation
    field :errors, [Types::UserError], null: false

    def resolve(params)
      object = ForemanGraphqlSchema.object_from_id(params[:id], context)

      object.assign_attributes(params.except(:id))

      authorize!(object, :edit)

      User.as(context[:current_user]) do
        errors = if object.save
                   []
                 else
                   object.errors.map do |attribute, message|
                     {
                       path: ['attributes', attribute.to_s.camelize(:lower)],
                       message: message
                     }
                   end
                 end

        {
          resource_class.name.downcase => object,
          errors: errors
        }
      end
    end
  end
end
