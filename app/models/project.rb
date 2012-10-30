class Project < ActiveRecord::Base
  has_many :videos, :as => :recordable
  accepts_nested_attributes_for :videos

  attr_accessible :farmer, :description, :target, :end_date, :ending, :priority, :current, :completed
  after_initialize :init

  validates :farmer, :presence => true, :uniqueness => true
  validates :description, :presence => true, :length => { :minimum => 50 }
  validates :target, :presence => true, :numericality => true
  validate :end_date_or_no_ending
  validates :current, :numericality => true

  def end_date_or_no_ending
    # There must be an end date or it must go on indefinitely
    unless end_date or not ending
      errors.add(:end_date, "You must choose an end date or let the campaign go on forever")
    end
  end

  def init
    self.current ||= 0
    if not self.end_date
      self.ending = false
    end
    self.priority ||= 1
    self.target ||= 0
    self.completed = (self.target <= self.current unless self.completed or self.target == 0)
  end
end
