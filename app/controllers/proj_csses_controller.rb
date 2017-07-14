class ProjCssesController < ApplicationController
before_filter :authenticate_user!, :except => [:show_project]

    def show
        @csses = []
        tempCsses = ProjCss.where(:portfolio_id => params[:portfolio_id])
        tempCsses.each do |tempCss|
           #puts("*****Prj id:")
           #puts(tempCss.proj)
           #puts("******")
           if tempCss.proj.group.id.to_i() == params[:group_id].to_i()
              @csses << tempCss 
           end
        end
        @visible_css = ProjCss.get_visible_group_proj_csses(params[:portfolio_id], params[:group_id])
        @visible_css_static, @visible_css_not_static = ProjCss.get_static_nonstatic_proj_csses(params[:portfolio_id], params[:group_id])
        @portfolio = Portfolio.find(params[:portfolio_id])
        @editing = false
        if @portfolio.user_id != current_user.id
            flash[:error] = "You are not authorized to view this page"
            redirect_to root_path
        end
        if @portfolio.template != ""
            @css = ProjCss.setTemplate(@csses)
            @visible_css_static = []
            @css.each do |x|
                if x.visible
                    @visible_css_static << x
                end
            end
            @visible_css_not_static = []
            if @portfolio.template == "Colorful"
                @visible_css_static.each do |x|
                    x.defaultStyle = Portfolio.all_colors.sample[0]
                end
            end
        end
    end
    
    def edit
        #Filter the csses so that @css only has projects of the right group
        @defaults = ProjCss.all_defaults
        @hovers = ProjCss.all_hovers
        @shadows = ProjCss.all_shadows
        @positions = ProjCss.all_positions
        @fonts = ProjCss.all_fonts
        @portfolio = Portfolio.find(params[:portfolio_id])
        if @portfolio.randomStyle
            flash[:error] = "Randomized styling is set for this portfolio, save your portfolio to set the style to the randomly generated one or turn it off here (#{view_context.link_to('Edit Portfolio Settings', edit_portfolio_path(@portfolio.id))})"
            flash.discard(:error)
        end 
        @css = ProjCss.get_group_proj_csses(params[:portfolio_id], params[:group_id])
        @visible_css = ProjCss.get_visible_group_proj_csses(params[:portfolio_id], params[:group_id])
        @visible_css_static, @visible_css_not_static = ProjCss.get_static_nonstatic_proj_csses(params[:portfolio_id], params[:group_id])
        @editing = true
        @randomStyle = false
        @groupId = params[:group_id]
        if @portfolio.randomStyle
            @css = ProjCss.get_random_static_nonstatic_csses(@css)
            @visible_css_static = []
            @css.each do |x|
                if x.visible
                    @visible_css_static << x
                end
            end
            @visible_css_not_static = []
            @randomStyle = true
        end
        if @portfolio.user_id != current_user.id
            flash.now[:error] = "You are not authorized to view this page"
            redirect_to root_path
        end
        @portfolio.template = ""
    end
    
    def update
        
        if Portfolio.find(params[:portfolio_id].to_i()).user_id != current_user.id
            flash[:error] = "You are not authorized to view this page"
            redirect_to root_path
        else
            proj_css_errors = {}
            proj_css_extra_errors = {}
            port = params[:portfolio]
            port.keys.each do |currKey|
                errors, extra_errors = save_proj_css(port[currKey])
                if errors.size() != 0
                    proj_css_errors.store(currKey.remove("proj_csses"), errors)
                end    
                if extra_errors.size != 0
                    proj_css_extra_errors.store(currKey.remove("proj_csses"), extra_errors)
                end
            end
            if proj_css_errors.size() != 0 || proj_css_extra_errors.size() != 0
                populateFlash(proj_css_errors, proj_css_extra_errors)
            else
                flash[:notice] = "Settings updated successfully"
            end
            redirect_to(portfolio_proj_csses_edit_path(params[:portfolio_id], params[:group_id]))
        end
    end
    
    
    
    
    def save_proj_css (proj_css_hash)
        proj_css_to_edit = ProjCss.find(proj_css_hash[:id])
        proj_css_to_edit.visible = ((proj_css_hash[:visible] == "1") ? true : false)
        proj_css_to_edit.defaultStyle = proj_css_hash[:defaultStyle]
        proj_css_to_edit.width = proj_css_hash[:width]
        proj_css_to_edit.height = proj_css_hash[:height]
        proj_css_to_edit.color = proj_css_hash[:color]
        proj_css_to_edit.backgroundColor = proj_css_hash[:backgroundColor]
        if proj_css_hash[:defaultStyle] != ""
            proj_css_to_edit.color = ""
            proj_css_to_edit.backgroundColor = ""
            proj_css_to_edit.height = ""
            proj_css_to_edit.width = ""
        end
        if proj_css_hash[:hover] != ""
            proj_css_to_edit.color = ""
            proj_css_to_edit.backgroundColor = ""
        end
        proj_css_to_edit.position = proj_css_hash[:position]
        proj_css_to_edit.top = proj_css_hash[:top]
        proj_css_to_edit.left = proj_css_hash[:left]
        proj_css_to_edit.font = proj_css_hash[:font]
        proj_css_to_edit.fontSize = proj_css_hash[:fontSize]
        proj_css_to_edit.opacity = proj_css_hash[:opacity]
        proj_css_to_edit.borderRadius = proj_css_hash[:borderRadius]
        proj_css_to_edit.borderColor = proj_css_hash[:borderColor]
        proj_css_to_edit.borderSize = proj_css_hash[:borderSize]
        proj_css_to_edit.boxShadow = proj_css_hash[:boxShadow]
        proj_css_to_edit.hover = proj_css_hash[:hover]
        proj_css_to_edit.background = ((proj_css_hash[:background] == "1") ? true : false)
        
        extra_errors = width_plus_left_valid?(proj_css_hash[:width], proj_css_hash[:left], proj_css_hash[:position])
        if proj_css_to_edit.valid? && extra_errors == ""
            proj_css_to_edit.save
        end
        return proj_css_to_edit.errors, extra_errors
    end
    
    def width_plus_left_valid?(width, left, position)
        if (width.to_i() + left.to_i()) > 100 && position != "static"
          return "Width + Left on non-static must be less than 100"
        else
            return ""
        end
    end
    
    def populateFlash(errors, extra_errors)
        flashMessage = "Update failed due to following errors: <ul>"
        #raise errors.inspect
        errors.keys.each do |proj_key|
            tempCss = ProjCss.find(proj_key)
            flashMessage += "<li>" + tempCss.proj.name + "</li><ul>"
            errors[proj_key].full_messages.each do |errorObject|
               flashMessage += "<li>" + errorObject + "</li>"
            end
            if extra_errors.keys.include?(proj_key)
                flashMessage += "<li>" + extra_errors[proj_key] + "</li>"
            end
            flashMessage += "</ul>"
        end
        extra_errors.keys.each do |proj_key|
            if errors.keys.include?(proj_key) == false
                tempCss = ProjCss.find(proj_key)
                flashMessage += "<li>" + tempCss.proj.name + "</li><ul>"
                flashMessage += "<li>" + extra_errors[proj_key] + "</li>"
                flashMessage += "</ul>"
            end
        end
        flashMessage += "</ul>"
        flash[:warning] = flashMessage
    end
    
   # "for sharing project without user login"
    def show_project
        
        #puts 'token for project css'
        #puts params
        #puts 1111111
        
        @token = params[:token]
        @portfolio = Portfolio.find_by_token(@token)
        
        #puts 'details for portfolio'
        #puts @portfolio.inspect
        #puts 1111111
        
        params[:portfolio_id]= @portfolio.id
        params[:group_id] = params[:format]
      
        @csses = []
        tempCsses = ProjCss.where(:portfolio_id => params[:portfolio_id])
        tempCsses.each do |tempCss|
           if tempCss.proj.group.id == params[:group_id].to_i()
              @csses << tempCss 
           end
        end
        
        @visible_css = ProjCss.get_visible_group_proj_csses(params[:portfolio_id], params[:group_id])
        @visible_css_static, @visible_css_not_static = ProjCss.get_static_nonstatic_proj_csses(params[:portfolio_id], params[:group_id])
        @portfolio = Portfolio.find(params[:portfolio_id])
        if @portfolio.template != ""
            @css = ProjCss.setTemplate(@csses)
            @visible_css_static = []
            @css.each do |x|
                if x.visible
                    @visible_css_static << x
                end
            end
            @visible_css_not_static = []
            if @portfolio.template == "Colorful"
                @visible_css_static.each do |x|
                    x.defaultStyle = Portfolio.all_colors.sample[0]
                end
            end
        end
    end
    

end