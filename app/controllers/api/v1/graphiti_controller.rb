class Api::V1::GraphitiController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :doorkeeper_authorize!

  include Graphiti::Rails::Responders

end
