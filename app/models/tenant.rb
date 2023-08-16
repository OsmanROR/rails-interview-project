# == Schema Information
#
# Table name: tenants
#
#  id                :integer          not null, primary key
#  api_key           :string
#  api_request_count :integer          default(0)
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Tenant < ApplicationRecord
    before_create :create_api_key
    validates :name, presence: :true

    private
    def create_api_key
      self.api_key = SecureRandom.hex(32)
    end
end
