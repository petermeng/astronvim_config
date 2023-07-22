return {
    {
        'echasnovski/mini.animate',
        version = false,
        config = function()
            require('mini.animate').setup()
        end
    },
    {
        'echasnovski/mini.move',
        lazy = false,
        version = false,
        config = function()
            require('mini.move').setup()
        end,
    },
}
