class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #Student-course association
  has_many :enrollments
  has_many :courses, through: :enrollments

  #Group-student association
  has_many :group_members
  has_many :groups, through: :group_members

end
