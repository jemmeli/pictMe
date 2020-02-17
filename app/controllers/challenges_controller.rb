class ChallengesController < ApplicationController
  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.new(challenge_params)
    if @challenge.save
      redirect_to challenges_path, notice: "Challenge créé !"
    else
      render :new
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
  end

  def index
    @challenges = Challenge.all
    @new_results = Result.where(processed: false).where.not(runner_id: nil).count
  end

  def edit
    @challenge = Challenge.find(params[:id])
  end

  def update
    @challenge = Challenge.find(params[:id])
    if @challenge.update(challenge_params)
      redirect_to challenges_path, notice: "Challenge mis à jour !"
    else
      render :new
    end
  end

  def generate_widget
    @challenge = Challenge.find(params[:id])
    GenerateChallengeWidgetJob.perform_later(@challenge.id)
    redirect_to challenges_path, notice: "Le widget est en cours de génération."
  end

  def generate_global_widget
    GenerateGlobalChallengeWidgetJob.perform_later
    redirect_to challenges_path, notice: "Le widget est en cours de génération."
  end

  def update_scores
    UpdateScoresJob.perform_later
    redirect_to challenges_path, notice: "La mise à jour est en cours..."
  end

  private
  def challenge_params
    params.require(:challenge).permit(
        :id,
        :name,
        :widget
    )
  end
end
