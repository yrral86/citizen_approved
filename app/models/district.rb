class District < ActiveRecord::Base
  def self.senate_districts(state_code = nil)
    collection = self.state_districts(state_code)
    collection.where(senate: true)
  end

  def self.house_districts(state_code = nil)
    collection = self.state_districts(state_code)
    collection.where(senate: false)
  end

  def self.state_districts(state_code = nil)
    collection = District.all
    collection = collection.where(state_code: state_code) unless state_code.nil?
    collection
  end

  def option_name
    body = 'Senate'
    body = 'House' unless self.senate
    "#{state_code}- #{body} District #{number} (#{name})"
  end
end
