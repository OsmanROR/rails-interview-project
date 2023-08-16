# spec/controllers/api/v1/dashboards_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::DashboardsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns the dashboard data in JSON format' do
      create_list(:question, 3)
      create_list(:tenant, 2, api_request_count: 42)

      get :index
      response_data = JSON.parse(response.body)
      expect(response_data).to have_key('users_count')
      expect(response_data).to have_key('questions_count')
      expect(response_data).to have_key('answers_count')
      expect(response_data).to have_key('tenant_api_request_counts')
      expect(response_data['users_count']).to eq 18
      expect(response_data['questions_count']).to eq 3
      expect(response_data['answers_count']).to eq 15
      expect(response_data['tenant_api_request_counts'].first["api_request_count"]).to eq 42
    end
  end
end
