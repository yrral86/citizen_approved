# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'

yaml = open("https://www.govtrack.us/data/congress-legislators/legislators-current.yaml") {|f| YAML.load(f.read)}

puts "total legislators: #{yaml.size}"

legislators = []
yaml.each do |l|
  legislators << [l['name']['official_full'], l['terms'][0]['state'], l['terms'][0]['type'],
                  l['terms'][0]['district'], l['terms'][0]['state_rank']]
end

districts = ['AL-7',
             'AK-1',
             'AZ-9',
             'AR-4',
             'CA-53',
             'CO-7',
             'CT-4',
             'DE-1',
             'FL-27',
             'GA-14',
             'HI-2',
             'ID-2',
             'IL-18',
             'IN-9',
             'IA-4',
             'KS-4',
             'KY-6',
             'LA-6',
             'ME-2',
             'MD-8',
             'MA-9',
             'MI-14',
             'MN-8',
             'MS-4',
             'MO-8',
             'MT-1',
             'NE-3',
             'NV-4',
             'NH-2',
             'NJ-12',
             'NM-3',
             'NY-27',
             'NC-13',
             'ND-1',
             'OH-16',
             'OK-5',
             'OR-5',
             'PA-18',
             'RI-2',
             'SC-7',
             'SD-1',
             'TN-9',
             'TX-36',
             'UT-4',
             'VT-1',
             'VA-11',
             'WA-10',
             'WV-3',
             'WI-8',
             'WY-1'
            ]

#District.destroy_all

total_s = 0
total_r = 0

unused_indices = (0..450).to_a

districts.each do |d|
  (state, dnum) = d.split('-')
  leg = legislators.select do |l|
    if l[1].downcase == state.downcase
      unused_indices.delete(legislators.index(l))
      true
    else
      false
    end
  end
  senators = leg.select do |l|
    l[2] == "sen"
  end
  reps = leg.select do |l|
    l[2] == "rep"
  end
  total_s += senators.size
  total_r += reps.size
  puts "#{state}: senators: #{senators.size} reps: #{reps.size}"
#  (1..dnum.to_i).each do |n|
#    District.create(senate: false, state_code: state,
#                    number: n, name: "#{state}-#{n.to_s}")
#  end
#  (1..2).each do |n|
#    District.create(senate: true, state_code: state,
#                    number: n, name: "#{state} Senate Seat #{n}")
#  end
end

puts "total: senators: #{total_s} reps: #{total_r}"
unused_indices.each do |i|
  puts legislators[i]
end
