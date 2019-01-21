class RubydevEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless /\A([^@\s]+)#{ENV["EMAIL_SUFFIX"]}$/i.match?(value)
      record.errors[attribute] << (options[:message] || I18n.t(:not_email, scope: [:activemodel, :errors, :messages], suffix: ENV["EMAIL_SUFFIX"]))
    end
  end
end
