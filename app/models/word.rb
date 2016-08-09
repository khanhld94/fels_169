class Word < ActiveRecord::Base
  belongs_to :category

  has_many :word_answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :lessons, through: :results

  accepts_nested_attributes_for :word_answers,
    reject_if: :reject_answers, allow_destroy: true

  validates_presence_of :category
  validates :content, presence: true
  
  scope :learned, ->user_id{where "words.id IN (SELECT word_id FROM 
    results WHERE lesson_id IN (SELECT id FROM lessons 
    WHERE user_id = ?))", user_id}
  scope :not_learned, ->user_id{where "words.id NOT IN (SELECT word_id FROM 
    results WHERE lesson_id IN (SELECT id FROM lessons 
    WHERE user_id = ?))", user_id}

  def reject_answers attributes
    attributes["content"].blank?
  end
end
