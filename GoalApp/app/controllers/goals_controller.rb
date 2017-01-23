class GoalsController < ApplicationController
  before_action :require_logged_in
  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def index

    @goals = Goal.all
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update_attributes(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])

    if @goal.destroy
      redirect_to goals_url
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to goal_url(@goal)
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :details, :private)
  end
end
