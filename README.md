# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | --------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| fristname          | string | null: false               |
| lastname           | string | null: false               |
| fristname_kana     | string | null: false               |
| lastname_kane      | string | null: false               |
| birth_date         | data   | null: false               |

### Association

- has_many :items
- has_one :consumers

## items テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| name        | string     | null: false                    |
| description | text       | null: false                    |
| categories  | integer    | null: false                    |
| satatus     | integer    | null: false                    |
| fee         | integer    | null: false                    |
| perfecture  | integer    | null: false                    |
| day         | integer    | null: false                    |
| price       | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :consumers

## consumers テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| item         | references | null: false, foreign_key: true |
| user         | references | null: false, foreign_key: true |

### Association

- has_one :user
- has_one :item
- has_many :addresses

## addresses テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postcode     | string     | null: false                    |
| state        | string     | null: false                    |
| city         | string     | null: false                    |
| address      | string     | null: false                    |
| bulding      | string     |                                |
| phone_number | string     | null: false                    |

### Association

- belongs_to :consumer