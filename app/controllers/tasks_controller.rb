class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
  @tasks = current_user.tasks

  @tasks = @tasks.search_title(params[:title]) if params[:title].present?
  @tasks = @tasks.search_status(params[:status]) if params[:status].present?

  @tasks =
    case params[:sort]
    when 'deadline'
      @tasks.deadline_sort
    when 'priority'
      @tasks.priority_sort
    else
      @tasks.latest
    end

  @tasks = @tasks.page(params[:page]).per(10)
end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to tasks_path,
                  notice: t('flash.create')
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task),
                  notice: t('flash.update')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy

    redirect_to tasks_path,
                notice: t('flash.destroy')
  end

  private

  def set_task
    @task = current_user.tasks.find_by(id: params[:id])

    return if @task.present?

    redirect_to tasks_path,
                alert: 'You do not have permission to access'
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