class ProjsController < ApplicationController
  before_filter :authenticate_user!,  :except => [:show_project_show] #authenticate for users before any methods is called

  def permitFilter (project_params)
      project_params.permit(:name, :link,:description, :begin_date, :end_date, :impact, :keywords, :collaborator_emails,
                          :user_id,:group_id,:created_at, :updated_at, :proj_icon);
  end

  def add_CSS_for_new_project(user_id, project)
    #add CSS records of the new project
    portfolio = User.find(user_id).portfolios
    portfolio.each do |portfl|
      portfl.projs << project
      temp_proj_css = ProjCss.where(proj_id: project.id, portfolio_id: portfl.id).take
      temp_proj_css.visible = false
      temp_proj_css.save
    end
  end

  def create
      # raise params.inspect
      if 0 == current_user.groups.all.size
        flash[:warning] = 'You must first create groups then to create projects.'
        redirect_to groups_path
        return;
      end

      name = params[:proj][:name]
      name.strip!
      if name.empty?
        flash[:warning] = 'Project name is required. Please try again.'
        redirect_to :back
      elsif !(Proj.where({name: "#{name}", user_id: current_user.id}).blank?)
           flash[:warning] = 'Your project name must be distinctive.'
           redirect_to :back
      else
        project_params = params[:proj]
        project_params[:name] = project_params[:name].strip()
       
        if !is_begindate_previous_enddate?(project_params)
          flash[:warning] = 'Project begin date must be previous to the end date. Please try again.'
          redirect_to :back
        else
          @proj_new=Proj.new(permitFilter(project_params))
          if @proj_new.save
            project_params[:user_id] = current_user.id
            project_params[:group_id] = get_group_id_from_name(project_params[:group_id])
            newProj = Proj.new(permitFilter(project_params));
            User.find(current_user.id).projs << newProj;
            add_CSS_for_new_project(current_user.id, newProj)
            flash[:notice] = "Project #{project_params[:name]} is successfully created."
            redirect_to projs_path
          else
            flash[:warning] = 'Icon should be image file. Please try again.'
            redirect_to new_proj_path
          end
        end
      end

  end



  def new
      @group_array = get_group_names();
  end

  def index
     @projects = User.find(current_user.id).projs

  end

  def edit
      @proj = Proj.find(params[:id])
      @group_array = get_group_names()
      @selected_group = get_group_name_from_id(@proj.group_id)
  end

  def update
    if !is_begindate_previous_enddate?(params[:proj])
      flash[:warning] = 'Project begin date must be previous to the end date. Please try again.'
      redirect_to :back
    elsif !email_addresses_valid?(params[:proj][:collaborator_emails])
      flash[:warning] = 'There are illegal or repeated emails of collaborators, or an email is not in the our system account. Please check it again.'
      redirect_to :back
    else
      params[:proj][:group_id] = get_group_id_from_name(params[:proj][:group_id]);
      params[:proj][:collaborator_emails]  = params[:proj][:collaborator_emails].downcase
      params[:proj][:name] = params[:proj][:name].strip()
      @project = Proj.find(params[:id])
      if @project.update_attributes(permitFilter(params[:proj]))
        copy_email_array = copy_project_to_new_email_users(params[:proj][:collaborator_emails], @project)
        flash[:notice] = "Project #{@project.name} was successfully updated."
        if copy_email_array.size() > 0
          flash[:notice] = flash[:notice] + " And copied #{@project.name} to " + copy_email_array.to_s().delete!('[').delete(']').to_s + '.'
        end
        redirect_to projs_path
      else
        flash[:warning] = 'Icon should be image file. Please try again.'
        redirect_to edit_proj_path
      end
     end
  end

  def show
    #YouTubeIt::OAuth2Client.new(dev_key: 'AIzaSyACPr4hvXVbsjkroEZndKNK9ynl3SYHqQM')
    @proj = Proj.find(params[:id])
    @selected_group = get_group_name_from_id(@proj.group_id)
    @group_array = []
    @group_array.push(@selected_group)
    @videosLinkArray = []
    @videosNameArray = []
    @isYoutubeVideo = []
    if @proj.videos.size > 0
      @proj.videos.each do |video|
        # video link format: '//www.youtube.com/embed/auukuYuizq4','http://techslides.com/demos/sample-videos/small.mp4'
        if (video.link.include?('https://www.youtube.com/') || video.link.include?('https://youtu.be/'))
          video_link = '//www.youtube.com/embed/' + video.uid;
          @isYoutubeVideo.push(true)
        else
          video_link = video.link;
          @isYoutubeVideo.push(false)
        end
        @videosLinkArray.push(video_link);
        @videosNameArray.push(video.title);
      end
    end
  end

  def destroy
      # cannot use Proj.delete because it will not invoke cascade delete to proj_csses
      # Proj.delete(params[:id])
      @project = Proj.find(params[:id])
      @project.destroy
      flash[:notice] = 'A project was deleted successfully.'
      redirect_to projs_path
  end

  def get_group_names
    user_group = Group.where({user_id: current_user.id});
    group_array = [];
    user_group.each do |group|
      group_array.push(group.name)
    end
    return group_array
  end

  def get_group_id_from_name(groupname)
      user_group = Group.where({name: "#{groupname}", user_id: current_user.id})
      if (user_group.size() > 0)
         return user_group.first.id;
      else
         return 0;
      end
  end

  def get_group_name_from_id(groupid)
      group = Group.where({id:groupid, user_id: current_user.id})
      if (group.size() > 0)
         return group.first.name;
      else
         return "Unknown"
      end
  end

  def is_begindate_previous_enddate?(projectParams)
      if projectParams['begin_date(1i)'].to_i < projectParams['end_date(1i)'].to_i
         return true;
      elsif  (projectParams['begin_date(1i)'].to_i == projectParams['end_date(1i)'].to_i  &&
              projectParams['begin_date(2i)'].to_i < projectParams['end_date(2i)'].to_i)
         return true;
      elsif (projectParams['begin_date(1i)'].to_i == projectParams['end_date(1i)'].to_i  &&
             projectParams['begin_date(2i)'].to_i == projectParams['end_date(2i)'].to_i  &&
             projectParams['begin_date(3i)'].to_i <= projectParams['end_date(3i)'].to_i)
         return true;
      else
         return false;
      end
  end

  def email_addresses_valid?(emails)
    emails.delete!(' ')
    if emails.empty?
      return true
    else
      emails.downcase!()
      email_array = emails.split(';')
      email_array_unique = email_array.uniq();
      if (email_array_unique.size() != email_array.size())
         return false;
      end
      email_regexp = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
      all_emails = User.pluck(:email)
      email_array.each do |email|
         index = email_regexp =~ email
         if (0 != index || !all_emails.include?(email))
            return false
         end
      end
    end
    return true
  end

  def trim_hash(hashInput, keysArray)
       keysArray.each do |key|
         hashInput.delete(key)
       end
       return hashInput;
  end

  def copy_project_to_new_email_users (emails, project)
      emails.delete!(' ')
      if emails.empty?
         return []
      else
        emails.downcase!()
        email_array = emails.split(';')
        copy_email_array = []
        email_array.each do |email|
          user = User.find_by_email(email)
          selfemail = current_user.email
          user_has_this_project = false
          user.projs.each do |proj|
             if proj.name.downcase == project.name.downcase
               user_has_this_project = true
               break
             end
          end
          if user_has_this_project
             next
          end
          copy_email_array.push(email)

          dupProjHash = trim_hash(project.dup.as_json,['id'])

          #replace email with sender's email
          dupProjHash['collaborator_emails'] = dupProjHash['collaborator_emails'].gsub(email, selfemail);

          newProj = user.projs.create(dupProjHash)

          add_CSS_for_new_project(user.id, newProj)
        end
        return copy_email_array
      end
  end

######################################################################################
#################   show project details without login   #################

  def get_group_name_from_id_without_login(groupid,userid)
    group = Group.where({id:groupid, user_id: userid})
    if (group.size() > 0)
       return group.first.name;
    end
  end

  def show_project_show
    #puts 1111111
    #puts 'token for project show'
    #puts params
    #puts 1111111
    
    @token = params[:token]
    @proj = Proj.find(params[:format])
    @selected_group = get_group_name_from_id_without_login(@proj.group_id, @proj.user_id)
    @group_array = []
    @group_array.push(@selected_group)
    @videosLinkArray = []
    @videosNameArray = []
    if @proj.videos.size > 0
      @proj.videos.each do |video|
        # video link format: '//www.youtube.com/embed/auukuYuizq4','http://techslides.com/demos/sample-videos/small.mp4'
        if (video.link.include?('https://www.youtube.com/') || video.link.include?('https://youtu.be/'))
          video_link = '//www.youtube.com/embed/' + video.uid;
        else
          video_link = video.link;
        end
        @videosLinkArray.push(video_link);
        @videosNameArray.push(video.title);
      end
    end
  end

end