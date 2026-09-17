return {
  -- Auto pairing
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function(_, opts)
      require('mini.pairs').setup(opts)
    end
  },

  -- Surround text object
  {
    "echasnovski/mini.surround",
    config = function(_, opts)
      require('mini.surround').setup(opts)
    end
  },
}