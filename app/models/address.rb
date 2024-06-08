class Address < ApplicationRecord
  belongs_to :order

  with_options presence: true do
   validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
   validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
   validates :municipalities
   validates :street
   # 以下のバリデーションは追記の必要がある
   validates :phone_number
  end
end