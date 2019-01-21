class UserForm
  include Virtus.model
  include ActiveModel::Model

  attr_accessor :user
  attr_accessor :record

  attribute :first_name, String
  attribute :last_name, String
  attribute :birthday, Date
  attribute :gender, Integer
  attribute :phone, String
  attribute :email, String

  validates :first_name, :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: { case_sensitive: false, model: User }
  validates :gender, presence: true
  delegate :id, :persisted?, to: :user

  def initialize(params = nil, init_user = nil)

    @user = init_user || ::User.new
    @record = @user
    attributes.each do |key, _value|
      instance_variable_set("@#{key}".to_sym, @record.send(key))
    end

   super(params) if params
  end

  def self.name
    "user"
  end

  def save
    valid? && persist!
  end

  private

  def persist!
    @user.update! first_name: first_name, last_name: last_name, birthday: birthday, gender: gender,
                         phone: phone, email: email
    true
  end
end
