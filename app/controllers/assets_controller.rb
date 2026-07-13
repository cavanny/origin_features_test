class AssetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_asset, except: [:index, :new, :create]
  before_action :set_lists, only: [:new, :create, :edit, :update]

  def index
    @assets = Asset.includes(:category, :status, assignments: :employe).order(:name)

    respond_to do |format|
      format.html
      format.xlsx do
        render xlsx: "index",
               filename: "origin-inventory-#{Date.current.iso8601}.xlsx"
      end
    end
  end

  def show
    @employes = Employe.order(:employeName)
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(asset_params)
    if @asset.save
      redirect_to @asset
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @asset.update(asset_params)
      redirect_to @asset
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @asset.destroy
    redirect_to root_path
  end

  private

  def asset_params
    params.require(:asset).permit(:name, :serial, :purchaseCost, :category_id, :status_id)
  end

  def set_lists
    @categories = Category.alphabetical
    @statuses   = Status.alphabetical
  end

  def set_asset
    @asset = Asset.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
