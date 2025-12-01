class RegistrosController < ApplicationController
  before_action :set_registro, only: [:show, :update, :destroy]

  def index
    render json: Registro.where(user_id: params[:user_id])
  end

  def show
    render json: @registro
  end

  def create
    registro = Registro.new(registro_params.merge(user_id: params[:user_id]))

    if registro.save
      render json: registro, status: :created
    else
      render json: registro.errors, status: :unprocessable_entity
    end
  end

  def update
    if @registro.update(registro_params)
      render json: @registro
    else
      render json: @registro.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @registro.destroy
    head :no_content
  end

  private

  def set_registro
    @registro = Registro.find(params[:id])
  end

  def registro_params
    params.require(:registro).permit(:title, :description)
  end
end
