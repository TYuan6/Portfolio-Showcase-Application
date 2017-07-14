class PicturesController < ApplicationController
  before_filter :authenticate_user!  #authenticate for users before any methods is called
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    #@pictures = Picture.all
    # puts "*******index params********"
    # puts params[:pictures]
    # puts "*******index params********"
    @current_project=Proj.find(params[:project_id])
    @pictures = @current_project.pictures
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    #@asset=current_user.assets.find(params[:id])
    # @picture=current_user.pictures.find(params[:id])
    @picture=Picture.find(params[:id])
    @project=@picture.proj
  end

  # GET /pictures/new
  def new
    #@picture = Picture.new
    @current_project=Proj.find(params[:project_id])
    # puts "************new************"
    # puts @current_project.name
    # puts "************new************"
    @picture = @current_project.pictures.new
  end

  # GET /pictures/1/edit
  def edit
    # @picture = current_user.pictures.find(params[:id])
    @current_project=@picture.proj
  end

  # POST /pictures
  # POST /pictures.json
  def create
    #@picture = Picture.new(picture_params)
    # puts "**********create**************"
    # puts params[:project_id]
    # puts "************create************"
    #raise.params.inspect
    # raise params.inspect
    @current_project=Proj.find(params[:picture][:project_id])
    
    @picture = @current_project.pictures.new(picture_params)
    #@picture = Picture.new(picture_params)

    respond_to do |format|
      val = @picture.save
      # raise @picture.errors.inspect
      if val
        format.html { redirect_to pictures_url(:project_id=>@current_project.id), notice: 'Picture was successfully created.' }
        format.json { render :index, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    # raise params.inspect
    #@picture=current_user.pictures.find(params[:id])
    @current_project=Proj.find(params[:picture][:project_id])
    @picture=@current_project.pictures.find(params[:id])
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    #@current_project=Proj.find(params[:project_id])
    @temp_picture=Picture.find(params[:id])
    @current_project=@temp_picture.proj
    @picture=@current_project.pictures.find(params[:id])
    @picture.destroy
    # redirect_to pictures_path(:project_id=>@current_project.id)
    respond_to do |format|
      format.html { redirect_to pictures_url(:project_id=>@current_project.id), notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:project_img)
    end
end
