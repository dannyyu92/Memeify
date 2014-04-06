class MemesController < ApplicationController
  before_action :set_meme, only: [:show, :edit, :update, :destroy]

  def index
    @memes = Meme.all
  end

  def show
    @comment = Comment.new
    if !Comment.where(meme_id: @meme.id).order("hearts DESC").first.nil?
      @top_comment = Comment.where(meme_id: @meme.id).order("hearts DESC").first.body
    end
    if params[:add_heart].present?
      @comment = Comment.where(id: params[:comment_id]).first
      @comment.hearts += 1
      @comment.save
      redirect_to meme_path(@meme.id)
    end
  end

    def new
    @meme = Meme.new
    if user_signed_in?
      @meme.user_id = current_user.id
    end
  end

    def edit
  end

  def create
    @meme = Meme.new(meme_params)
    if user_signed_in?
      @meme.user_id = current_user.id
    end

    respond_to do |format|
      if @meme.save
        format.html { redirect_to @meme, notice: 'Meme was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meme }
      else
        format.html { render action: 'new' }
        format.json { render json: @meme.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @meme.update(meme_params)
        format.html { redirect_to @meme, notice: 'Meme was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @meme.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @meme.destroy
    respond_to do |format|
      format.html { redirect_to memes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meme
      @meme = Meme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meme_params
      params.require(:meme).permit(:avatar)
    end
end
