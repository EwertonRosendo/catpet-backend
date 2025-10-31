class PetsController < ApplicationController
  before_action :set_user

  # GET /users/:user_id/pets
  def index
    pets = @user.pets
    render json: pets, status: :ok
  end

  # POST /users/:user_id/pets
  def create
    pet = @user.pets.new(pet_params)

    if pet.save
      render json: pet, status: :created
    else
      render json: { errors: pet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :breed, :age)
  end
end
