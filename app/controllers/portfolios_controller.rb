class PortfoliosController < ApplicationController
before_filter :authenticate_user!
  # GET /groups
  # GET /groups.json
  def index
    @portfolios = User.find(current_user.id).portfolios
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    id = params[:id]
    @portfolio = Portfolio.find(id) # look up movie by unique ID
    @groups = []
    @portfolio.projs.each do |proj|
      if ProjCss.where(proj_id: proj.id, portfolio_id: @portfolio.id).take.visible == true && @groups.include?(proj.group) == false
        @groups << proj.group
      end
    end
    
    if @portfolio.user_id != current_user.id
      flash[:notice] = "You are not authorized to view this page"
      redirect_to root_path
    end
  end

  # GET /groups/new
  def new
    @projects = User.find(current_user.id).projs
    @groups = User.find(current_user.id).groups
    @portfolio_titles = [""]
    Portfolio.where(:user_id => current_user.id).each do |portfolio|
      @portfolio_titles << portfolio.name
    end
    @templates = Portfolio.all_templates
  end

  # GET /groups/1/edit
  def edit
    user = User.find(current_user.id)
    if user.portfolios.find_by_id(params[:id]) == nil
      flash[:notice] = "You are not authorized to perform this operation"
      redirect_to root_path
    else
      @portfolio = Portfolio.find(params[:id])
      @projects = User.find(current_user.id).projs
      @groups = User.find(current_user.id).groups
      @portfolio_titles = [""]
      Portfolio.where(:user_id => current_user.id).each do |portfolio|
        if portfolio.name != @portfolio.name
            @portfolio_titles << portfolio.name
        end
      end
      @templates = Portfolio.all_templates
    end
  end

  # POST /groups
  # POST /groups.json
  def create
    #Create the portfolio and populate all values except specific css styling 
    if params[:portfolio][:name].empty?
        flash[:warning] = 'Portfolio name is required. Please try again.'
        redirect_to :back
    elsif !(Portfolio.where(:name => params[:portfolio][:name], :user_id => current_user.id).blank?)
           flash[:warning] = 'Your Portfolio name must be distinctive.'
           redirect_to :back
    else
      portfolio = Portfolio.new(portfolio_params)
      portfolio.projs = User.find(current_user.id).projs
      portfolio.groups = User.find(current_user.id).groups
      hostname=request.base_url || "www.heroku.com"
      
      portfolio.save
      
      portfolio.publicLink="#{hostname}/myportfolio/groups/#{portfolio.token}"
      portfolio.save
      
      #Set portfolio's user
      user = User.find(current_user.id)
      user.portfolios << portfolio
      user.save
      
      
      #Now populate the css styling
      if params[:portfolio][:portfolio_style] != ""  #If copying selected, populate all css styles from other portfolio
        copy_from_id = Portfolio.where(:name => params[:portfolio][:portfolio_style], :user_id => current_user.id).take.id
        Portfolio.copyCssInfo(copy_from_id, portfolio.id)
      else  #Otherwise, populate as normal
        #Set the visiblities to defaults
        portfolio.proj_csses.each do |proj_css|
          proj_css.visible = false
          proj_css.save
        end
        group_csses = GroupCss.where(:portfolio_id => portfolio.id)
      
        group_csses.each do |group_css|
          group_css.visible = false
          group_css.save
        end
        if(params[:projects] != nil) then
          ids = params[:projects].keys
          ids.each do |id|
            proj_css = ProjCss.where(portfolio_id: portfolio.id, proj_id: id).take
            proj_css.visible = true
            proj_css.save
            #Also make sure that the group is visible
            group_css = GroupCss.where(:portfolio_id => portfolio.id, :group_id => proj_css.proj.group.id).take
            group_css.visible = true
            group_css.save
          end
        end
        portfolio.save!
      end
      
      flash[:notice] = "#{portfolio.name} was successfully created."
      redirect_to portfolios_path
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
      user = User.find(current_user.id)
      if user.portfolios.find_by_id(params[:id]) != nil
        
        
        newPort = Portfolio.where(:name => params[:portfolio][:name], :user_id => current_user.id).take
        #Create the portfolio and populate all values except specific css styling 
        if params[:portfolio][:name].empty?
            flash[:warning] = 'Portfolio name is required. Please try again.'
            redirect_to :back
        elsif newPort != nil && newPort.id != params[:id].to_i()
               flash[:warning] = 'Your Portfolio name must be distinctive.'
               redirect_to :back
        else
          @portfolio = Portfolio.find(params[:id])
          @portfolio.name = params[:portfolio][:name]
          @portfolio.description = params[:portfolio][:description]
          @portfolio.randomStyle = params[:portfolio][:randomStyle]
          @portfolio.template = params[:portfolio][:template]
          @portfolio.public_view=params[:portfolio][:public_view]
          
          
          #Now set the Css settings
          if params[:portfolio][:portfolio_style] != ""  #If copying selected, populate all css styles from other portfolio
            copy_from_id = Portfolio.where(:name => params[:portfolio][:portfolio_style], :user_id => current_user.id).take.id
            Portfolio.copyCssInfo(copy_from_id, @portfolio.id)
          else
            # First set visibility of all projects and groups to false
            @portfolio.proj_csses.each do |proj_css|
              proj_css.visible = false
              proj_css.save
            end
            @portfolio.group_csses.each do |group_css|
              group_css.visible = false
              group_css.save
            end
            if(params[:projects] != nil) then
              ids = params[:projects].keys
              ids.each do |id|
                proj_css = ProjCss.where(portfolio_id: @portfolio.id, proj_id: id).take
                proj_css.visible = true
                proj_css.save
                #Also make sure that the group is visible
                group_css = GroupCss.where(:portfolio_id => @portfolio.id, :group_id => proj_css.proj.group.id).take
                group_css.visible = true
                group_css.save
              end
            end
            @portfolio.save
          end
          flash[:notice] = "#{@portfolio.name} was successfully updated."
          redirect_to portfolios_path
        end
      else
        flash[:notice] = "You are not authorized to perform this operation"
        redirect_to root_path
      end
    
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @portfolio = Portfolio.find(params[:id])
    if @portfolio.user_id == current_user.id
      @portfolio.destroy
      flash[:notice] = "Portfolio '#{@portfolio.name}' deleted."
      redirect_to portfolios_path
    else
      flash[:notice] = "You are not authorized to perform this operation"
      redirect_to root_path
    end
  end

################################################################################  
  
  def generateLink
   
    if Portfolio.find_by_token(params[:token])
      @portfolio = Portfolio.find_by_token(params[:token])
    else
      @portfolio = Portfolio.find(params[:token])
    end
    if @portfolio.user_id != current_user.id
      flash[:notice] = "You are not authorized to view this page"
    redirect_to portfolios_path
    end
  
  @hostname = request.base_url || "www.heroku.com"
  
  end

  

################################################################################

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def portfolio_params
      params.require(:portfolio).permit(:name, :description, :randomStyle, :template, :public_view)
    end
  
end
