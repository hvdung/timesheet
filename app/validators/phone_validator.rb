class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless /^0\d+$/i.match?(value)
      record.errors[attribute] << (options[:message] || I18n.t(:not_phone, scope: [:activemodel, :errors, :messages]))
    end
  end
end
