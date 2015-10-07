class WelcomeController < ApplicationController
  include WelcomeHelper

  def index
    @events = Event.all.sort_by{|event| event.date}
    if params['off_campus'] == 'true'
  	 @events = @events.select { |event| event.off_campus?}
    elsif params['off_campus'] == 'false'
      @events = @events.select { |event| !event.off_campus?}
    end
  end

  def profile
    if current_user != nil
      @events = current_user.events
    end

  end

  def add_event_to_user
  	event = Event.find(params['my_event'])
  	if current_user != nil && event != nil && !current_user.events.include?(event)
  		current_user.events << event
  		current_user.events = current_user.events.uniq
      event.save
  	end
  	redirect_to '/#section-works'
  end

  def remove_event_to_user
  	event = Event.find(params['my_event'])
  	if current_user != nil && event != nil
  		current_user.events.delete(event)
  	end
  	redirect_to '/#section-works'
  end


  def add_event_to_user_js
    debugger
    event = Event.find(params['my_event'])
    user_id = User.find(params['user'])
    if current_user != nil && event != nil
      current_user.events << event
      current_user.events = current_user.events.uniq
    end
    redirect_to'#'
  end

  def master
    @events = Event.all
  end

  
  helper_method :add_event_to_user
end
