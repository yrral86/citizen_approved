# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

districts = ['AL-7',
             'AK-1',
             'AZ-9',
             'AR-4',
             'CA-53',
             'CO-7',
             'CN-4',
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
             'MN-2',
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

District.destroy_all

districts.each do |d|
  (state, dnum) = d.split('-')
  (1..dnum.to_i).each do |n|
    District.create(senate: false, state_code: state,
                    number: n, name: "#{state}-#{n.to_s}")
  end
  (1..2).each do |n|
    District.create(senate: true, state_code: state,
                    number: n, name: "#{state} Senate Seat #{n}")
  end
end
