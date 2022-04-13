class SignupsController < ApplicationController
  #   rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  #   def index
  #     signups = Signup.all
  #     render json: signups, status: :ok
  #   end

  def create
    new_signup = Signup.create!(signup_params)
    render json: new_signup.activity, status: :created
  end

  private

  def signup_params
    params.permit(:time, :camper_id, :activity_id)
  end

  #   def render_not_found_response
  #     render json: { error: 'Signup not found' }, status: :not_found
  #   end

  def render_unprocessable_entity(exception)
    render json: {
             errors: exception.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end
end
