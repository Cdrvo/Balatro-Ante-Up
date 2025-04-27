SMODS.load_file("objects/jokers.lua")()
SMODS.load_file("objects/seals.lua")()
SMODS.load_file("objects/enhancements.lua")()

SMODS.Atlas{
    key = "Jokers",
    path = "jokers.png",
    px = 71,
    py = 95
}

SMODS.Atlas{
    key = "enh",
    path = "enh.png",
    px = 71,
    py = 95
}

local igo = Game.init_game_object
Game.init_game_object = function(self)
	local ret = igo(self)
	ret.playsuit = "Spades"
    ret.glassodds = 4
    ret.glassxmult = 2
	return ret
end

function reset_ancient_card()
    local ancient_suits = {}
    for k, v in ipairs({'Spades','Hearts','Clubs','Diamonds'}) do
        if v ~= G.GAME.current_round.ancient_card.suit then ancient_suits[#ancient_suits + 1] = v end
    end
    local ancient_card = pseudorandom_element(ancient_suits, pseudoseed('anc'..G.GAME.round_resets.ante))
    G.GAME.current_round.ancient_card.suit = ancient_card

    local playlist_card = pseudorandom_element(ancient_suits, pseudoseed('anc'..G.GAME.round_resets.ante))
    G.GAME.playsuit = playlist_card
end