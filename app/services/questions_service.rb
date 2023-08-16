class QuestionsService
    def initialize(questions)
      @questions = questions
    end

    def questions_response
      result_array = []

      @questions.each do |question|
        result_array << build_question_hash(question)
      end

      result_array
    end

    private

    def build_question_hash(question)
        content             = {}
        content[:id]        = question.id
        content[:title]     = question.title
        content[:asker]     = build_asker_hash(question.user)
        content[:answers]   = build_answer_hashes(question.answers)
        content
    end

    def build_asker_hash(user)
        content             = {}
        content[:id]        = user.id
        content[:name]      = user.name
        content
    end

    def build_answer_hashes(answers)
      answers.map do |answer|
        content             = {}
        content[:id]        = answer.id
        content[:body]      = answer.body
        content[:provider]  = build_provider_hash(answer.user)
        content
      end
    end

    def build_provider_hash(user)
        content             = {}
        content[:id]        = user.id
        content[:name]      = user.name
        content
    end
end
