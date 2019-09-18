class ProjectsController < ApplicationController
  before_action :authenticate_user

  def index
    sorter = params[:sort].present? ? params[:sort] : 'project_created_at'
    sort_asc_desc = sorter == 'project_created_at' ? 'desc' : 'asc'
    @projects = Project.paginate(page: params[:page], per_page: 2)
      .select('projects.title, projects.created_at as project_created_at, users.username, categories.name as category_name')
      .joins(:user, :category).order(sorter => sort_asc_desc)
  end

  def new
    @project = Project.new
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id

    if @project.save
      redirect_to '/projects'
    else
      render 'new'
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:title, :category_id)
  end
end
