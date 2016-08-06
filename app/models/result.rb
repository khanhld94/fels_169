class Result < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :word
  belongs_to :word_answer

  scope :sum_correct_answer, ->(lesson_id) do
    where("lesson_id = ? AND results.word_answer_id IN (SELECT id FROM 
      word_answers WHERE is_correct = ? AND word_id = results.word_id)", 
      lesson_id, true).count
  end
end
