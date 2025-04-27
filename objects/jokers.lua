SMODS.Joker({
	key = "teto", -- Maid Teto
	atlas = "Jokers",
	rarity = 4,
	cost = 20,
	unlocked = true,
	discovered = true,
	pos = {
		x = 0,
		y = 0,
	},
	soul_pos = {
		x = 1,
		y = 0,
	},
	calculate = function(self, card, context)
		local atp = card.ability.extra
		local hearts = 0
		if context.end_of_round then
			local redh_suits = 0
			for k, v in ipairs(G.hand.cards) do
				if v:is_suit("Hearts", nil, true) then
					redh_suits = redh_suits + 1
				end
			end
			for i = 1, redh_suits do
				SMODS.add_card({
					set = "Spectral",
					edition = "e_negative",
				})
			end
		end
	end,
})

SMODS.Joker({
	key = "playlist", --Playlist
	atlas = "Jokers",
	rarity = 2,
	cost = 1,
	unlocked = true,
	discovered = true,
	pos = {
		x = 0,
		y = 1,
	},
	config = {
		extra = {
			xmult = 1,
			xmultg = 0.1,
		},
	},
	loc_vars = function(self, info_queue, center)
		return {
			vars = { G.GAME.playsuit },
		}
	end,

	calculate = function(self, card, context)
		local atp = card.ability.extra
		if context.discard and not context.blueprint and not context.repetition then
			if context.other_card:is_suit(G.GAME.playsuit, true) then
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.RED }
				)
				atp.xmult = atp.xmult + atp.xmultg
			end
		end
		if context.joker_main then
			return {
				xmult = atp.xmult,
			}
		end
	end,
})

SMODS.Joker({
	key = "celeste", --Madeline
	atlas = "Jokers",
	rarity = 2,
	cost = 1,
	unlocked = true,
	discovered = true,
	pos = {
		x = 1,
		y = 1,
	},
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			context.other_card:set_seal("anp_sbs")
		end
	end,
})

SMODS.Joker({
	key = "gace", --Fucked up ace?
	atlas = "Jokers",
	rarity = 2,
	cost = 1,
	unlocked = true,
	discovered = true,
	pos = {
		x = 2,
		y = 1,
	},
})

SMODS.Joker({
	key = "icece", --cookie cat
	atlas = "Jokers",
	rarity = 2,
	cost = 1,
	unlocked = true,
	discovered = true,
	pos = {
		x = 2,
		y = 0,
	},
	config = {
		extra = {
			chipx = 3,
		},
	},
	calculate = function(self, card, context)
		local atp = card.ability.extra
		local hearts = 0
		if
			context.individual
			and context.cardarea == G.play
			and context.other_card:is_suit("Hearts", true)
			and not context.blueprint
		then
			hearts = hearts + 1
		end
		if context.joker_main and hearts == 0 then
			return {
				xchips = atp.chipx,
			}
		end
		if context.after then
			hearts = 0
		end
	end,
})

SMODS.Joker({
	key = "glassgun",
	rarity = 2,
	cost = 4,
	atlas = "Jokers",
	config = {
		extra = {
			mult = 1,
		},
	},
	pos = { x = 3, y = 0 },
	soul_pos = { x = 3, y = 1 },
	discovered = true,
	blueprint_compat = true,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.glassodds = G.GAME.glassodds * 2
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.glassodds = G.GAME.glassodds / 2
	end,
	calculate = function(self, card, context)
		if
			context.individual
			and context.cardarea == G.play
			and SMODS.has_enhancement(context.other_card, "m_glass")
		then
			context.other_card:set_edition({ polychrome = true }, true)
		end
		if context.destroying_card and context.cardarea == G.play then
			if SMODS.has_enhancement(context.destroy_card, "m_glass") then
				for i = 1, #context.full_hand do
					local acard = copy_card(context.full_hand[i], nil, nil, G.playing_card)
					G.deck.config.card_limit = G.deck.config.card_limit + 1
					table.insert(G.playing_cards, acard)
					acard:set_ability(G.P_CENTERS["m_anp_shattered"])
					acard:add_to_deck()
					G.hand:emplace(acard)
					acard.states.visible = nil
					G.E_MANAGER:add_event(Event({
						func = function()
							acard:start_materialize()
							return true
						end,
					}))
				end
			end
		end
	end,
})

SMODS.Enhancement:take_ownership("glass", {
	config = { Xmult = 2, extra = 4 },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.Xmult, G.GAME.probabilities.normal, G.GAME.glassodds },
		}
	end,
	calculate = function(self, card, context)
		if
			context.destroy_card
			and context.cardarea == G.play
			and context.destroy_card == card
			and pseudorandom("glass") < G.GAME.probabilities.normal / G.GAME.glassodds
		then
			return { remove = true }
		end
	end,
})

SMODS.Joker({
	key = "blt", --Balatro
	atlas = "Jokers",
	rarity = 2,
	cost = 1,
	unlocked = true,
	discovered = true,
	pos = {
		x = 4,
		y = 0,
	},
})

SMODS.Joker({
	key = "fur", --Furina
	atlas = "Jokers",
	rarity = 2,
	cost = 1,
	unlocked = true,
	discovered = true,
	pos = {
		x = 4,
		y = 1,
	},
})
