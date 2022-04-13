class CampersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  def index
    campers = Camper.all
    render json: campers, status: :ok
  end

  def show
    selected_camper = Camper.find(params[:id])
    render json: selected_camper,
           serializer: CamperWithActivitiesSerializer,
           status: :ok
  end

  def create
    new_camper = Camper.create!(camper_params)
    render json: new_camper, status: :created
  end

  private

  def camper_params
    params.permit(:name, :age)
  end

  def render_not_found_response
    render json: { error: 'Camper not found' }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    render json: {
             errors: exception.record.errors.full_messages,
           },
           status: :unprocessable_entity
  end
end
