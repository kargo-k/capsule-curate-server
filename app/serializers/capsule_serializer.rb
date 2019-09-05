class CapsuleSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :items, :active, :colors, :season
  has_many :items
end
