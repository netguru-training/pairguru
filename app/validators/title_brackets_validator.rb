class TitleBracketsValidator < ActiveModel::Validator
    def validate(object)
    title = object.title

    title_invalid = false
    check_brackets = 0
    check_curly_brackets = 0
    check_square_brackets = 0
    
    for i in 0..title.length do
      if title[i] == '('
        check_brackets += 1

        next_bracket_index = title[i..-1].index(')')
        if next_bracket_index && title[i..next_bracket_index+i].length < 3
          title_invalid = true
          break
        end
      end
      check_brackets -= 1 if title[i] == ')'

      if title[i] == '{'
        check_curly_brackets += 1 

        next_bracket_index = title[i..-1].index('}')
        if next_bracket_index && title[i..next_bracket_index+i].length < 3
          title_invalid = true
          break
        end
      end
      check_curly_brackets -= 1 if title[i] == '}'

      if title[i] == '['
        check_square_brackets += 1 

        next_bracket_index = title[i..-1].index(']')
        if next_bracket_index && title[i..next_bracket_index+i].length < 3
          title_invalid = true
          break
        end
      end

      check_square_brackets -= 1 if title[i] == ']'

      if [check_brackets, check_curly_brackets, check_square_brackets].any? { |e| e < 0 }
        title_invalid = true
        break
      end
    end

    unless !title_invalid && [check_brackets, check_curly_brackets, check_square_brackets].all? { |e| e == 0 }
      title_invalid = true
    end

    return unless title_invalid 

    object.errors.add(:title, "is not valid" )
  end
end