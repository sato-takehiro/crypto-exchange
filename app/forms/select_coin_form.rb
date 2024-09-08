class SelectCoinForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :cryptocurrency_id, :integer
  attribute :icon, :string
  attribute :code, :string
  attribute :name, :string
  attribute :asking_purchase_price, :float

  validates :cryptocurrency_id, presence: true
  validates :asking_purchase_price, presence: true, length: { minimum: 1 }
end
