class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :ensure_receptionist, only: [:new, :create, :edit, :update, :destroy]

  def index
    if current_user.role == 'receptionist'
      @patients = current_user.registered_patients.includes(:doctor)
    elsif current_user.role == 'doctor'
      @patients = Patient.all.order(created_at: :desc)
    end
  end

  def show
  end

  def new
    @patient = Patient.new
    @doctors = User.where(role: 'doctor')
  end

  def create
    @patient = Patient.new(patient_params)
    @patient.registered_by = current_user

    if @patient.save
      redirect_to @patient, notice: 'Patient registered successfully.'
    else
      @doctors = User.where(role: 'doctor')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @doctors = User.where(role: 'doctor')
  end

  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: 'Patient updated successfully.'
    else
      @doctors = User.where(role: 'doctor')
      render :edit
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_path, notice: 'Patient deleted successfully.'
  end

  private

  def set_patient
    if current_user.role == 'receptionist'
      @patient = current_user.registered_patients.find(params[:id])
    elsif current_user.role == 'doctor'
      @patient = Patient.find(params[:id])
    end
  end

  def patient_params
    params.require(:patient).permit(:first_name, :last_name, :email, :phone, 
                                   :date_of_birth, :address, :medical_record_number, :doctor_id)
  end

  def ensure_receptionist
    redirect_to root_path unless current_user.role == 'receptionist'
  end
end