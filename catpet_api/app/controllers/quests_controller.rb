class QuestsController < ApplicationController
  # Caso você queira proteger com login futuramente
  # before_action :authorize_request, except: [:index, :show]

  def index
    quests = Quest.all
    render json: quests, status: :ok
  end

  def show
    quest = Quest.find(params[:id])
    render json: quest, status: :ok
  end

  def create
    quest = Quest.new(quest_params)

    if quest.save
      render json: quest, status: :created
    else
      render json: { errors: quest.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    quest = Quest.find(params[:id])

    if quest.update(quest_params)
      render json: quest, status: :ok
    else
      render json: { errors: quest.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    quest = Quest.find(params[:id])
    quest.destroy
    render json: { message: "Quest deleted successfully" }, status: :ok
  end

  private

  def quest_params
    params.require(:quest).permit(:name, :description, :times, :xp)
  end
end
