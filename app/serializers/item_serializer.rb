class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :shop_link, :description, :color, :category, :category2, :price, :image, :personal
end
