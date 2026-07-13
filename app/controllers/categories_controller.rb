class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to settings_path, notice: "Category “#{@category.name}” added."
    else
      render_settings
    end
  end

  def destroy
    category = Category.find(params[:id])

    if category.destroy
      redirect_to settings_path, notice: "Category “#{category.name}” deleted."
    else
      count = helpers.pluralize(category.assets.count, "asset")
      redirect_to settings_path,
                  alert: "“#{category.name}” is used by #{count} and can't be deleted."
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def render_settings
    @categories = Category.alphabetical
    @statuses   = Status.alphabetical
    @status     = Status.new
    render "settings/index", status: :unprocessable_entity
  end
end
