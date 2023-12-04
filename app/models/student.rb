class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :email, presence: true, columbia_email: true
  #Student-course association
  has_many :enrollments
  has_many :courses, through: :enrollments

  #Group-student association
  has_many :group_members
  has_many :groups, through: :group_members

  #Group-request association
  has_many :group_requests
  has_many :requested_groups, through: :group_requests, source: :group

end
