class ProfilesController < ApplicationController
  before_filter :require_no_user, :except => [:show, :index, :destroy, :edit, :update]
  before_filter :require_user, :except => [:new, :create]
  
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.page(params[:page]).order(:updated_at => 'DESC')
    @json = @profiles.to_gmaps4rails
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @profile = Profile.find(params[:id])
    @json = @profile.to_gmaps4rails
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.json
  def new
    @profile = Profile.new
    @profile.build_user
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
    if current_user.id != @profile.user.id
      flash[:error] =  "Impossible de modifier un profil autre que le votre"
      respond_to do |format|
        format.html {redirect_to profiles_url }
        format.json { render json: @profile.errors, status: 'Impossible de modifier ce profil' }
      end
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    logger.info("CREATE PROFILE #{params[:profile].inspect}")
    @profile = Profile.new(params[:profile])
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])
    logger.debug("UPDATE PROFILE @profile = #{@profile.inspect}")
    logger.debug("UPDATE PROFILE params = #{params[:profile].inspect}")
    logger.debug("UPDATE PROFILE update_attributes #{@profile.update_attributes(params[:profile]).inspect}")
    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end
end