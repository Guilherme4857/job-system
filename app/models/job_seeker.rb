class JobSeeker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_picture

  validates :social_name, :cpf, :phone, :cv, presence: true
  validates :cpf, :phone, uniqueness: true

  def job_seeker_attributes(index)
    attributes = [JobSeeker.human_attribute_name('email'), 
                  JobSeeker.human_attribute_name('profile_picture'),
                  JobSeeker.human_attribute_name('social_name'),
                  JobSeeker.human_attribute_name('cpf'), 
                  JobSeeker.human_attribute_name('phone'),
                  JobSeeker.human_attribute_name('cv')]

    attributes[index]
  end
end