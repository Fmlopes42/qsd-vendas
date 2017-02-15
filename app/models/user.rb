class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true

  has_many :orders

  enum role: [:customer, :seller, :admin]

  before_create :set_default_role

  private

  def set_default_role
    self.role ||= :customer
  end
end
