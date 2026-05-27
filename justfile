# https://just.systems

default:
    nvim --headless -i NONE '+lua require("nfnl.api")["compile-all-files"](".")' +qa
