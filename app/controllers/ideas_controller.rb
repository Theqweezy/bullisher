class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  respond_to :html

  def index
    @ideas = Idea.all
    
  end

  def show
  end

  def new
    @idea = current_user.ideas.build
    respond_with(@idea)
  end

  def edit
  end

  def create
    @idea = current_user.ideas.build(idea_params)
    if @idea.save
      redirect_to @idea, notice: "Idea was successfully created."
    else
      render :action => 'new'
    end
  end

  def update
    if @idea.update(idea_params)
      redirect_to @idea, notice: "Your idea has been updated"   
    else
      render action: 'edit'
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_url
  end

  private
    def set_idea
      @idea = Idea.find(params[:id])
    end

    def correct_user
      @idea = current_user.ideas.find_by(id: params[:id])
      redirect_to ideas_path, notice: "You can't edit this" if @idea.nil?
    end

    def idea_params
      params.require(:idea).permit(:description)
    end
end
