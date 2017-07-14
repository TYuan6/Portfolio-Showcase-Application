class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :secure_validatable#, :confirmable
         
         #Got rid of :confirmable
         
  has_many :portfolios, :dependent => :delete_all
  has_many :groups, :dependent => :delete_all
  has_many :projs, :dependent => :delete_all
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, format: { with: /\A\d{5}\z/, allow_blank: false, message: "must be 5 digits" }
  validates :phone, format: { with: /\A\d{10}\z/, allow_blank: false, message: "must be 10 digits" }

  has_many :pictures
  
  #searchable do
  #  text :first_name
  #  text :last_name
  #  text :email
  #end
    
    
end
