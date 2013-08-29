class User < ActiveRecord::Base
  attr_accessible :email, :name, :phone, :role, :status
  validates_presence_of :email, :name, :phone, :role

  has_many :tasks

  scope :active, -> { where(status: 'active') }

  before_create :default_active

  def default_active
  	self.status = "active"
  end

end
