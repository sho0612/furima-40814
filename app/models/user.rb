class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname,           presence: true
  validates :email,              presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :first_name,         presence: true
  validates :last_name,          presence: true
  validates :first_name_reading, presence: true
  validates :last_name_reading,  presence: true
  validates :birth_day,          presence: true

  validate :password_complexity
  validate :first_name_full_width
  validate :last_name_full_width
  validate :first_name_reading_katakana
  validate :last_name_reading_katakana

  has_many :items, dependent: :nullify
  has_many :orders, dependent: :nullify

  private

  def password_complexity
    return if password.blank? || password =~ /(?=.*[a-zA-Z])(?=.*[0-9])/

    errors.add :password, 'must include both letters and numbers'
  end


  def first_name_full_width
    if first_name.present? && first_name !~ /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
      errors.add(:first_name, 'must be full-width characters (kanji, hiragana, katakana)')
    end
  end

  def last_name_full_width
    if last_name.present? && last_name !~ /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
      errors.add(:last_name, 'must be full-width characters (kanji, hiragana, katakana)')
    end
  end

  def first_name_reading_katakana
    if first_name_reading.present? && first_name_reading !~ /\A[ァ-ヶー]+\z/
      errors.add(:first_name_reading, 'must be full-width katakana characters')
    end
  end

  def last_name_reading_katakana
    if last_name_reading.present? && last_name_reading !~ /\A[ァ-ヶー]+\z/
      errors.add(:last_name_reading, 'must be full-width katakana characters')
    end
  end

end
