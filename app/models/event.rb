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

  validates :name, presence: true, length: { in: 2..50 }

  scope :with_client, ->(client_id) { where('client_1=? OR client_2=? OR client_3=?', client_id, client_id, client_id) }

  DEPARTMENTS = ['01', '02', '03', '04', '05', '06', '07', '08', '09'] + (10..99).to_a + ["2A", "2B",
    "Albacete", "Alicante", "Almería", "Araba", "Asturias", "Ávila", "Badajoz", "Barcelona", "Bizkaia", "Burgos", "Cáceres", "Cadix", "Cantabria",
    "Castellón", "Ciudad Real", "Córdoba", "Cuenca", "Gerona", "Gipuzkoa", "Granada", "Guadalajara", "Huelva", "Huesca", "Islas Baleares", "Jaén",
    "La Coruña", "La Rioja", "Las Palmas", "León", "Lleida", "Lugo", "Madrid", "Málaga", "Murcia", "Nafarroa", "Orense", "Palencia", "Pontevedra",
    "Salamanca", "Santa Cruz de Tenerife", "Segovia", "Sevilla", "Soria", "Tarragona", "Teruel", "Toledo", "Valencia", "Valladolid", "Zamora", "Zaragoza"
  ]

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
end
