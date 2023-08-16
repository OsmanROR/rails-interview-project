# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    has_many  :answers,   dependent: :destroy
    has_many  :questions, dependent: :destroy

    validates :name, presence: :true
end
