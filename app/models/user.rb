class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   # Receptionists register patients
  has_many :registered_patients, foreign_key: "registered_by_id", class_name: "Patient"
  
  # Doctors are assigned to patients
  has_many :assigned_patients, foreign_key: "doctor_id", class_name: "Patient"

  validates :first_name, :last_name, :role, presence: true
  validates :role, inclusion: { in: %w[receptionist doctor] }
end
