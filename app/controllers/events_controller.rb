class EventsController < ApplicationController
  before_action :set_new_event_path, only: :new
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_user_org, only: [:new]



  def cats
    [
      'Greek','Party','Politics','Fundraiser','Concert','International','Speaker',
      'Sports','StudyBreak','Theatre','HipHop','Rap','Country','Indie','Rock','Entrepeneur',
      'Engineering','Careers','Bars','Free','Freshman','Sophomore',
      'Junior','Senior','FridayNight','SaturdayNight','Food','Drinks','Culture', ''
    ].sort
  end



  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new

    @cats = cats
    @selected_cats = []
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @cats = cats
    @selected_cats = @event.categories
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)


    respond_to do |format|
      if @event.save
        format.html { redirect_to '/#section-works', notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to '/#section-works', notice: 'Event was successfully created.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @org = @event.organization
    @event.destroy
    respond_to do |format|
      format.html { redirect_to @org, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      es = params['event']['categories'].uniq
      es.delete('')
      params['event']['categories'] = es
      params.require(:event).permit!
      # params.require(:event).permit(:title, :description, :location, :date, :price, :tickets, :categories, :trasportation_details)

    end

    def check_user_org
      authenticate_user!

      org = Organization.find(params['org_id'].to_i)
      if !current_user.organizations.include?(org)
        redirect_to current_user
      end

    end

    def set_new_event_path
          if !user_signed_in?
            redirect_to root_path(:sign_up => :true)
          elsif current_user.organizations.size == 0
            redirect_to new_organization_path(:from_home => :true)
          else
            params['org_id'] = current_user.organizations.first.id
          end
    end



end
