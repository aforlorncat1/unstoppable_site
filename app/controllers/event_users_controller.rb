class EventUsersController < ApplicationController
  
  def create
    @event = Event.find(params[:event_user][:attended_event_id])
    current_user.attend!(@event)
    redirect_to @event
  end

  def destroy
    @event = EventUser.find(params[:id]).attended_event
    current_user.cancel!(@event)
    redirect_to @event
  end


end
