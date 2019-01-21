class UserForm
  include Virtus.model
  include ActiveModel::Model

  attr_reader :password
  attr_reader :user
  attr_reader :record

  attribute :first_name, String
  attribute :last_name, String
  attribute :birthday
  attribute :gender, Integer
  attribute :phone, String
  attribute :email, String

  validates :first_name, :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: { case_sensitive: false, model: User }, rubydev_email: true
  validates :gender, presence: true
  validates :phone, phone: true, length: { minimum: 10, maximum: 11 }, allow_blank: true
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
 
  def formated_birthday
    if birthday.is_a? Date
      I18n.l(birthday, format: :date_default)
    else
      birthday
    end
  end

  private

  def datetype_birthday
    Date.strptime(formated_birthday.to_s, I18n.t("date.formats.date_default"))
  end

  def persist!
    @password = Devise.friendly_token.first(8)
    @user.update! first_name: first_name, last_name: last_name, birthday: datetype_birthday, gender: gender,
                  phone: phone, email: email, password: password
    true
  end
end
