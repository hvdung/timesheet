class UniquenessValidator < ActiveRecord::Validations::UniquenessValidator
  def initialize(klass)
    super
    @klass = options[:model] if options[:model]
  end

  # rubocop:disable Style/GuardClause
  def validate_each(record, attribute, value)
    if !options[:model] && !record.class.ancestors.include?(ActiveRecord::Base)
      raise ArgumentError, "Unknown validator: 'UniquenessValidator'"
    elsif !options[:model]
      super
    else
      record_org = record
      attribute_org = attribute
      attribute = options[:attribute].to_sym if options[:attribute]
      record = if record_org.persisted?
                 record_org.record
               else
                 options[:model].new
               end

      record.assign_attributes(attribute => value)
      super
      if record.errors[attribute].any?
        record_org.errors.add(attribute_org, :taken,
                              options.except(:case_sensitive, :scope).merge(value: value))
      end
    end
  end
  # rubocop:enable Style/GuardClause
end
