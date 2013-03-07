

def get_code_type(input)
  if input.match(\d{2}\.\w{0,2}(\.\w{0,2})?)
    return :chop
  elsif input.match(.\d{2}\.\d{1,2})
    return :icd
  else return :unknown
  end

end