class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    @events = Event.all
    # @events = current_user.events.all.order(updated_at: :desc)

    render json: @events
  end

  # GET /events/1
  def show
    @events = current_user.event(event_params)
    # @user = User.find(params[:id])
    # @events = Event.find(params[:id])
    # @event.user_id = current_user.id
    # @events = Event.find(:set_event)
    # @events = Event.find(params[:id])
    # render json: Event.find(params[:id])
    render json: @events
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    # added
    # @event = current_user.event.build(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    @event.update(event_params)
    if @event.save
    render json: @event
    else
    render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
      # @event = Event.find(params[:id])
      # @event = current_user.events.find(params[:id])
      # binding.pry
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:title, :user_id)
    end
end
