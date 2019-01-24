class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^0\d+$/i
      record.errors[attribute] << (options[:message] || I18n.t(:not_phone, scope: [:activemodel, :errors, :messages]))
    end
  end
end
