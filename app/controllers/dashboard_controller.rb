class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.role == "receptionist"
      @recent_patients = current_user.registered_patients
      @total_registered = current_user.registered_patients.count
    else
      @patients = Patient.all.order(created_at: :desc)
      @patients_per_day = Patient
        .group_by_day(:created_at, last: 7)
        .count
        .transform_keys { |date| date.strftime("%a") }
      @assigned_patients = current_user.assigned_patients
      @total_assigned = current_user.assigned_patients.count

      @registered_by_day = Patient.all
                            .group_by_day(:created_at, last: 7).count

      @assigned_by_day = Patient.where(doctor_id: current_user.id)
                          .group_by_day(:created_at, last: 7).count
    end
  end


end
