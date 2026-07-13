class AssetAssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_asset

  def create
    employe = Employe.find_by(id: params[:employe_id])
    @assignment = @asset.check_out(employe, notes: params[:notes].presence)

    respond_with_assignment_section(
      notice: ("Checked out to #{employe.employeName}." if @assignment.persisted?)
    )
  end

  def update
    assignment = @asset.assignments.find(params[:id])
    assignment.check_in!

    respond_with_assignment_section(notice: "Checked in from #{assignment.employe.employeName}.")
  end

  private

  def set_asset
    @asset = Asset.find(params[:asset_id])
  end

  def respond_with_assignment_section(notice: nil)
    @asset.reload
    @employes = Employe.order(:employeName)

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = notice if notice }
      format.html { redirect_to @asset, notice: notice }
    end
  end
end
