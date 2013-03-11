
# classifies the code from user input to icd or chop or unknown
# accepts only exact matches and is case insensitive
def get_code_type(input)
  if input.match(/\A[A-Z]\d{2}(\.\d{1,2})?/)
    return :icd
  end
  return :unknown
end
