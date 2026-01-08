function CodeBlock(block)
  -- Get the first class if it exists
  if block.classes and #block.classes > 0 then
    local lang = block.classes[1]
    -- Clear existing classes
    block.classes = {}
    -- Add the language- prefixed class
    table.insert(block.classes, "language-" .. lang)
  end
  return block
end
