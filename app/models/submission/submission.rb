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
    assignment.solution = content_metadata || content
    assignment.submittable_solution = content unless content_metadata.blank?
    assignment.save!
  end

  def save_results!(results, assignment)
    assignment.update! results
  end

  def notify_results!(results, assignment)
    assignment.notify!
  end
end
