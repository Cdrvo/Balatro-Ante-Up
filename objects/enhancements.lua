SMODS.Enhancement({
	key = "shattered",
	atlas = "enh",
	pos = { x = 0, y = 0 },
	discovered = true,
	unlocked = true,
	replace_base_card = true,
	no_rank = true,
	no_suit = true,
	overrides_base_rank = true,
	any_suit = false,
	always_scores = true,
	weight = 0,
	config = { extra = { x_mult = 2, odds = 4 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context, effect)
		if context.main_scoring and context.cardarea == G.play then
			return {
				x_mult = card.ability.extra.x_mult,
			}
		end
	end,
})