class UsersController < ApplicationController
  def edit
  	@user = User.find(params[:id])
  end

  def index
  	@users = User.active
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(params[:user])
    if @user.save
      flash[:success] = "User was successfully created."
      redirect_to users_path
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(params[:user])
    if @user.changed? & @user.save
      flash[:success] = "User was successfully edited."
      redirect_to users_path
    else
      flash[:error] = "You must change at least one parameter"
      render 'edit'
    end
  end


  def delete_status
    user = User.find(params[:id])
    user.status = "inactive"
    respond_to do |format|
      if user.save
        format.json { render json: {status: "saved"} }
      else
        format.json render json: {status: "unsaved"}
      end
    end
  end

  def sistem_tasks
    @tasks = Task.all.sort_by { |x| [x.status == 'started' ? 1 : x.status == 'unstarted' ? 2 : 3, x.created_at]}
  end

  def reasign_task
    task = Task.find(params[:task_id])
    task.user_id = params[:task][:user]
    task.save
  end

end
