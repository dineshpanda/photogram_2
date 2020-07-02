class FriendRequestsController < ApplicationController
  before_action :current_user_must_be_friend_request_sender, only: %i[edit update destroy]

  before_action :set_friend_request, only: %i[show edit update destroy]

  # GET /friend_requests
  def index
    @q = current_user.received_friend_requests.ransack(params[:q])
    @friend_requests = @q.result(distinct: true).includes(:sender, :recipient).page(params[:page]).per(10)
  end

  # GET /friend_requests/1
  def show; end

  # GET /friend_requests/new
  def new
    @friend_request = FriendRequest.new
  end

  # GET /friend_requests/1/edit
  def edit; end

  # POST /friend_requests
  def create
    @friend_request = FriendRequest.new(friend_request_params)

    if @friend_request.save
      message = "FriendRequest was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @friend_request, notice: message
      end
    else
      render :new
    end
  end

  # PATCH/PUT /friend_requests/1
  def update
    if @friend_request.update(friend_request_params)
      redirect_to @friend_request, notice: "Friend request was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /friend_requests/1
  def destroy
    @friend_request.destroy
    redirect_to friend_requests_url, notice: "Friend request was successfully destroyed."
  end

  private

  def current_user_must_be_friend_request_sender
    set_friend_request
    unless current_user == @friend_request.sender
      redirect_back fallback_location: root_path, alert: "You are not authorized for that."
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def friend_request_params
    params.require(:friend_request).permit(:sender_id, :recipient_id, :status)
  end
end
