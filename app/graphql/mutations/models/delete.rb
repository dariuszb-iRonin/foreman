module Mutations
  module Models
    class Delete < DeleteMutation
      description 'Deletes a hardware model.'

      private

      def resource_class
        ::Model
      end
    end
  end
end
