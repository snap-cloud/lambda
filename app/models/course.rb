class Course < ActiveRecord::Base
  VALID_CONFIG_KEYS = [
    "Keep Highest Score"
  ]

  def update(params)
    
  end

  # Convert keys to a form format.
  def self.form_keys_list
    VALID_CONFIG_KEYS.each do |key|
      [key, key.downcase.sub!(' ', '-')]
    end
  end

end
