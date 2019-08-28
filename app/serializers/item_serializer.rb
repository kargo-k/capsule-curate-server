class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :shop_link, :color, :category, :category2, :price, :image
end
