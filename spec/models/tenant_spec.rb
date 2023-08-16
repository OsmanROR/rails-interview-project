require 'rails_helper'

RSpec.describe Tenant, type: :model do
  describe 'before_create callback' do
    let!(:tenant) { create(:tenant) }
    let!(:tenant1) { create(:tenant) }

    it 'generates an api_key prior to creating a new tenant' do
      expect(tenant.api_key).not_to be_nil
    end

    it 'generates a unique api_key for each tenant' do
      expect(tenant.api_key).not_to eq(tenant1.api_key)
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
