class DoctorsController < ApplicationController
  before_action :set_doctor, only: [:show, :update, :destroy]

  # GET /doctors
  def index
    doctors = Doctor.all
    render json: doctors
  end

  # GET /doctors/:id
  def show
    render json: @doctor
  end

  # POST /doctors
  def create
    doctor = Doctor.new(doctor_params)

    if doctor.save
      render json: doctor, status: :created
    else
      render json: { errors: doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /doctors/:id
  def update
    if @doctor.update(doctor_params)
      render json: @doctor
    else
      render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /doctors/:id
  def destroy
    @doctor.destroy
    head :no_content
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(
      :name,
      :specialty,
      :rating,
      :phone,
      :email,
      :price
    )
  end
end
