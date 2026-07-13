class SettingsController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.alphabetical
    @statuses   = Status.alphabetical
    @category   = Category.new
    @status     = Status.new
  end
end
