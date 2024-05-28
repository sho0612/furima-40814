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

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| name               | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| nickname           | string | null: false |
| name_reading       | string | null: false |

### Association

- has_many :items
- has_many :address
- has_many :orders

## items テーブル

| Column        | Type       | Options                        |
| ------------  | ---------- | ------------------------------ |
| name          | string     | null: false                    |
| description   | text       | null: false                    |
| price         | integer    | null: false                    |
| user          | references | null: false, foreign_key: true |
| category      | integer    | null: false                    |
| condition     | integer    | null: false                    |
| shipping_fee  | integer    | null: false                    |
| prefecture_id | integer    | null: false                    |
| shipping_days | integer    | null: false                    |

### Association

- belongs_to :users
- has_one :orders

## addresses テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| address   | string     | null: false                    |

### Association

- belongs_to :user
- belongs_to :orders

## orders テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :items
- has_one    :addresses

