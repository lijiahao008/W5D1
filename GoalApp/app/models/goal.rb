# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string           not null
#  details    :text             not null
#  private    :boolean          default("false")
#  completed  :boolean          default("false")
#

class Goal < ApplicationRecord
  validates :user, :title, :details, presence: true
  belongs_to :user
end
