class UserTaskCompletedsController < ApplicationController
  #before_action :authorize_request  # se você estiver usando autenticação JWT

  # GET /user_task_completeds
    def index
        completeds = UserTaskCompleted
                        .includes(:quest)
                        .where(user_id: params[:user_id])

        render json: completeds.map { |c|
            {
            id: c.quest.id,
            name: c.quest.name,
            description: c.quest.description,
            times: c.quest.times,
            xp: c.quest.xp,
            created_at: c.created_at
            }
        }, status: :ok
    end



  # POST /user_task_completeds
  def create
    completed = UserTaskCompleted.new(
      user_id: params[:user_id],
      quest_id: params[:quest_id]
    )

    if completed.save
      render json: completed, status: :created
    else
      render json: { errors: completed.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
