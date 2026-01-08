function Header(el)
  -- Only process level 1 headers (# Title in markdown)
  if el.level == 1 then
    -- Check if this is the first header in the document
    if not title_removed then
      title_removed = true
      -- Return empty content to remove this header
      return {}
    end
  end
  -- Return unchanged for all other headers
  return el
end
