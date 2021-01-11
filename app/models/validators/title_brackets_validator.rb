class TitleBracketsValidator < ActiveModel::Validator

  BRACKETS = {
    ")" => "(",
    "}" => "{",
    "]" => "["
  }

  attr_reader :record

  def validate(record)
    @record = record
    stack = []

    record.title.each_char.with_index do |char, index|
      next unless kind_of_bracket?(char)
      if opening_bracket?(char)
        stack << char
      elsif stack.last == BRACKETS[char]
        return add_title_error if stack.last == record.title[index-1]
        stack.pop
      else
        return add_title_error
      end
    end
    add_title_error unless stack.empty?
  end

  private

  def opening_bracket?(char)
    BRACKETS.values.include? char
  end

  def kind_of_bracket?(char)
    BRACKETS.flatten.include? char
  end

  def add_title_error
    record.errors["title"] << "Invalid brackets"
    return false
  end

end
