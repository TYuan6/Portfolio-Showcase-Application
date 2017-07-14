class Group < ActiveRecord::Base
    #validates :name, :presence => true, uniqueness: true, scope: :user
    validates_uniqueness_of :name, scope: :user_id
    validates_presence_of :name
    belongs_to :user
    has_many :projs, :dependent => :destroy
    has_many :group_csses, :dependent => :delete_all
    has_many :portfolios, :through => :group_csses
    has_attached_file :group_icon, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :group_icon, :content_type => /\Aimage\/.*\Z/
end
