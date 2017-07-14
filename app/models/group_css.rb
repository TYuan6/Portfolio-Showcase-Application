class GroupCss < ActiveRecord::Base
    belongs_to :group
    belongs_to :portfolio
    
    after_initialize :init
    
    
    def self.all_defaults
        temp = [["", ""], ["Red - Square - Small", "smallRed"], ["Red - Square - Medium", "mediumRed"], ["Red - Square - Large", "largeRed"], ["Red - Wide - Small", "smallWideRed"], ["Red - Wide - Medium", "mediumWideRed"], ["Red - Wide - Large", "largeWideRed"], ["Red - Tall - Small", "smallTallRed"], ["Red - Tall - Medium", "mediumTallRed"], ["Red - Tall - Large", "largeTallRed"], ["Orange - Square - Small", "smallOrange"], ["Orange - Square - Medium", "mediumOrange"], ["Orange - Square - Large", "largeOrange"], ["Orange - Wide - Small", "smallWideOrange"], ["Orange - Wide - Medium", "mediumWideOrange"], ["Orange - Wide - Large", "largeWideOrange"], ["Orange - Tall - Small", "smallTallOrange"], ["Orange - Tall - Medium", "mediumTallOrange"], ["Orange - Tall - Large", "largeTallOrange"], ["Yellow - Square - Small", "smallYellow"], ["Yellow - Square - Medium", "mediumYellow"], ["Yellow - Square - Large", "largeYellow"], ["Yellow - Wide - Small", "smallWideYellow"], ["Yellow - Wide - Medium", "mediumWideYellow"], ["Yellow - Wide - Large", "largeWideYellow"], ["Yellow - Tall - Small", "smallTallYellow"], ["Yellow - Tall - Medium", "mediumTallYellow"], ["Yellow - Tall - Large", "largeTallYellow"], ["Green - Square - Small", "smallGreen"], ["Green - Square - Medium", "mediumGreen"], ["Green - Square - Large", "largeGreen"], ["Green - Wide - Small", "smallWideGreen"], ["Green - Wide - Medium", "mediumWideGreen"], ["Green - Wide - Large", "largeWideGreen"], ["Green - Tall - Small", "smallTallGreen"], ["Green - Tall - Medium", "mediumTallGreen"], ["Green - Tall - Large", "largeTallGreen"], ["Blue - Square - Small", "smallBlue"], ["Blue - Square - Medium", "mediumBlue"], ["Blue - Square - Large", "largeBlue"], ["Blue - Wide - Small", "smallWideBlue"], ["Blue - Wide - Medium", "mediumWideBlue"], ["Blue - Wide - Large", "largeWideBlue"], ["Blue - Tall - Small", "smallTallBlue"], ["Blue - Tall - Medium", "mediumTallBlue"], ["Blue - Tall - Large", "largeTallBlue"], ["Indigo - Square - Small", "smallIndigo"], ["Indigo - Square - Medium", "mediumIndigo"], ["Indigo - Square - Large", "largeIndigo"], ["Indigo - Wide - Small", "smallWideIndigo"], ["Indigo - Wide - Medium", "mediumWideIndigo"], ["Indigo - Wide - Large", "largeWideIndigo"], ["Indigo - Tall - Small", "smallTallIndigo"], ["Indigo - Tall - Medium", "mediumTallIndigo"], ["Indigo - Tall - Large", "largeTallIndigo"], ["Violet - Square - Small", "smallViolet"], ["Violet - Square - Medium", "mediumViolet"], ["Violet - Square - Large", "largeViolet"], ["Violet - Wide - Small", "smallWideViolet"], ["Violet - Wide - Medium", "mediumWideViolet"], ["Violet - Wide - Large", "largeWideViolet"], ["Violet - Tall - Small", "smallTallViolet"], ["Violet - Tall - Medium", "mediumTallViolet"], ["Violet - Tall - Large", "largeTallViolet"], ["Grey - Square - Small", "smallGrey"], ["Grey - Square - Medium", "mediumGrey"], ["Grey - Square - Large", "largeGrey"], ["Grey - Wide - Small", "smallWideGrey"], ["Grey - Wide - Medium", "mediumWideGrey"], ["Grey - Wide - Large", "largeWideGrey"], ["Grey - Tall - Small", "smallTallGrey"], ["Grey - Tall - Medium", "mediumTallGrey"], ["Grey - Tall - Large", "largeTallGrey"], ["Black - Square - Small", "smallBlack"], ["Black - Square - Medium", "mediumBlack"], ["Black - Square - Large", "largeBlack"], ["Black - Wide - Small", "smallWideBlack"], ["Black - Wide - Medium", "mediumWideBlack"], ["Black - Wide - Large", "largeWideBlack"], ["Black - Tall - Small", "smallTallBlack"], ["Black - Tall - Medium", "mediumTallBlack"], ["Black - Tall - Large", "largeTallBlack"]]
    end
    
    def self.all_defaults_check
        temp = [] 
        GroupCss.all_defaults.each do |x| 
            temp << x[1]
        end
        return temp
    end

    def self.all_hovers
       temp = [[""], ["hoverRed"], ["hoverOrange"], ["hoverYellow"], ["hoverGreen"], ["hoverBlue"], ["hoverIndigo"], ["hoverViolet"], ["hoverGrey"], ["hoverBlack"]] 
    end
    
    def self.all_hovers_check
        temp = [] 
        GroupCss.all_hovers.each do |x| 
            temp << x[0]
        end
        return temp
    end
    
    def self.all_shadows
       temp = [[""], ["shadowRed"], ["shadowOrange"], ["shadowYellow"], ["shadowGreen"], ["shadowBlue"], ["shadowIndigo"], ["shadowViolet"], ["shadowGrey"], ["shadowBlack"]] 
    end
    
    def self.all_shadows_check
        temp = [] 
        GroupCss.all_shadows.each do |x| 
            temp << x[0]
        end
        return temp
    end
    
    def self.all_positions
       temp = [["static"], ["absolute"], ["fixed"]] 
    end
    
    def self.all_positions_check
        temp = [] 
        GroupCss.all_positions.each do |x| 
            temp << x[0]
        end
        return temp
    end
    
    def self.all_fonts
       temp = [["Times New Roman"], ["Arial"], ["Verdana"], ["Courier New"]] 
    end
    
    def self.all_fonts_check
        temp = [] 
        GroupCss.all_fonts.each do |x| 
            temp << x[0]
        end
        return temp
    end
    
    validates :defaultStyle, :inclusion => {:in => self.all_defaults_check}
    validates :position, :inclusion => {:in => self.all_positions_check}
    validates :width, allow_blank: true, numericality: {:greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 100.0}
    validates :height, allow_blank: true, numericality: {:greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 100.0}
    validates :top, allow_blank: true, numericality: {:greater_than_or_equal_to => 0.0}
    validates :left, allow_blank: true, numericality: {:greater_than_or_equal_to => 0.0}
    validates :font, :inclusion => {:in => self.all_fonts_check}
    validates :fontSize, allow_blank: true, numericality: {:greater_than_or_equal_to => 0.0}
    validates :opacity, allow_blank: true, numericality: {:greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 1.0}
    validates :borderRadius, allow_blank: true, numericality: {:greater_than_or_equal_to => 0.0}
    validates :borderSize, allow_blank: true, numericality: {:greater_than_or_equal_to => 0.0}
    validates :boxShadow, :inclusion => {:in => self.all_shadows_check}
    validates :hover, :inclusion => {:in => self.all_hovers_check}
    
    
    def self.get_static_nonstatic_group_csses (portfolio_id)
        visible_css_static = []
        visible_css_not_static = []
        tempCsses = GroupCss.where(:portfolio_id => portfolio_id, :visible => true)
        tempCsses.each do |css|
            if css.position == "static"
                visible_css_static << css 
            else
                visible_css_not_static << css
            end
        end
        return visible_css_static, visible_css_not_static
    end
    
    def init
       if self.visible == nil
          self.visible = false 
       end
       self.defaultStyle ||= ""
       self.position ||= "static"
       self.width ||= "40"
       self.height ||= "40"
       self.top ||= 0
       self.left ||= 0
       self.font ||= "Times New Roman"
       self.fontSize ||= 100
       self.color ||= "#000000"
       self.backgroundColor ||= "#ffffff"
       self.opacity ||= 1.0
       self.borderRadius ||= 2
       self.borderColor ||= "#000000"
       self.borderSize ||= 4
       self.boxShadow ||= ""
       self.hover ||= ""
       if self.background == nil
          self.background = false 
       end
    end
end
