class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
  end

  def create
    secret = Secret.new(content: secret_params['content'], user: current_user)
    flash["success"] = "Secret added!" if secret.save
    redirect_to current_user
  end

  def destroy
    secret = Secret.find(params[:id]).destroy
    redirect_to current_user
  end

  private
    def secret_params
      params.require(:secret).permit(:content)
    end
end
