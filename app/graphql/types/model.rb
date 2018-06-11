module Types
  class Model < GraphQL::Schema::Object
    description 'A Model'

    implements GraphQL::Relay::Node.interface

    global_id_field :id

    field :name, String, resolve: ->(obj, _, _) { obj.name }, null: false
    field :info, String, resolve: ->(obj, _, _) { obj.info }, null: true
    field :vendorClass, String, resolve: ->(obj, _, _) { obj.vendor_class }, null: true
    field :hardwareModel, String, resolve: ->(obj, _, _) { obj.hardware_model }, null: true
  end
end
