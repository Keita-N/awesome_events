class Event < ActiveRecord::Base
	validates :name, length: { maximum: 50 }, presence: true
	validates :place, length: { maximum: 100 }, presence: true
	validates :content, length: { maximum: 2000 }, presence: true
	validates :start_time, presence: true
	validates :end_time, presence: true
	validate :start_time_should_be_before_end_time

	has_many :tickets, dependent: :destroy
	belongs_to :owner, class_name: 'User'

	def created_by?(user)
		return false unless user
		owner_id == user.id
	end

	private
	def start_time_should_be_before_end_time
		return unless start_time && end_time

		if start_time >= end_time
			errors.add(:start_time, 'は終了時刻よりも前に設定してください')
		end
	end

end
