require 'pry'
require 'nokogiri'
require 'open-uri'

# Item.delete_all
# User.delete_all
# Capsule.delete_all

def everlane(file, category, category2)

  url = 'www.everlane.com'
  brand = 'Everlane'

  # html_data = open(url).read
  html_data = File.read(file)
  obj = Nokogiri::HTML(html_data)
  
  collection_group = obj.css("div.collection__grouping")

  collection_group.each do |group|
    product_containers = collection_group.css("div.product")

    product_containers.each do |product|
      img_a = product.css('a')

      shop_link = url + img_a[0].attributes['href'].value
      img_url = img_a[0].elements[1].attributes['src'].value
      name = img_a[1].elements[0].children[0].text
      price = img_a[1].elements[1].children[0].text
      color = img_a[1].elements[3].children[0].text

      Item.find_or_create_by(shop_link: shop_link) do |item|
        item.name = name
        item.price = price
        item.brand = brand
        item.color = color
        item.category = category
        item.category2 = category2
        item.image = img_url
      end
    end

  end


end

everlane('db/everlane/sweaters.html','sweater','top')
everlane('db/everlane/denim.html','denim','bottoms')
everlane('db/everlane/dresses.html','dress','one piece')
everlane('db/everlane/outerwear.html','outerwear','outerwear')
everlane('db/everlane/pants.html','pants','bottoms')
everlane('db/everlane/shorts.html','shorts','bottoms')
everlane('db/everlane/tees.html','tee','top')
everlane('db/everlane/tops.html','top','top')