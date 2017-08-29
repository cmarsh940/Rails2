class EventsController < ApplicationController
  layout "one_column"
  
  def index
    @state_events = Event.where(state: current_user.state)
    @other_events = Event.where.not(state: current_user.state)
  end
  def create
    event = Event.new(event_params)
    unless event.save
      flash[:errors] = event.errors.full_messages
    end
    redirect_to user_path(current_user)
  end

  private 
  	def event_params
  		params.require(:event).permit(:name, :date, :address).merge(user: current_user)
  	end
end
