local patterns = require "nrpattern.default"

patterns[{ 'True', 'False' }] = { priority = 5 }
patterns[{ 'yes', 'no' }] = { priority = 5 }

require("nrpattern").setup(patterns)
