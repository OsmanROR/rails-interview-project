# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_answers_on_question_id  (question_id)
#  index_answers_on_user_id      (user_id)
#
# Foreign Keys
#
#  question_id  (question_id => questions.id)
#  user_id      (user_id => users.id)
#
class Answer < ApplicationRecord
    belongs_to :question
    belongs_to :user

    validates  :body, presence: true
end
