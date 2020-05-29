class Api::V1::GraphitiController < ApplicationController
  skip_before_action :authenticate_user!
  before_action -> { doorkeeper_authorize! :public }
  before_action :log_access_token

  include Graphiti::Rails::Responders

  private

  def log_access_token
    Rails.logger.info "\n=================== Access Token ======================\n"
    Rails.logger.info request.headers["authorization"]
    Rails.logger.info "\n=================== Access Token ======================\n"
  end
end
