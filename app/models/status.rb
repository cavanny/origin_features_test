class Status < ApplicationRecord
  COLORS = %w[green blue amber red gray].freeze

  has_many :assets, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :color, inclusion: { in: COLORS }

  scope :alphabetical, -> { order(:name) }

  def badge_class
    "status-badge--#{color}"
  end
end
