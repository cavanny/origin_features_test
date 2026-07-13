class Employe < ApplicationRecord
  has_many :assignments, class_name: "AssetAssignment", dependent: :restrict_with_error
  has_many :assets, through: :assignments

  validates :employeName, presence: true

  def current_assets
    assets.merge(AssetAssignment.active)
  end
end
