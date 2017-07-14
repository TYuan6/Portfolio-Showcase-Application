class Picture < ActiveRecord::Base
    belongs_to :proj
    #belongs_to :user
    validates_presence_of :project_img
    
    has_attached_file :project_img, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
    }
    
    validates_attachment_content_type :project_img, :content_type => /\Aimage\/.*\Z/
    
end
