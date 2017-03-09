# == Schema Information
#
# Table name: questions
#
#  id           :integer          not null, primary key
#  title        :string
#  points       :float
#  content      :text
#  test_file    :text
#  starter_file :text
#  metadata     :jsonb
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Question < ActiveRecord::Base
  # has_many :submissions
end
