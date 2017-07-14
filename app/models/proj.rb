class Proj < ActiveRecord::Base
    belongs_to :user
    belongs_to :group
    belongs_to :category
    has_many :pictures, :dependent => :delete_all
    has_many :videos, :dependent => :delete_all
    has_many :proj_csses, :dependent => :delete_all
    has_many :portfolios, :through => :proj_csses
    
    has_attached_file :proj_icon, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :proj_icon, :content_type => /\Aimage\/.*\Z/
end
