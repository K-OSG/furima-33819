FactoryBot.define do
  factory :consumer_address do
    postcode {"123-4567"}
    perfecture_id {3}
    city {"あああ"}
    address {"いいい12-34"}
    bulding {"さしすせそ103"}
    phone_number { 12300004567 }
    token {"tok_abcdefghijk00000000000000000"}
    item_id {6}
    user_id {6}
    consumer_id {user_id}
  end
end
