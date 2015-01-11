class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 	before_validation :strip_whitespace 
  validates :name, presence: true
  validates_uniqueness_of :name
  has_many :ideas


  def strip_whitespace
	  self.name = self.name.gsub(/\s+/, "")
	  self.email = self.email.gsub(/\s+/, "")
	end
end
