
# classifies the code from user input to icd or chop or unknown
# accepts only exact matches and is case insensitive
def get_code_type(input)
  if input.match(/^.\d{2}(\.\d{1,2})?$/)
    return :icd
  elsif input.match(/^\d{2}\.\w{0,2}(\.\w{0,2})?$/)
    return :chop
  else return :unknown
  end
end