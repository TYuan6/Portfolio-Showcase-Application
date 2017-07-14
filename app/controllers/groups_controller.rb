class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /groups
  # GET /groups.json
  def index
      @groups = Group.all
  end
  
  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  #   def create
  #   @group_hash = group_params
  #   @group_hash["user"] = current_user
  #   @group = Group.new(@group_hash)

  #   respond_to do |format|
  #   if @group.save
  #       # linking group css
  # #      portfolio = User.find(current_user.id).portfolios
  # #      portfolio.each do |port|
  # #      port.group << @group
  # #      temp_group_css = GroupCss.where(group_id: @group.id, portfolio_id: port.id).take
  # #      temp_group_css = GroupCss.new(group_id: @group.id, portfolio_id: port.id)
  # #      temp_group_css.save
  # #      end 
    

  #       format.html { redirect_to groups_url, notice: 'Group was successfully created.' }
  #       format.json { render :index, status: :created, location: @group }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @group.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  
  def create
    @group_hash = group_params
    @group_hash["user"] = current_user

  
    # check for 'Group name must be unique.'
  #  groups = Group.all.where(:user => current_user)
  #  groups.each do |group|
  #    if group.name == @group_hash["name"] 
  #      flash[:warning] = 'Group name must be unique.'
  #      redirect_to new_group_path
  #      return
  #    end
  #    if "" == @group_hash["name"] 
  #      flash[:warning] = 'Group name cannot be empty.'
  #      redirect_to new_group_path
  #      return
  #    end
  #  end

    @group = Group.new(@group_hash)
    
    respond_to do |format|
      if @group.save
          portfolio = User.find(current_user.id).portfolios
       portfolio.each do |port|
        port.groups << @group
       end 
        format.html { redirect_to groups_url, notice: 'Group was successfully created.' }
        format.json { render :index, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    @group_hash = group_params

    @group_hash["user"] = current_user
    
  #  groups = Group.all.where(:user => current_user)
  #  groups.each do |group|
  #    if group.name == @group_hash["name"] 
  #      flash[:warning] = 'Group name must be unique.'
  #      redirect_to new_group_path
  #      return
  #    end
  #    if "" == @group_hash["name"] 
  #      flash[:warning] = 'Group name cannot be empty.'
  #      redirect_to new_group_path
  #      return
  #    end
  #  end
    
    respond_to do |format|
      if @group.update(@group_hash)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description, :group_icon)
    end
end
