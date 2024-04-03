local telescope = require('telescope')
telescope.setup {
  -- opts...
}
telescope.load_extension('manix')

require('neorg').setup {
    load = {
        ["core.defaults"] = {}
    }
}
