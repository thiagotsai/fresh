class RolesController < ApplicationController
  before_action :set_role, only: [:edit, :update, :destroy]

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to role_path(@role)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @role.update(role_params)
      redirect_to role_path(@role)
    else
      render :edit
    end
  end

  def destroy
    @role.destroy
    flash[:success] = "Role deleted"
    redirect_to roles_path
  end


  private

  def role_params
    params.require(:role).permit(:name, :description)
  end

  def set_role
    @role = Role.find(params[:id])
  end
end
