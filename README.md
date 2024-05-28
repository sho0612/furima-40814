# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


# テーブル設計

## users テーブル

| Column             | Type    | Options                    |
| ------------------ | ------  | -------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| first_name         | string  | null: false               |
| last_name          | string  | null: false               |
| first_name_reading | string  | null: false               |
| last_name_reading  | string  | null: false               |
| birth_day          | date    | null: false               |


### Association

- has_many :items
- has_many :orders

## items テーブル

| Column          | Type       | Options                        |
| --------------  | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| description     | text       | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |
| category_id     | integer    | null: false                    |
| condition_id    | integer    | null: false                    |
| shipping_fee_id | integer    | null: false                    |
| prefecture_id   | integer    | null: false                    |
| shipping_day_id | integer    | null: false                    |

### Association

- belongs_to :user
- has_one :order

## addresses テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | -----------------------------  |
| order           | references | null: false, foreign_key: true |
| post_code       | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
| municipalities  | string     | null: false                    |
| street          | string     | null: false                    |
| building        | string     |                                |
| phone_number    | string     | null: false                    |

### Association

- belongs_to :order

## orders テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :address

