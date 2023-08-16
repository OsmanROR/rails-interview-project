# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  private    :boolean
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_questions_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Question < ApplicationRecord
    belongs_to :user
    has_many   :answers, dependent: :destroy

    validates  :title, presence: true
end
