class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    #@videos = Video.all
    @current_project=Proj.find(params[:project_id])
    @videos = @current_project.videos
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    YouTubeIt::OAuth2Client.new(dev_key: 'AIzaSyACPr4hvXVbsjkroEZndKNK9ynl3SYHqQM')
    @video=Video.find(params[:id])
    @video_flag=false
    if (@video.link.include?('https://www.youtube.com/') || @video.link.include?('https://youtu.be/'))
      @video_link = '//www.youtube.com/embed/' + @video.uid;
      @video_flag=true
      # puts("enter first");
      # puts(@video_link);
    else
      @video_link = @video.link;
      # puts("enter second");

    end
    @project=@video.proj
  end

  # GET /videos/new
  def new
    #@video = Video.new
    @current_project=Proj.find(params[:project_id])
    # puts "************new************"
    # puts @current_project.name
    # puts "************new************"
    @video = @current_project.videos.new
  end

  # GET /videos/1/edit
  def edit
    @current_project=@video.proj
  end

  # POST /videos
  # POST /videos.json
  def create
    # raise params.inspect
    @current_project=Proj.find(params[:video][:project_id])
    
    @video = @current_project.videos.new(video_params)

    respond_to do |format|
      val = @video.save
      # raise @video.errors.inspect
      if val
        format.html { redirect_to videos_url(:project_id=>@current_project.id), notice: 'Video was successfully created.' }
        format.json { render :index, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    @current_project=Proj.find(params[:video][:project_id])
    @video=@current_project.videos.find(params[:id])
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    #@video.destroy
    @temp_video=Video.find(params[:id])
    @current_project=@temp_video.proj
    @video=@current_project.videos.find(params[:id])
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url(:project_id=>@current_project.id), notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      # params.fetch(:video, {})
      #params.require(:video).permit(:proj_video_meta, :data_type)
      params.require(:video).permit(:title, :link)
    end
end
