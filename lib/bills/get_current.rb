require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'addressable/uri'
require 'net/http'
require 'net/https'

def get_current_bills
  # clear out current bills
  Bill.current.each do |b|
    b.current = false
    b.save
  end

  # get the current bills
  page = Nokogiri::HTML(open("https://www.govtrack.us/congress/bills"))

  # create them if they don't exist
  page.css("div#docket").css("a").each do |bill|
    u = Addressable::URI.parse("https://www.govtrack.us/api/v2/bill?q=\"#{bill.text}\"")
    Net::HTTP.start(u.host, u.port, :use_ssl => u.scheme == 'https') do |http|
      request = Net::HTTP::Get.new u
      response = http.request request
      json = JSON.parse(response.body)
      json['objects'].each do |o|
        if (b = Bill.find_by_govtrack_id(o['id'])) 
          b.current = true
          b.save
        elsif o['title'] == bill.text
          Bill.create(
            title:o['title'],
            congress:o['congress'],
            number:o['number'],
            govtrack_id:o['id'],
            govtrack_url:o['link'],
            thomas_url:o['thomas_link'],
            summary:o['title_without_number'],
            senate:o['bill_type'] == 'senate_bill' ? true : false,
            current:true
          )
        end
      end
    end
  end
end

get_current_bills()