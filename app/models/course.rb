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

# Used for generating consumer secrets
require 'digest'

class Course < ActiveRecord::Base
  after_create :after_initialize

  validates_presence_of :name, unique: true
  validates_presence_of :consumer_key, unique: true
  validates_presence_of :url

  
  # This determines the paramters and methods for update course attributes
  @@VALID_CONFIG_OPTIONS = {
    keep_highest_score: {
      name: 'Keep Highest Score',
      values: [true, false]
    },
    late_policy_formula: {}
  }

  # After creating a course, set the secret key.
  def after_initialize
    self.consumer_secret = create_consumer_secret(
      nil,
      self.consumer_key
    )
    self.save
  end
  
  def update(course_params)
    self.name = course_params[:name] || self.name
    self.url = course_params[:url] || self.url
    self.consumer_secret = create_consumer_secret(
      self.consumer_key,
      course_params[:consumer_key]
    )
    self.consumer_key = course_params[:consumer_key] || self.consumer_key
    self.configuration = configuration_hash(self.configuration, course_params)
    self.save
  end

  # Generate a Consumer Secret
  def create_consumer_secret(old_key, new_key)
    if old_key == nil || old_key != new_key && new_key != nil
      Digest::SHA256.base64digest(new_key + '_' + Time.new().to_s)
    else
      self.consumer_secret
    end
  end

  def configuration_hash(old_config, course_params)
    config = old_config || {}
    (course_params[:configuration] || {}).each do |key, value|
      config[key] = value
    end
    config
  end

  # Convert keys to a form format for views
  # TODO: Use this when necessary
  def self.form_keys_list
    VALID_CONFIG_OPTIONS.each do |key, value|
      [value[:name], key]
    end
  end

  def self.VALID_CONFIG_OPTIONS
    @@VALID_CONFIG_OPTIONS
  end
end
