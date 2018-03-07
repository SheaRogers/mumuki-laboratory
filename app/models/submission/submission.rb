require 'securerandom'

class Submission
  include ActiveModel::Model

  required :try_evaluate_exercise!

  def run!(assignment, evaluation)
    save_submission! assignment
    results = evaluation.evaluate! assignment, self
    save_results! results, assignment
    notify_results! results, assignment
    results
  end

  def evaluate!(assignment)
    try_evaluate_exercise! assignment
  rescue => e
    {status: :errored, result: e.message}
  end

  def id
    @id ||= SecureRandom.hex(8)
  end

  private

  def save_submission!(assignment)
    assignment.content = content
    assignment.save!
  end

  def save_results!(results, assignment)
    assignment.failed_submissions_count += 1 unless results[:status] == :passed
    assignment.update results
    assignment.save!
  end

  def notify_results!(results, assignment)
    assignment.notify!
  end
end
