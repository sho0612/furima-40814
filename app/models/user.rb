class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname,           presence: true
  validates :first_name,         presence: true
  validates :last_name,          presence: true
  validates :first_name_kana,    presence: true
  validates :last_name_kana,     presence: true
  validates :birth_date,         presence: true

  validate :password_complexity
  validate :first_name_full_width
  validate :last_name_full_width
  validate :first_name_kana_katakana
  validate :last_name_kana_katakana

  has_many :items, dependent: :nullify
  # has_many :orders, dependent: :nullify

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

  def first_name_kana_katakana
    if first_name_kana.present? && first_name_kana !~ /\A[ァ-ヶー]+\z/
      errors.add(:first_name_kana, 'must be full-width katakana characters')
    end
  end

  def last_name_kana_katakana
    if last_name_kana.present? && last_name_kana !~ /\A[ァ-ヶー]+\z/
      errors.add(:last_name_kana, 'must be full-width katakana characters')
    end
  end

end
