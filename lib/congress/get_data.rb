require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'addressable/uri'
require 'net/http'
require 'net/https'

def get_current_congress_data
  congress = Congress.where("current = ?", true).first.number

  # get the current bills
  page = Nokogiri::HTML(open("https://www.govtrack.us/api/v2/bill?congress=#{congress}"))
  json = JSON.parse(page)

  total_bills = json['meta']['total_count']

  page = Nokogiri::HTML(open("https://www.govtrack.us/api/v2/bill?congress=#{congress}&current_status=enacted_signed"))
  json = JSON.parse(page)

  total_enacted = json['meta']['total_count']

  if c = CongressDatum.where("congress = ?", congress).first
    c.proposed = total_bills
    c.enacted = total_enacted
    c.save
  else
    CongressDatum.create(congress:congress, proposed:total_bills, enacted:total_enacted)
  end
end

get_current_congress_data()