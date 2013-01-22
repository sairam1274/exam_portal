class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :department_id, :designation, :employee_id

  validates :name, :department_id,:designation,  :presence => true
  validates :employee_id, :presence => true, :uniqueness => true
 

  has_many :exams
  belongs_to :department

  before_save :get_ldap_email

  def get_ldap_email
    self.email = Devise::LdapAdapter.get_ldap_param(self.username,"mail")
  end

  
end
