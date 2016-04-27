class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :group
  
  validates :name, presence: true
  validates :surname, presence: true
  validates :patronymic, presence: true
  validates :group_id, presence: true
  
  def fio
    "#{surname} #{name} #{patronymic}"
  end
end
