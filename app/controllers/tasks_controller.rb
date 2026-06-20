class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.includes(:labels).order(created_at: :desc)

    if params[:label_id].present?
      @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] })
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
      flash.now[:alert] = t('activerecord.errors.models.task.attributes.title.blank')
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task), notice: t('flash.update')
    else
      flash.now[:alert] = t('activerecord.errors.models.task.attributes.title.blank')
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
    params.require(:task).permit(:title, :content, :deadline_on, :priority, :status, label_ids: [])
  end
end