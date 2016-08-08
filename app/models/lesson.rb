class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  has_many :results, dependent: :destroy
  has_many :words, through: :results

  validates :user, presence: true
  validates :category, presence: true

  enum status: [:testing, :finished]

  accepts_nested_attributes_for :results
  
  before_create :random_words
  
  def load_answer_correct
    Result.sum_correct_answer self.id
  end

  private
  def random_words
    self.words = category.words.order("RANDOM()").limit Settings.number_word
  end
end
