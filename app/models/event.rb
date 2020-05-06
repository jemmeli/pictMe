# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  name             :string
#  place            :string
#  website          :string
#  facebook         :string
#  twitter          :string
#  instagram        :string
#  contact          :string
#  email            :string
#  phone            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  client_1         :integer
#  client_2         :integer
#  client_3         :integer
#  department       :string
#  challenge_id     :integer
#  global_challenge :boolean
#

class Event < ApplicationRecord
  extend Enumerize

  geocoded_by :place
  after_validation :geocode, if: :place_changed?

  has_many :editions, dependent: :nullify
  has_many :races, through: :editions
  belongs_to :challenge
  has_many :runners, through: :editions
  belongs_to :user

  validates :name, presence: true, length: { in: 2..50 }

  scope :with_client, ->(client_id) { where('client_1=? OR client_2=? OR client_3=?', client_id, client_id, client_id) }

  DEPARTMENTS = ['01', '02', '03', '04', '05', '06', '07', '08', '09'] + (10..99).to_a + ["2A", "2B",
    "Albacete", "Alicante", "Almería", "Araba", "Asturias", "Ávila", "Badajoz", "Barcelona", "Bizkaia", "Burgos", "Cáceres", "Cadix", "Cantabria",
    "Castellón", "Ciudad Real", "Córdoba", "Cuenca", "Gerona", "Gipuzkoa", "Granada", "Guadalajara", "Huelva", "Huesca", "Islas Baleares", "Jaén",
    "La Coruña", "La Rioja", "Las Palmas", "León", "Lleida", "Lugo", "Madrid", "Málaga", "Murcia", "Nafarroa", "Orense", "Palencia", "Pontevedra",
    "Salamanca", "Santa Cruz de Tenerife", "Segovia", "Sevilla", "Soria", "Tarragona", "Teruel", "Toledo", "Valencia", "Valladolid", "Zamora", "Zaragoza"
  ]

  COUNTRIES = ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica",
               "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas",
               "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan",
               "Bolivia", "Bosnia and Herzegowina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory",
               "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada",
               "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island",
               "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Congo, the Democratic Republic of the",
               "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia (Hrvatska)", "Cuba", "Cyprus", "Czech Republic",
               "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador",
               "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands",
               "Fiji", "Finland", "France", "France Metropolitan", "French Guiana", "French Polynesia",
               "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece",
               "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti",
               "Heard and Mc Donald Islands", "Holy See (Vatican City State)", "Honduras", "Hong Kong", "Hungary",
               "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy",
               "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of",
               "Korea, Republic of", "Kuwait", "Kyrgyzstan", "Lao, People's Democratic Republic", "Latvia", "Lebanon",
               "Lesotho", "Liberia", "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau",
               "Macedonia, The Former Yugoslav Republic of", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali",
               "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia,
 Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montserrat", "Morocco", "Mozambique", "Myanmar",
               "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand",
               "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway",
               "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn",
               "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation", "Rwanda",
               "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino",
               "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore",
               "Slovakia (Slovak Republic)", "Slovenia", "Solomon Islands", "Somalia", "South Africa",
               "South Georgia and the South Sandwich Islands", "Spain", "Sri Lanka", "St. Helena", "St. Pierre and Miquelon",
               "Sudan", "Suriname", "Svalbard and Jan Mayen Islands", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic",
               "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Togo", "Tokelau", "Tonga",
               "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda",
               "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States Minor Outlying Islands",
               "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Virgin Islands (British)", "Virgin Islands (U.S.)",
               "Wallis and Futuna Islands", "Western Sahara", "Yemen", "Yugoslavia", "Zambia", "Zimbabwe"]

  def self.import(file)
    CSV.foreach(file.path, col_sep: ';', row_sep: :auto, headers: true) do |row|
      Event.create(name: row[0],
                   place: row[1],
                   website: row[2],
                   facebook: row[3],
                   twitter: row[4],
                   instagram: row[5],
                   contact: row[6],
                   email: row[7],
                   phone: row[8])
    end
  end

  def clients
    c = []
    c << Client.find(client_1) unless client_1.blank?
    c << Client.find(client_2) unless client_2.blank?
    c << Client.find(client_3) unless client_3.blank?
    c.compact
  end

  #pictMe
  def self.serach( pattern )
    if pattern.blank?
      where('pictme != ? ', true).last(5)
    else
      where('name LIKE ? AND pictme != ? ', "%#{pattern}%", true)
    end
  end

  scope :pictme, -> { where pictme: true }

  #end pictMe

end
