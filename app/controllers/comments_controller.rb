class CommentsController < ApplicationController
  before_action :current_user_must_be_comment_commenter, only: %i[edit_form update_row destroy_row]

  def current_user_must_be_comment_commenter
    comment = Comment.find(params["id_to_display"] || params["prefill_with_id"] || params["id_to_modify"] || params["id_to_remove"])

    unless current_user == comment.commenter
      redirect_to :back, alert: "You are not authorized for that."
    end
  end

  before_action :set_comment, only: %i[show edit update destroy]

  # GET /comments
  def index
    @q = Comment.ransack(params[:q])
    @comments = @q.result(distinct: true).includes(:commenter, :photo).page(params[:page]).per(10)
  end

  # GET /comments/1
  def show; end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      message = "Comment was successfully created."
      if Rails.application.routes.recognize_path(request.referer)[:controller] != Rails.application.routes.recognize_path(request.path)[:controller]
        redirect_back fallback_location: request.referer, notice: message
      else
        redirect_to @comment, notice: message
      end
    else
      render :new
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: "Comment was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to comments_url, notice: "Comment was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:body, :commenter_id, :photo_id)
  end
end
