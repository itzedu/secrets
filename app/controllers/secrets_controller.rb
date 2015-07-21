class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  
  def index
    @secrets = Secret.all
  end

  def create
    secret = Secret.new(content: secret_params['content'], user: current_user)
    flash["success"] = "Secret added!" if secret.save
    redirect_to current_user
  end

  def destroy
    secret = Secret.find(params[:id])
    secret.destroy if secret.user == current_user
    redirect_to current_user
  end

  private
    def secret_params
      params.require(:secret).permit(:content)
    end
end
