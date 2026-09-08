# https://just.systems

default:
    fnlfmt --fix $(find . -name '*.fnl' -not -path './lua/*')
    nvim --headless -i NONE '+lua require("nfnl.api")["compile-all-files"](".")' +qa
