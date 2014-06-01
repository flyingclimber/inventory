#!/usr/bin/ruby

=begin
    windygaming.rb - Checks for new items on windygaming.com

    Copyright (C) 2014, Tomasz Finc <tomasz@gmail.com>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
=end

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'

STOCKFILE = 'stock'
WINDYURL = 'http://www.windygaming.com'
WINDYNEW = '/collections/newest-items'
THRESHOLD = 1
ITEMSTOTAL = 10
ITEMSSTART = 0

stock = JSON.parse(IO.read(STOCKFILE)) if File.file?(STOCKFILE)

page = Nokogiri::HTML(open(WINDYURL + WINDYNEW))

buffer = page.css("a[class=product-link]")

def write_stock_file(objectToWrite)
  json = JSON.generate(objectToWrite)
  File.open(STOCKFILE, 'w') do |f|
    f.write(json)
  end
end

def append_stock_file(stock_to_add, stock_file)
  stock_to_add.each do |i|
    stock_file.push(i)
  end
end

if stock
  new_items = []
  (ITEMSSTART..ITEMSTOTAL).each do |i|
    if not stock.include? buffer[i]['title']
      new_items << i
    end
  end
  if new_items.count >= THRESHOLD
    item_list = []
    new_items.each do |i|
      puts buffer[i]['title'],
           WINDYURL + buffer[i]['href'], "\n"
      item_list << buffer[i]['title']
    end
    append_stock_file(item_list, stock)
    write_stock_file(stock)
  end
else
  item_list = []
  puts "First run so everything is new!\n\n"
  (ITEMSSTART..ITEMSTOTAL).each do |i|
    puts buffer[i]['title'],
         WINDYURL + buffer[i]['href'], "\n"
    item_list[i] = buffer[i]['title']
  end
  write_stock_file(item_list)
end
