class GroupForm
  include Virtus.model
  include ActiveModel::Model

  attribute :name, String
  attribute :user_ids, Array[Integer]

  attr_reader :group
  attr_reader :record

  validates :name, presence: true, uniqueness: { case_sensitive: false, model: Group }
  delegate :id, :persisted?, to: :group

  def initialize(params = nil, init_group = nil)
    @group = init_group || ::Group.new
    @record = @group
    attributes.each do |key, _value|
      instance_variable_set("@#{key}".to_sym, @record.send(key))
    end

    super(params) if params
  end

  def self.name
    "group"
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  def users
    @users = User.pluck(:email, :id)
  end

  private

  def persist!
    @group.update! name: name, user_ids: user_ids
  end
end
