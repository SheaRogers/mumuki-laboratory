class ExercisesController < ApplicationController
  before_action :set_guide!, only: :show
  before_action :set_default_content!, only: :show, if: :current_user?
  before_action :set_assignment!, only: :show, if: :current_user?
  before_action :validate_accessible!, only: :show
  before_action :start!, only: :show

  def show
    @solution = @exercise.new_solution if current_user?
  end

  def show_by_slug
    redirect_to Guide.by_slug_parts!(params).exercises.find_by!(bibliotheca_id: params[:bibliotheca_id])
  end

  private

  def subject
    @exercise ||= Exercise.find_by(id: params[:id])
  end

  def accessible_subject
    subject.navigable_parent
  end

  def start!
    @exercise.navigable_parent.start! current_user
  end

  def set_default_content!
    @files = @exercise.files_for(current_user)
    @current_content = @exercise.current_content_for(current_user)
    @default_content = @exercise.default_content_for(current_user)
  end

  def set_assignment!
    @assignment = @exercise.assignment_for(current_user)
  end

  def set_guide!
    raise Mumuki::Laboratory::NotFoundError if @exercise.nil?
    @guide = @exercise.guide
  end

  def exercise_params
    params.require(:exercise).
      permit(:name, :description, :locale, :test,
             :extra, :language_id, :hint, :tag_list,
             :guide_id, :number,
             :layout, :expectations_yaml)
  end
end
