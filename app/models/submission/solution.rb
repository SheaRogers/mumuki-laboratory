class Solution < PersistentSubmission
  attr_accessor :content, :content_metadata, :extra_metadata

  def try_evaluate_exercise!(assignment)
    assignment.run_tests!({ content: content, extra_metadata: extra_metadata }).except(:response_type)
  end
end
