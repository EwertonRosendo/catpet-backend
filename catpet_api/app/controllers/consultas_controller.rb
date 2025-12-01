class ConsultasController < ApplicationController
  before_action :set_consulta, only: [:show, :update, :destroy]

  def index
    render json: Consulta.where(user_id: params[:user_id])
  end

  def show
    render json: @consulta
  end

  def create
    consulta = Consulta.new(consulta_params.merge(user_id: params[:user_id]))

    if consulta.save
      render json: consulta, status: :created
    else
      render json: consulta.errors, status: :unprocessable_entity
    end
  end

  def update
    if @consulta.update(consulta_params)
      render json: @consulta
    else
      render json: @consulta.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @consulta.destroy
    head :no_content
  end

  private

  def set_consulta
    @consulta = Consulta.find(params[:id])
  end

  def consulta_params
    params.require(:consulta).permit(:title, :description)
  end
end
