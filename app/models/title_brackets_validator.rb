class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    validate_brackets(record, "(", ")")
    validate_brackets(record, "{", "}")
    validate_brackets(record, "[", "]")
  end
  
  private 
  def validate_brackets(record, left_bracket, right_bracket)
    count = 0
    if record.title.include?("#{left_bracket}#{right_bracket}")
      record.errors.add :base, 'has invalid title'
      return false
    end
    record.title.split("").each do |ch|
      if ch == left_bracket
        count += 1
      elsif ch == right_bracket
        if (count == 0)
          record.errors.add :base, 'has invalid title'
          return false
        else
          count -= 1
        end
      end
    end
    if (count == 0)
      return true
    end
    record.errors.add :base, 'has invalid title'
    return false
  end
end    
