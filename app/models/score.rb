# == Schema Information
#
# Table name: scores
#
#  id         :integer          not null, primary key
#  runner_id  :integer
#  points     :integer
#  race_type  :string
#  date       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Score < ApplicationRecord
  # Relations
  belongs_to :runner
  delegate :last_name, to: :runner

  # Validations
  validates :points, presence: true
  validates :race_type, inclusion: { in: ['trail', 'route', 'funrace'] }
end
