function Div(el)
  -- Specify the class to silence
  local silencedClass = "silence"
  local silencedClass2 = ".answer"

  -- Check if the <div> tag has the specified class
  if el.classes:includes(silencedClass) or el.classes:includes(silencedClass2) then
    -- Set the content of the <div> to an empty table
    el.content = {}
  end
  return el
end