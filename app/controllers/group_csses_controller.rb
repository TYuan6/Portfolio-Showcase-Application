class GroupCssesController < ApplicationController
before_filter :authenticate_user!, :except => [:show_group]

    def show
        @csses = GroupCss.where(:portfolio_id => params[:portfolio_id])
        @visible_css = GroupCss.where(:portfolio_id => params[:portfolio_id], :visible => true)
        @visible_css_static, @visible_css_not_static = GroupCss.get_static_nonstatic_group_csses(params[:portfolio_id])
        @editing = false
        if Portfolio.find(params[:portfolio_id]).user_id != current_user.id
            flash[:error] = "You are not authorized to view this page"
            redirect_to root_path
        end
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
    
    def edit
        #Filter the csses so that @css only has projects of the right group
        @defaults = GroupCss.all_defaults
        @hovers = GroupCss.all_hovers
        @shadows = GroupCss.all_shadows
        @positions = GroupCss.all_positions
        @fonts = GroupCss.all_fonts
        @portfolio = Portfolio.find(params[:portfolio_id])
        if @portfolio.randomStyle
            flash[:error] = "Randomized styling is set for this portfolio, save your portfolio to set the style to the randomly generated one or turn it off here (#{view_context.link_to('Edit Portfolio Settings', edit_portfolio_path(@portfolio.id))})"
            flash.discard(:error)
        end
        @css = GroupCss.where(:portfolio_id => params[:portfolio_id])
        @visible_css = GroupCss.where(:portfolio_id => params[:portfolio_id], :visible => true)
        @visible_css_static, @visible_css_not_static = GroupCss.get_static_nonstatic_group_csses(params[:portfolio_id])
        @editing = true
        if @portfolio.user_id != current_user.id
            flash[:error] = "You are not authorized to view this page"
            redirect_to root_path
        end
        @randomStyle = false
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
        @portfolio.template = ""
    end
    
    def update
        if Portfolio.find(params[:portfolio_id].to_i()).user_id != current_user.id
            flash[:error] = "You are not authorized to view this page"
            redirect_to root_path
        else
            group_css_extra_errors = {}
            group_css_errors = {}
            port = params[:portfolio]
            port.keys.each do |currKey|
                if currKey != "portfolio_style"
                    errors, extra_errors = save_proj_css(port[currKey])
                    if errors.size() != 0 
                        group_css_errors.store(currKey.remove("group_csses"), errors)
                    end
                    if extra_errors.size != 0
                        group_css_extra_errors.store(currKey.remove("group_csses"), extra_errors)
                    end
                end
            end
            if group_css_errors.size() != 0 || group_css_extra_errors.size() != 0
                populateFlash(group_css_errors, group_css_extra_errors)
            else
                flash[:notice] = "Settings updated successfully"
            end
            redirect_to(portfolio_group_csses_edit_path(params[:portfolio_id]))
        end
    end
    
    
    
    
    def save_proj_css (group_css_hash)
        group_css_to_edit = GroupCss.find(group_css_hash[:id].to_i())
        group_css_to_edit.visible = ((group_css_hash[:visible] == "1") ? true : false)
        group_css_to_edit.defaultStyle = group_css_hash[:defaultStyle]
        group_css_to_edit.width = group_css_hash[:width]
        group_css_to_edit.height = group_css_hash[:height]
        group_css_to_edit.color = group_css_hash[:color]
        group_css_to_edit.backgroundColor = group_css_hash[:backgroundColor]
        if group_css_hash[:defaultStyle] != ""
            group_css_to_edit.color = ""
            group_css_to_edit.backgroundColor = ""
            group_css_to_edit.height = ""
            group_css_to_edit.width = ""
        end
        if group_css_hash[:hover] != ""
            group_css_to_edit.color = ""
            group_css_to_edit.backgroundColor = ""
        end
        group_css_to_edit.position = group_css_hash[:position]
        group_css_to_edit.top = group_css_hash[:top]
        group_css_to_edit.left = group_css_hash[:left]
        group_css_to_edit.font = group_css_hash[:font]
        group_css_to_edit.fontSize = group_css_hash[:fontSize]
        group_css_to_edit.opacity = group_css_hash[:opacity]
        group_css_to_edit.borderRadius = group_css_hash[:borderRadius]
        group_css_to_edit.borderColor = group_css_hash[:borderColor]
        group_css_to_edit.borderSize = group_css_hash[:borderSize]
        group_css_to_edit.boxShadow = group_css_hash[:boxShadow]
        group_css_to_edit.hover = group_css_hash[:hover]
        group_css_to_edit.background = ((group_css_hash[:background] == "1") ? true : false)
        
        extra_errors = width_plus_left_valid?(group_css_hash[:width], group_css_hash[:left], group_css_hash[:position])
        if group_css_to_edit.valid? && extra_errors == ""
            group_css_to_edit.save
        end
        return group_css_to_edit.errors, extra_errors
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
        errors.keys.each do |group_key|
            tempCss = GroupCss.find(group_key)
            flashMessage += "<li>" + tempCss.group.name + "</li><ul>"
           errors[group_key].full_messages.each do |errorObject|
               flashMessage += "<li>" + errorObject + "</li>"
           end
           if extra_errors.keys.include?(group_key)
                flashMessage += "<li>" + extra_errors[group_key] + "</li>"
            end
           flashMessage += "</ul>"
        end
        extra_errors.keys.each do |group_key|
            if errors.keys.include?(group_key) == false
                tempCss = GroupCss.find(group_key)
                flashMessage += "<li>" + tempCss.group.name + "</li><ul>"
                flashMessage += "<li>" + extra_errors[group_key] + "</li>"
                flashMessage += "</ul>"
            end
        end
        flashMessage += "</ul>"
        flash[:warning] = flashMessage
    end
    

 # "for sharing group without user login"
    def show_group
        
        @token = params[:token]
        @portfolio = Portfolio.find_by_token(@token)
        @csses = GroupCss.where(:portfolio_id => @portfolio.id)
        @visible_css = GroupCss.where(:portfolio_id => @portfolio.id, :visible => true)
        @visible_css_static, @visible_css_not_static = GroupCss.get_static_nonstatic_group_csses(@portfolio.id)
        @editing = false
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