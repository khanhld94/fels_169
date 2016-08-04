class Word < ActiveRecord::Base
  belongs_to :category

  has_many :word_answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :lessons, through: :results

  accepts_nested_attributes_for :word_answers,
    reject_if: :reject_answers, allow_destroy: true

  validates_presence_of :category
  validates :content, presence: true

  def reject_answers
    attributes["content"].blank?
  end
end
