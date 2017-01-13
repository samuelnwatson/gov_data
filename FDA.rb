# - Filename: FDA.rb
# - Author: Sam Watson
# - Description: Small program accessing the U.S. government FDA API.
# -   Fetches n-instances of brands resulting in hospitalisation and remaining symptoms.
# - Last Edit: 8 Jan, 2017

require 'rubygems'
require 'open-uri'
require 'json'

class QueryFDA
  def fda_query(n=100)
    url = "https://api.fda.gov/food/event.json?"
    query = "search=products.name_brand+reactions=%22hospitalisation%22&limit=#{n}"
    request = open(url + query)
  end

  def parse_json
    json_data = fda_query.read
    parsed_data = JSON.parse(json_data, symbolize_names: true)
    results = parsed_data.delete(:results)
  end

  def organise_data
    data = parse_json
    organised_results = {}
    data.each_with_index do |obj, i| 
      organised_results[data[i][:products][0][:name_brand]] = data[i][:reactions]
    end
    
    organised_results
  end

  def display_results
    organise_data.each do |brand, symptoms|
      puts "\nBrandname: #{brand}"
      puts "Symptoms: #{symptoms}"
    end
  end
end

QueryFDA.new.display_results
