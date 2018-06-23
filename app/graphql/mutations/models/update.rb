module Mutations
  module Models
    class Update < UpdateMutation
      description 'Updates existing hardware model.'

      argument :id, ID, required: true
      argument :name, String, required: true
      argument :info, String, required: false
      argument :vendor_class, String, required: false
      argument :hardware_model, String, required: false

      field :model, Types::Model, 'The hardware model.', null: true

      private

      def resource_class
        ::Model
      end
    end
  end
end
