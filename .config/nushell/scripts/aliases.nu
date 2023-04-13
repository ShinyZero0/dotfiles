# old alias for competion
old-alias pkin = sudo xbps-install
old-alias pkrm = sudo xbps-remove
alias pkup = sudo xbps-install -SAu
alias pkfd = xbps-query -Rs
old-alias dn = dotnet

# list runit services
alias svls = ls /var/service/
# and available ones
alias svlsav = ls /etc/sv/

old-alias ga = git add 
alias gc = git commit -m
alias gd = git diff 
alias gds = git diff --staged
alias gst = git status
alias gcl = git clone
alias gca = git commit -am
old-alias gch = git checkout
alias grm = git rm --cached
alias gcl1 = git clone --depth 1
alias grss = git restore --staged

alias yd = yadm enter nu
alias vi = nvim

alias q = exit
alias r = exec nu
