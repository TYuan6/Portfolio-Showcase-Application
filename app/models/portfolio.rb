class Portfolio < ActiveRecord::Base
    #include PgSearch
    #pg_search_scope :search, against: [:name, :description], using: {tsearch: {dictionary: "english"}}
    
    before_create :add_token
    
    belongs_to :users
    has_many :proj_csses, :dependent => :delete_all
    has_many :projs, :through => :proj_csses
    has_many :group_csses, :dependent => :delete_all
    has_many :groups, :through => :group_csses
    accepts_nested_attributes_for :group_csses
    
    
  
    
    def self.copyCssInfo(copyFrom, copyTo)
      ProjCss.where(:portfolio_id => copyFrom).each do |proj_css|
        css_to_copy_to = ProjCss.where(:portfolio_id => copyTo, :proj_id => proj_css.proj_id).take
        css_to_copy_to.defaultStyle = proj_css.defaultStyle
        css_to_copy_to.position = proj_css.position
        css_to_copy_to.width = proj_css.width
        css_to_copy_to.height = proj_css.height
        css_to_copy_to.top = proj_css.top
        css_to_copy_to.left = proj_css.left
        css_to_copy_to.font = proj_css.font
        css_to_copy_to.fontSize = proj_css.fontSize
        css_to_copy_to.color = proj_css.color
        css_to_copy_to.backgroundColor = proj_css.backgroundColor
        css_to_copy_to.opacity = proj_css.opacity
        css_to_copy_to.borderRadius = proj_css.borderRadius
        css_to_copy_to.borderColor = proj_css.borderColor
        css_to_copy_to.borderSize = proj_css.borderSize
        css_to_copy_to.boxShadow = proj_css.boxShadow
        css_to_copy_to.hover = proj_css.hover
        css_to_copy_to.background = proj_css.background
        css_to_copy_to.save
      end
      
      GroupCss.where(:portfolio_id => copyFrom).each do |group_css|
        css_to_copy_to = GroupCss.where(:portfolio_id => copyTo, :group_id => group_css.group_id).take
        css_to_copy_to.defaultStyle = group_css.defaultStyle
        css_to_copy_to.position = group_css.position
        css_to_copy_to.width = group_css.width
        css_to_copy_to.height = group_css.height
        css_to_copy_to.top = group_css.top
        css_to_copy_to.left = group_css.left
        css_to_copy_to.font = group_css.font
        css_to_copy_to.fontSize = group_css.fontSize
        css_to_copy_to.color = group_css.color
        css_to_copy_to.backgroundColor = group_css.backgroundColor
        css_to_copy_to.opacity = group_css.opacity
        css_to_copy_to.borderRadius = group_css.borderRadius
        css_to_copy_to.borderColor = group_css.borderColor
        css_to_copy_to.borderSize = group_css.borderSize
        css_to_copy_to.boxShadow = group_css.boxShadow
        css_to_copy_to.hover = group_css.hover
        css_to_copy_to.background = group_css.background
        css_to_copy_to.save
      end
    end
    

    private
    def add_token
      begin
        self.token = SecureRandom.hex[0,10].upcase
      end while self.class.exists?(token: token)
    end

    def self.all_templates
       temp = ["Hawks", "Colorful", "Red", "Blue", "Yellow"] 
    end

    def self.all_colors
       temp = [["Red"], ["Blue"], ["Yellow"]] 
    end

end
