require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :controller do
  describe 'GET #index' do
    context 'Missing API key' do
      before { get :index, format: :json }

      it 'returns an unauthorized response' do
        body = JSON.parse(response.body)
        expect(response).to have_http_status(:unauthorized)
        expect(body["error"]).to eq "unauthorized"
        expect(body["error_description"]).to eq "API key is missing"
      end
    end

    context 'Invalid API key' do
      before do
        request.headers['TENANT-API-KEY'] = 'invalid-api-key'
        get :index, format: :json
      end

      it 'returns an unauthorized response' do
        body = JSON.parse(response.body)
        expect(response).to have_http_status(:unauthorized)
        expect(body["error"]).to eq "unauthorized"
        expect(body["error_description"]).to eq "Invalid API key"
      end
    end

    context 'Valid API key' do
      let(:tenant)      { create(:tenant) }
      let!(:questions)  { create_list(:question, 3, private: false) }

      before do
        request.headers['TENANT-API-KEY'] = tenant.api_key
        get :index, format: :json
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a list of questions' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.size).to eq(3)
      end

      it 'includes question attributes' do
        parsed_response = JSON.parse(response.body)
        first_question  = parsed_response.first
        expect(first_question.keys).to include('id', 'title', 'asker', 'answers')
      end

      it 'includes asker attributes' do
        parsed_response = JSON.parse(response.body)
        first_question = parsed_response.first
        expect(first_question['asker']).to include('id', 'name')
      end

      it 'includes answer attributes' do
        parsed_response = JSON.parse(response.body)
        first_question  = parsed_response.first
        expect(first_question['answers'].first.keys).to include('id', 'body', 'provider')
      end
    end

    context 'with search query' do
      let(:tenant)    { create(:tenant) }
      let!(:question) { create(:question, private: false, title: 'Sample question') }

      before do
        request.headers['TENANT-API-KEY'] = tenant.api_key
        get :index, format: :json, params: { q: question.title }
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns matching questions' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response.size).to eq(1)
      end

      it 'includes question attributes' do
        parsed_response = JSON.parse(response.body)
        first_question = parsed_response.first
        expect(first_question.keys).to include('id', 'title', 'asker', 'answers')
      end
    end

    context 'when no questions match the criteria' do
      let(:tenant) { create(:tenant) }

      before do
        request.headers['TENANT-API-KEY'] = tenant.api_key
        get :index, format: :json, params: { q: 'no question' }
      end

      it 'returns a not found response' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns the appropriate error message' do
        expect(JSON.parse(response.body)).to eq('error' => 'not_found', 'error_description' => 'Question not found')
      end
    end
  end
end
