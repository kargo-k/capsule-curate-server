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

# everlane('db/everlane/sweaters.html','sweater','top')
# everlane('db/everlane/denim.html','denim','bottoms')
# everlane('db/everlane/dresses.html','dress','one piece')
# everlane('db/everlane/outerwear.html','outerwear','outerwear')
# everlane('db/everlane/pants.html','pants','bottoms')
# everlane('db/everlane/shorts.html','shorts','bottoms')
# everlane('db/everlane/tees.html','tee','top')
# everlane('db/everlane/tops.html','top','top')
# everlane('db/everlane/bags.html','bag','accessories')
# everlane('db/everlane/shoes.html','shoes','shoes')


def nordy(url, category, category2)
  base_url = 'https://shop.nordstrom.com'
  brand = 'Nordstrom Sustainable'
  html_data = open(url).read
  # html_data = File.read(file)
  obj = Nokogiri::HTML(html_data)
  
  collection = obj.css("article._1AOd3")
  # item_div_class = '_1AOd3'

  collection.each do |i|
    img_url = i.children[0].children[0].attributes['src'].value
    shop_link = base_url + i.children[0].children[1].attributes['href'].value

    name = i.css('h3').children[0].children[0].text
    price = i.css('span._3wu-9').text
    
    # parse color from shop_link
    color = shop_link[shop_link.index('color=')+6..-1].gsub('%20', ' ')
    # color swatches ... sometimes does not exist
    # colors = i.children[1].css('li') 

    item = Item.find_or_create_by(shop_link: shop_link)
    item.name = name
    item.price = price
    item.brand = brand
    item.color = color
    item.category = category
    item.category2 = category2
    item.image = img_url
    item.save
    puts item
  end

end

# nordy('https://shop.nordstrom.com/c/sustainable-style?breadcrumb=Home%2FSustainable%20Style&flexi=60126782_60126784&flexi=8000786_60202026', 'outerwear', 'outerwear')

# nordy('https://shop.nordstrom.com/c/sustainable-style?breadcrumb=Home%2FSustainable%20Style&flexi=60126782_60126784&flexi=8000786_60130139', 'dress', 'one piece')

# nordy('https://shop.nordstrom.com/c/sustainable-style?breadcrumb=Home%2FSustainable%20Style&flexi=60126782_60126784&flexi=8000786_8000796', 'outerwear', 'outerwear')

# nordy('https://shop.nordstrom.com/c/sustainable-style?breadcrumb=Home%2FSustainable%20Style&flexi=60126782_60126784&flexi=8000786_8000819', 'denim', 'bottoms')

# nordy('https://shop.nordstrom.com/c/sustainable-style?breadcrumb=Home%2FSustainable%20Style&flexi=60126782_60126784&flexi=8000786_8000831', 'pants', 'bottoms')

# nordy('https://shop.nordstrom.com/c/sustainable-style?breadcrumb=Home%2FSustainable%20Style&flexi=60126782_60126784&flexi=8000786_60129453', 'top', 'top')

# nordy('https://shop.nordstrom.com/c/sustainable-style?breadcrumb=Home%2FSustainable%20Style&flexi=60126782_60126784&flexi=8000786_8000851', 'sweater', 'top')

# nordy('https://shop.nordstrom.com/c/sustainable-style?breadcrumb=Home%2FSustainable%20Style&flexi=60126782_60126784&flexi=8000786_60129871', 'tee', 'top')

# nordy('https://shop.nordstrom.com/c/sustainable-style?flexi=60126782_60126784&flexi=8000786_60130766%7C8000786_8000803%7C8000786_8000829%7C8000786_60127365', 'jewelery', 'accessories')

# nordy('https://shop.nordstrom.com/c/sustainable-style?flexi=60126782_60126784&flexi=8000786_60205299%7C8000786_60205393%7C8000786_60205305', 'bag', 'accessories')