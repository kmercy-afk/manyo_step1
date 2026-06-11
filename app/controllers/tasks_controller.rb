class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all

    if params[:sort_deadline_on]
      @tasks = @tasks.deadline_sort
    elsif params[:sort_priority]
      @tasks = @tasks.priority_sort
    else
      @tasks = @tasks.latest
    end

    if params[:title].present?
      @tasks = @tasks.search_title(params[:title])
    end

    if params[:status].present?
      @tasks = @tasks.search_status(params[:status])
    end

    @tasks = @tasks.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: t('flash.create')
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: t('flash.update')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('flash.destroy')
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(
      :title,
      :content,
      :deadline_on,
      :priority,
      :status
    )
  end
end