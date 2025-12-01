class AlimentacoesController < ApplicationController
  before_action :set_alimentacao, only: [:show, :update, :destroy]

  def index
    render json: Alimentacao.where(user_id: params[:user_id])
  end

  def show
    render json: @alimentacao
  end

  def create
    alimentacao = Alimentacao.new(alimentacao_params.merge(user_id: params[:user_id]))

    if alimentacao.save
      render json: alimentacao, status: :created
    else
      render json: alimentacao.errors, status: :unprocessable_entity
    end
  end

  def update
    if @alimentacao.update(alimentacao_params)
      render json: @alimentacao
    else
      render json: @alimentacao.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @alimentacao.destroy
    head :no_content
  end

  private

  def set_alimentacao
    @alimentacao = Alimentacao.find(params[:id])
  end

  def alimentacao_params
    params.require(:body).permit(:title, :description, :body)
  end
end
