require 'pry'
require 'nokogiri'
require 'open-uri'

def nordy(url, category, category2)

  brand = 'Nordstrom Sustainable Style'

  html_data = open(url).read
  # html_data = File.read(file)
  obj = Nokogiri::HTML(html_data)
  
  collection = obj.css("article._1AOd3")
  # item_div_class = '_1AOd3'

  collection.each do |i|
    
    img_div = i.children[0]
    img_url = i.children[0].children[0].attributes['src'].value
    shop_link = i.children[0].children[1].attributes['href'].value

    name = i.css('h3').children[0].children[0].text
    price = i.css('span._3wu-9').text
    
    # parse color from shop_link
    color = shop_link[shop_link.index('color=')+6..-1].gsub('%20', ' ')

    # color swatches ... sometimes does not exist
    # colors = i.children[1].css('li') 

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

nordy('https://shop.nordstrom.com/c/sustainable-style?breadcrumb=Home%2FSustainable%20Style&flexi=60126782_60126784&flexi=8000786_60202026', 'outerwear', 'outerwear')