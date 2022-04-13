class ActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    activities = Activity.all
    render json: activities, status: :ok
  end

  def destroy
    selected_activity = Activity.find(params[:id])
    selected_activity.destroy
    head :no_content
  end

  private

  def render_not_found_response
    render json: { error: 'Activity not found' }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    render json: {
             errors: exception.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end
end
