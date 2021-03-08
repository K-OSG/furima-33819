# テーブル設計

## users テーブル

| Column         | Type   | Options     |
| -------------- | ------ | ----------- |
| nickname       | string | null: false |
| email          | string | null: false |
| password       | string | null: false |
| fristname      | string | null: false |
| lastname       | string | null: false |
| fristname_kana | string | null: false |
| lastname_kane  | string | null: false |
| birth_date     | data   |             |

### Association

- has_many :items
- has_one :consumers

## items テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false                    |
| description | text       | null: false                    |
| categories  | string     | null: false                    |
| satatus     | string     | null: false                    |
| fee         | string     | null: false                    |
| perfecture  | string     | null: false                    |
| day         | string     | null: false                    |
| price       | string     | null: false                    |
| user_id     | references | null: false                    |

### Association

- belongs_to :user
- has_one :consumers

## consumers テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postcode     | string     | null: false                    |
| state        | string     | null: false                    |
| city         | string     | null: false                    |
| address      | string     | null: false                    |
| bulding      | string     |                                |
| phone_number | string     | null: false                    |
| item_id      | references | null: false, foreign_key: true |
| user_id      | references | null: false, foreign_key: true |

### Association

- has_one :user
- has_one :item
