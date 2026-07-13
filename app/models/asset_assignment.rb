class AssetAssignment < ApplicationRecord
  belongs_to :asset
  belongs_to :employe

  scope :active, -> { where(checked_in_at: nil) }
  scope :past, -> { where.not(checked_in_at: nil) }
  scope :most_recent_first, -> { order(checked_out_at: :desc) }

  validates :checked_out_at, presence: true
  validate :checked_in_after_checked_out
  validate :asset_not_already_checked_out, on: :create

  def active?
    checked_in_at.nil?
  end

  def check_in!(at: Time.current)
    update!(checked_in_at: at)
  end

  def duration_in_days
    ((checked_in_at || Time.current) - checked_out_at) / 1.day
  end

  private

  def checked_in_after_checked_out
    return if checked_in_at.blank? || checked_out_at.blank?
    return if checked_in_at >= checked_out_at

    errors.add(:checked_in_at, "can't be before the asset was checked out")
  end

  def asset_not_already_checked_out
    return if asset.blank?
    return unless asset.assignments.active.exists?

    errors.add(:base, "#{asset.name} is already checked out")
  end
end
