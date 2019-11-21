class SubmissionQuery
  def initialize(relation=Submission.all)
    @relation = relation.extending(Scopes)
  end

  module Scopes
    def for_question(question_id)
      where(question_id: question_id).order(:score).take
    end

    def best_for_question(question_id)
      for_question(question_id).order(:score, created_at: :desc).take
    end

    def previous_for_question(question_id)
      for_question(question_id).order(created_at: :desc).second
    end
  end
end
