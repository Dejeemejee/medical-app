class Patient < ApplicationRecord
  belongs_to :registered_by, class_name: "User" # Always a receptionist
  belongs_to :doctor, class_name: "User", optional: true # Can be assigned to a doctor

    validates :first_name, :last_name, :email, :phone, :date_of_birth, :medical_record_number, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :medical_record_number, uniqueness: true
    validates :phone, format: { with: /\A[\+]?[1-9][\d]{0,15}\z/,  message: "must be a valid international phone number" }

end
