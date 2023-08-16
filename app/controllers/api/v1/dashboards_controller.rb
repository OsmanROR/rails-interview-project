module Api
  module V1
    class DashboardsController < ApplicationController
      def index
        render json: {
          users_count:                User.count,
          questions_count:            Question.count,
          answers_count:              Answer.count,
          tenant_api_request_counts:  Tenant.select(:id, :name, :api_request_count).as_json
        }
      end
    end
  end
end