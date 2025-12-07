class RegistrosController < ApplicationController
  before_action :set_registro, only: [:show, :update, :destroy]
  include Rails.application.routes.url_helpers

  def index
    registros = Registro.where(user_id: params[:user_id])

    render json: registros.map { |r|
      r.as_json.merge({
        photo_url: r.photo.attached? ? url_for(r.photo) : nil
      })
    }
  end


  def show
    render json: @registro
  end

  def create
    registro = Registro.new(
      title: params[:title],
      description: params[:description],
      photo: params[:photos].present? ? params[:photos][0] : nil,
      user_id: params[:user_id]
    )

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
    params.permit(:title, :description, photos: []) # permite array de photos
  end

end
