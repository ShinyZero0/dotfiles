local get_visual = function(args, parent)
  if (#parent.snippet.env.SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
  else  -- If SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end
return{
s(
    { trig = "lazy" },
    fmta('"<>",',
        {
            d(1, get_visual),
        }
    )
),

}
