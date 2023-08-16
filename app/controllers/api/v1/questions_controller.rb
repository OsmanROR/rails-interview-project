module Api
  module V1
    class QuestionsController < ApplicationController
      before_action :authenticate_tenant

      def index
        @questions = Question.includes(:answers, :user).where(private: false)
        @questions = @questions.where("LOWER(questions.title) LIKE ?", "%#{params[:q].to_s.downcase}%") if params[:q].present?
        if @questions.any?
          questions_service = QuestionsService.new(@questions)
          render json: questions_service.questions_response, status: :ok
        else
          render json: { error: "not_found",  error_description: 'Question not found'}, status: :not_found
        end
      end

      private
      def authenticate_tenant
        api_key = request.headers['TENANT-API-KEY']
        if api_key.blank?
          render_unauthorized(message: 'API key is missing')
          return
        end

        tenant = Tenant.find_by(api_key: api_key)
        if tenant.nil?
          render_unauthorized(message: 'Invalid API key')
        else
          tenant.increment!(:api_request_count)
        end
      end
    end
  end
end
