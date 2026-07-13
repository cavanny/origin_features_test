class Asset < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :status, optional: true

  has_many :assignments, class_name: "AssetAssignment", dependent: :destroy
  has_many :employes, through: :assignments

  validates :name, presence: true

  def current_assignment
    assignments.active.first
  end

  def current_holder
    current_assignment&.employe
  end

  def checked_out?
    current_assignment.present?
  end

  def history
    assignments.most_recent_first
  end

  def check_out(employe, at: Time.current, notes: nil)
    assignments.create(employe: employe, checked_out_at: at, notes: notes)
  end

  def check_in!(at: Time.current)
    current_assignment&.check_in!(at: at)
  end
end
