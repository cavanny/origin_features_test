class StatusesController < ApplicationController
  before_action :authenticate_user!

  def create
    @status = Status.new(status_params)

    if @status.save
      redirect_to settings_path, notice: "Status “#{@status.name}” added."
    else
      render_settings
    end
  end

  def destroy
    status = Status.find(params[:id])

    if status.destroy
      redirect_to settings_path, notice: "Status “#{status.name}” deleted."
    else
      count = helpers.pluralize(status.assets.count, "asset")
      redirect_to settings_path,
                  alert: "“#{status.name}” is used by #{count} and can't be deleted."
    end
  end

  private

  def status_params
    params.require(:status).permit(:name, :color)
  end

  def render_settings
    @categories = Category.alphabetical
    @statuses   = Status.alphabetical
    @category   = Category.new
    render "settings/index", status: :unprocessable_entity
  end
end
