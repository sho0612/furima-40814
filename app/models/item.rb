class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee, class_name: 'ShippingFee'
  belongs_to :prefecture
  belongs_to :shipping_day, class_name: 'ShippingDay'

  belongs_to :user
  has_one_attached :image
  has_one :order

  def image_url
    image.attached? ? Rails.application.routes.url_helpers.url_for(image) : 'default_image_url.png'
  end

  def sold_out?
    false
  end

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'must be a number between ¥300 and ¥9,999,999' }
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_day_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :image, presence: true
end
