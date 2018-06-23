module Mutations
  class CreateMutation < BaseMutation
    field :errors, [Types::UserError], null: false

    def resolve(params)
      object = initialize_object(params)

      authorize!(object, :create)

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

    private

    def initialize_object(params)
      resource_class.new(params)
    end
  end
end
