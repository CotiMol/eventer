include ActiveSupport

class EventsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  # GET /events
  # GET /events.json
  def index
    @events = Event.visible.all(:order => 'date')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    @countries = Country.all
    @trainers = Trainer.all
    @timezones = TimeZone.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @timezones = TimeZone.all
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @timezones = TimeZone.all

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: t('flash.event.create.success') }
        format.json { render json: @event, status: :created, location: @event }
      else
        flash.now[:error] = t('flash.failure')
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        if @event.cancelled
          format.html { redirect_to events_path, notice: t('flash.event.cancel.success') }
        else
          format.html { redirect_to events_path, notice: t('flash.event.update.success') }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
  
  def start_webinar
    @event = Event.find(params[:id])
  end
  
  def broadcast_webinar
    @event = Event.find(params[:id])
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        if @event.is_webinar?
          
          if @event.notify_webinar_start?
            
            hostname = "http://" + request.remote_addr
            port = request.port
            
            if port != 80
              hostname += ":" + port.to_s
            end
            
            webinar_link = hostname + "/public_events/#{@event.id.to_s}/watch"
            
            @event.participants.confirmed.each do |participant|
              EventMailer.delay.notify_webinar_start(participant, webinar_link)
            end
          end
          
          flash.now[:notice] = t('flash.event.webinar.broadcasting')
          format.html
        end
      else
        format.html { render action: "start_webinar" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
end
