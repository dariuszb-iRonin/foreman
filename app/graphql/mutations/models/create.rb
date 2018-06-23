module Mutations
  module Models
    class Create < CreateMutation
      description 'Creates a new hardware model.'

      argument :name, String, required: true
      argument :info, String, required: false
      argument :vendor_class, String, required: false
      argument :hardware_model, String, required: false

      field :model, Types::Model, 'The new hardware model.', null: true

      private

      def resource_class
        ::Model
      end
    end
  end
end
