class JobSeeker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
#  validates :social_name, :cpf, :phone, :cv, presence: true
  validates :cpf, :phone, uniqueness: true

  has_one_attached :company_picture
end