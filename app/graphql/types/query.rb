module Types
  class Query < BaseObject
    graphql_name 'Query'

    field :node, field: GraphQL::Relay::Node.field
    field :nodes, field: GraphQL::Relay::Node.plural_field

    field :model, Types::Model,
      function: Queries::FetchField.new(type: Types::Model, model_class: ::Model)

    field :models, Types::Model.connection_type,
      function: Queries::PluralField.new(type: Types::Model, model_class: ::Model)
  end
end
