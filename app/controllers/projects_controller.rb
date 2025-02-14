class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.includes(:comments, :user).find(params[:id])
    @history = (@project.versions + @project.comments.flat_map(&:versions)).sort_by(&:created_at).reverse
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to @project, notice: 'Project created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project status was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to @project
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :status)
  end
end
