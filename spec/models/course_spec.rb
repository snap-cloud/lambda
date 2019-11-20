# == Schema Information
#
# Table name: courses
#
#  id              :integer          not null, primary key
#  name            :string
#  url             :string
#  consumer_key    :string
#  consumer_secret :string
#  configuration   :hstore
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_courses_on_name  (name) UNIQUE
#

require 'rails_helper'

RSpec.describe Course, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
