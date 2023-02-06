function restartwt --wraps='pkill -9 aces && steam steam://rungameid/236390' --description 'alias restartwt=kill -9 aces && steam steam://rungameid/236390'
  kill -9 aces && steam steam://rungameid/236390 $argv; 
end
