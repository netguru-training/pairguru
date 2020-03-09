class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    @record = record

    title_valid? ? select_brackets : error_message
  end

  def title_valid?
    if @record.title.include?('[]') || @record.title.include?('{}') || @record.title.include?('()')
      false
    else
      true
    end
  end

  def select_brackets
    brackets = []
    bracket_types = ['[',']','{','}','(',')']

    @record.title.split('').select do |letter|
      brackets << letter if bracket_types.include?(letter)
    end

    brackets = brackets.join('')

    check_brackets_order(brackets)
  end

  def check_brackets_order(brackets)
    return true if brackets.length == 0

    if brackets.include?('[]')
      brackets = brackets.gsub!('[]', '')
      check_brackets_order(brackets)
    elsif brackets.include?('{}')
      brackets = brackets.gsub!('{}', '')
      check_brackets_order(brackets)
    elsif brackets.include?('()')
      brackets = brackets.gsub!('()', '')
      check_brackets_order(brackets)
    else
      return error_message
    end
  end

  def error_message
    @record.errors.add(@record.title, "Brackets can't be empty.")
  end
end
