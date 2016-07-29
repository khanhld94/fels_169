class Word < ActiveRecord::Base
  belongs_to :category

  has_many :word_answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :lessons, through: :results
end
