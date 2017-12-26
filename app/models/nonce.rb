# == Schema Information
#
# Table name: nonces
#
#  id         :integer          not null, primary key
#  nonce      :string
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_nonces_on_nonce  (nonce) UNIQUE
#

class Nonce < ActiveRecord::Base
  def self.clean
    delete_all(['created_at < ?', Time.now - 6.hours])
  end

  def self.valid?(nonce)
    begin
      self.create!(nonce: nonce)
      true
    rescue => e
      Rails.logger.warn(%Q|Creating nonce failed: "#{nonce}"|)
      Rails.logger.warn(e)
      false
    end
  end
end
