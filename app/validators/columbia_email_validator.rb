class ColumbiaEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[\w+\-.]+@columbia\.edu\z/i
      record.errors[attribute] << (options[:message] || 'must be a valid @columbia.edu email address')
    end
  end
end