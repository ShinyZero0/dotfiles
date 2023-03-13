require('lint').linters.selene = {
    cmd = "selene",
    stdin = false,
    stream = "stdout"
}
require('lint').linters_by_ft = {
  markdown = {'selene'}
}
