# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'

yaml = open("https://www.govtrack.us/data/congress-legislators/legislators-current.yaml") {|f| YAML.load(f.read)}

legislators = []
yaml.each do |l|
  legislators << [l['name']['official_full'], l['terms'][-1]['state'],
                  l['terms'][-1]['type'],
                  l['terms'][-1]['district'], l['terms'][-1]['state_rank']]
end

districts = ['AL-7',
             'AK-1',
             'AZ-9',
             'AR-4',
             'CA-53',
             'CO-7',
             'CT-5',
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
             'WY-1',
             'GU-1',
             'VI-1',
             'AS-1',
             'DC-1',
             'PR-1',
             'MP-1'
            ]

District.destroy_all

districts.each do |d|
  (state, dnum) = d.split('-')
  leg = legislators.select do |l|
    l[1] == state
  end
  senators = leg.select do |l|
    l[2] == "sen"
  end
  reps = leg.select do |l|
    l[2] == "rep"
  end

  puts "Warning: #{state}: specified: #{dnum}, actual: #{reps.size}" if reps.size != dnum.to_i

  if senators and senators.size > 0
    i = 1
    i = 2 if senators[0][4] == 'senior'
    senators.each do |s|
      District.create(senate: true, state_code: state,
                      number: i, name: s[0])
      if senators[0][4] == 'senior'
        i = 1
      else
        i = 2
      end
    end
  end

  reps.each do |r|
    District.create(senate: false, state_code: state,
                    number: r[3], name: r[0])
  end
end

Congress.create(number:113, session:2, dstart: '2014-01-03', dend: '2015-01-03', current:true)
Congress.create(number:113, session:1, dstart: '2013-01-03', dend: '2013-12-26', current:false)
require 'bills/get_current'
require 'congress/get_data'

d = District.all
b = Bill.all

c1 = []
c2 = []

(1..b.size).each do |i|
  c1 << rand()
  c2 << rand()

  if c2[i-1] < c1[i-1]
    a = c2[i-1]
    c2[i-1] = c1[i-1]
    c1[i-1] = a
  end
end

1000.times do |i|
  v = Voter.create(name: "voter#{i}", email: "voter#{i}@yrral86.koding.io",
                   password: 'pass', voter_id: '12345', address: '123 main',
                   city: 'Frostburg', state_code: 'MD', zip: '21532',
                   house_district_id: d[0].id)
  b_count = 0
  b.each do |bill|
    r = rand()
    c = if r < c1[b_count]
          :for
        elsif r < c2[b_count]
          :against
        else
          :delegate
        end
      Vote.create(voter_id: v.id, bill_id: bill.id, choice: c)
      b_count += 1
  end
end

10000.times do |i|
  v = Voter.create(name: "voter#{i}", email: "voter#{i}@yrral86.koding.io",
                   password: 'pass', voter_id: '12345', address: '123 main',
                   city: 'Frostburg', state_code: 'MD', zip: '21532',
                   house_district_id: d[rand(d.size - 1) + 1].id)
  b_count = 00
  b.each do |bill|
    r = rand()
    c = if r < c1[b_count]
          :for
        elsif r < c2[b_count]
          :against
        else
          :delegate
        end
      Vote.create(voter_id: v.id, bill_id: bill.id, choice: c)
      b_count += 1
  end
end

Legislator.create(house_district_id: d[0].id, email: 'demo@opencongress.org', password: 'password', state_code: 'MD')
