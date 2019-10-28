--------------------------------------
-- Start defining the sets
--------------------------------------
sets.buff['Chain Affinity'] = {feet="Assimilator's Charuqs +1"}
sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
--sets.buff.Enchainment = {body="Luhlaza Jubbah +1"}
--sets.buff.Efflux = {legs="Mavi Tayt +2"}


-- TH sets
sets.TH3 = {
	head=gear.Herc_TH_head, -- 2
	waist="Chaac Belt"		-- 1
}

sets.TH4 = {
	head=gear.Herc_TH_head, -- 2
	body="Volte Jupon",		-- 2
}

sets.TreasureHunter = sets.TH4

-- Precast Sets
sets.precast.FC = {
								
	ammo="Sapience Orb",		-- 2
	head="Carmine Mask +1", 	-- 14
	neck="Orunmila's Torque",	-- 5
	ear1="Etiolation Earring",	-- 1
	ear2="Loquacious Earring",	-- 2
	body=gear.Taeon_FC_body, 	-- 8
	hands="Leyline gloves", 	-- 8
	ring1="Kishar Ring",		-- 4
	ring2="Prolix Ring",		-- 2
	back="Swith Cape +1", 		-- 4
	waist="Witful Belt", 		-- 3
	legs="Psycloth Lappas",		-- 7
	feet="Carmine Greaves +1"	-- 7
}								-- 67 + 15(traits from flutter) = 82

-- Weaponskill sets
-- Default set for any weaponskill that isn't any more specifically defined
sets.precast.WS = {
	ammo="Jukukik Feather",
	head=gear.Adhemar_TP_head,
	neck="Mirage Stole +2",
	ear1="Mache Earring +1",
	ear2="Mache Earring +1",
	body=gear.Herc_CDC_body,
	hands=gear.Herc_CDC_hands,
	--ring1="Begrudging Ring",
	ring1="Ilabrat Ring",
	ring2="Epona's Ring", 
	back=gear.BLU_CDC_Cape,
	waist="Fotia Belt",
	legs="Samnuha Tights",
	feet="Thereoid Greaves"
}

sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

sets.precast.WS.WSD_STR = set_combine(sets.precast.WS,{
	ammo="Mantoptera Eye",
	head=gear.Herc_SB_head,
	neck="Mirage Stole +2",
	ear1="Moonshade Earring",
	ear2="Ishvara Earring",
	body="Assimilator's Jubbah +3",
	hands="Jhakri Cuffs +2",
	ring1="Karieyh Ring +1",
	ring2="Epaminondas's Ring",
	back=gear.BLU_SB_Cape,
	waist="Prosilio Belt +1",
	legs="Luhlaza Shalwar +3",
	feet=gear.Herc_SB_feet
})

sets.precast.WS.WSD_STR.Acc=set_combine(sets.precast.WS.WSD_STR,{waist="Grunfeld Rope"})
sets.precast.WS.WSD_STR.FullTP = set_combine(sets.precast.WS.WSD_STR,{ear1="Odnowa Earring +1"})

for _, ws in ipairs({'Savage Blade','Expiacion','Black Halo'}) do
	sets.precast.WS[ws] = sets.precast.WS.WSD_STR
	sets.precast.WS[ws].Acc= sets.precast.WS.WSD_STR.Acc
	sets.precast.WS[ws].FullTP = sets.precast.WS.WSD_STR.FullTP
end

sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,{
	head="Jhakri Coronal +2",
	neck="Fotia Gorget",
	ear1="Moonshade Earring",
	ear2="Brutal Earring",
	body="Jhakri Robe +2",
	hands="Jhakri Cuffs +2",
	ring1="Rufescent Ring",
	ring2="Epona's Ring",
	back=gear.BLU_CDC_Cape,
	waist="Fotia Belt",
	legs="Jhakri Slops +2",
	feet="Jhakri Pigaches +2"
})

-- Midcast Sets
sets.midcast.FastRecast = sets.precast.FC	
	
sets.midcast['Blue Magic'] = {}

-- Physical Spells --

sets.midcast['Blue Magic'].Physical = {
	ammo="Mantoptera Eye",
	head=gear.Herc_SB_head,neck="Mirage Stole +2",ear1="Telos Earring",ear2="Dignitary's Earring",
	body=gear.Adhemar_TP_body,hands=gear.Herc_Reso_hands,ring1="Ilabrat Ring",ring2="Shukuyu Ring",
	back=gear.BLU_SB_Cape,waist="Prosilio Belt +1",legs="Samnuha Tights",feet=gear.Herc_Reso_feet
}

sets.midcast['Blue Magic'].PhysicalAcc = sets.midcast['Blue Magic'].Physical
sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,{})
sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {back=gear.BLU_CDC_Cape,ammo="Jukukik Feather"})
sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})
sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})
sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})
sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {back="Cornflower Cape"})
sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {back="Cornflower Cape"})
sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical,{})


-- Magical Spells
sets.midcast['Blue Magic'].Magical = {
	ammo="Pemphredo Tathlum",
	head=gear.Herc_MAB_head, neck="Sanctity Necklace", ear1="Friomisi Earring", ear2="Regal Earring",
	body=gear.Amal_nuke_body, hands=gear.Amal_nuke_hands, ring1="Shiva Ring +1", ring2="Shiva Ring +1",
	back=gear.BLU_nuke_Cape, waist="Yamabuki-no-Obi", legs=gear.Amal_nuke_legs, feet=gear.Amal_nuke_feet
}

sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
	head="Pixie Hairpin +1",
	ring2="Archon Ring",
})

sets.precast.WS['Sanguine Blade'] = set_combine(sets.midcast['Blue Magic'].Magical,{
	head="Pixie Hairpin +1",
	hands="Jhakri Cuffs +2",
	legs="Luhlaza Shalwar +3",
	ring1="Epaminondas's Ring",
	ring2="Archon Ring",
})

sets.precast.WS['Seraph Blade']  = sets.midcast['Blue Magic'].Magical

sets.magic_burst = {
								-- MB1	MB2
	body="Samnuha Coat", 		--		8
	hands=gear.Amal_nuke_hands,	--		6
	feet="Jhakri Pigaches +2", 	--	7
	ring1="Mujin Band", 		--		5
	ring1="Locus Band", 		-- 	5
	back="Seshaw Cape", 		--	5
}

-- Magical overrides
sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,{
	head=gear.Herc_MAB_head, 
	body="Jhakri Robe +2", hands="Jhakri Cuffs +2",
	legs="Jhakri Slops +2", feet="Jhakri Pigaches +2"
})
sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,{})
sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)
sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical,{})
sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)
sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical.Resistant,{
	head="Assimilator's Keffiyeh +2",
	neck="Mirage Stole +2",
	ear1="Dignitary's earring", 
	ear2="Regal Earring",
	ring1="Stikini Ring +1",
	ring2="Stikini Ring +1",
	legs="Luhlaza Shalwar +3",
	waist="Luminary Sash",
	
})
sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical,{})
sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {})

-- Healing spells (cure potency; HP for white wind)
sets.midcast['Blue Magic']['White Wind'] = {}
sets.midcast['Blue Magic'].Healing = {	--CP
	head="Carmine Mask +1",
	neck="Phalaina Locket",				-- 4
	ear1="Mendi. Earring",				-- 5
	ear2="Lifestorm Earring",
	body="Vrikodara Jupon",				--13	
	hands=gear.Telchine_CPR_hands,		--10
	ring1="Rufescent Ring",
	ring2="Stikini Ring +1",
	back="Solemnity Cape",				-- 7
	waist="Luminary Sash",
	legs="Gyve Trousers",				--10
	feet="Medium's sabots" 				-- 9
}										--58

sets.self_healing = set_combine(sets.midcast['Blue Magic'].Healing,{
									--  CPR
	neck="Phalaina Locket",			--	4
	hands=gear.Telchine_CPR_hands,	--	7
	waist="Gishdubar Sash",			--	10
	ring2="Kunaji Ring",			--	5
	ring2="Asklepian Ring"			--	3
})									--	29

-- Buff spells
sets.midcast['Blue Magic'].SkillBasedBuff = {
	-- Base						--	424
	neck="Mirage Stole +2",		--	25
	body="Assim. Jubbah +3",	--	24
	ring1="Stikini Ring +1",		-- 	5
	ring2="Stikini Ring +1",		--	5
	back="Cornflower Cape",		--	15
	legs="Mavi Tayt +2",		--	15
	feet="Luhlaza Charuqs",		--	6
}								-- 519

sets.midcast['Blue Magic'].Buff = sets.precast.FC

sets.midcast.Aquaveil =  {
	head="Amalric Coif +1",	--	2
	legs="Shedir Seraweels",--	1
	waist="Emphatikos Rope",--	1
}
sets.midcast['Blue Magic']['Carcharian Verve'] = sets.midcast.Aquaveil

sets.midcast.Refresh = {
	head="Amalric Coif +1",
	waist="Gishdubar Sash"
}
sets.midcast['Blue Magic']['Battery Charge'] = sets.midcast.Refresh



-- Resting sets
sets.resting = {}

-- Idle sets
sets.idle = {					-- Refresh
	ammo="Ginsen",				
	head=gear.Herc_Ref_head, 	-- 1
	neck="Loricate Torque +1",
	ear1="Etiolation Earring",
	ear2="Genmei Earring",
	body="Jhakri Robe +2",		-- 4
	hands=gear.Herc_Ref_hands,	-- 2
	ring1="Stikini Ring +1",	-- 1
	ring2="Stikini Ring +1",	-- 1
	back="Moonbeam Cape",
	waist="Flume Belt +1",
	legs="Carmine Cuisses +1",
	feet=gear.Herc_Ref_feet		-- 2
}								--11

sets.idle.PDT = set_combine(sets.idle,{
								--	PDT		MDT
	ammo="Staunch Tathlum +1", 	--    3		  3
	head="Malignance Chapeau",	--    6		  6
	neck="Loricate Torque +1",	--	  6		  6
	ear1="Etiolation Earring", 	--			  3
	ear2="Ethereal Earring",	-- 			  
	body="Jhakri Robe +2",		-- 
	hands="Malignance Gloves",	--	  5		  5
	ring1="Defending Ring",		--	 10		 10
	ring2="Gelatinous Ring +1",	--	  7		 -1
	waist="Flume Belt +1",		--	  4
	back="Moonbeam Cape",		--	  5 	  5
	legs="Malignance Tights",	--	  7		  7
	feet=gear.Herc_Ref_feet		-- 
})								--   53		 44


sets.idle.Town = set_combine(sets.idle,{})
sets.latent_refresh = {waist="Fucho-no-obi"}

-- Defense sets
sets.defense.PDT = set_combine(sets.idle.PDT,{})
sets.defense.MDT = set_combine(sets.idle.PDT,{})
sets.Kiting = set_combine(sets.idle,{legs="Carmine Cuisses +1"})

-- Engaged sets

-- 0 haste - DW req: 49
sets.engaged  = {
	ammo="Ginsen",				
	head=gear.Adhemar_TP_head,
	neck="Mirage Stole +2",
	ear1="Suppanomimi",			-- 5
	ear2="Eabani Earring", 		-- 4
	body=gear.Adhemar_TP_body,	-- 6
	hands=gear.Adhemar_TP_hands,
	ring1="Hetairoi Ring", 		
	ring2="Epona's Ring",
	back=gear.BLU_TP_Cape,
	waist="Reiki Yotai", 		-- 7
	legs="Carmine Cuisses +1", 	-- 6
	feet=gear.Taeon_DW_feet		-- 9
}								--37DW
	
sets.engaged.MidAcc = set_combine(sets.engaged,{
	head="Dampening Tam",
	ear1="Telos Earring",
	waist="Kentarch Belt +1",
	ring1="Ilabrat Ring",
})

sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc,{
	ammo="Falcon Eye",
	ear2="Cessance Earring",
	legs="Carmine Cuisses +1",	
	head="Carmine Mask +1",
	ring1="Chirich Ring",
	ring2="Chirich Ring",
})

-- 15% haste - DW req: 42
sets.engaged.LowHaste = set_combine(sets.engaged,{}) -- 37DW
sets.engaged.MidAcc.LowHaste = sets.engaged.MidAcc
sets.engaged.HighAcc.LowHaste = sets.engaged.HighAcc

-- 30% Haste - DW req: 31
sets.engaged.HighHaste = set_combine(sets.engaged,{
	feet=gear.Herc_TP_feet
}) -- 28DW							

sets.engaged.MidAcc.HighHaste = set_combine(sets.engaged.HighHaste,{
	head="Dampening Tam",
	ear1="Telos Earring",
	legs="Carmine Cuisses +1",
	waist="Kentarch Belt +1",
	ring1="Ilabrat Ring",
})
sets.engaged.HighAcc.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste,{
	ammo="Falcon Eye",
	ear2="Cessance Earring",
	head="Carmine Mask +1",
	ring2="Chirich Ring",
})

-- Cap Haste - DW req: 11
sets.engaged.MaxHaste = set_combine(sets.engaged,{
	ear1="Suppanomimi",				
	ear2="Cessance Earring",
	waist="Windbuffet Belt +1",
	legs="Samnuha Tights",
	feet=gear.Herc_TP_feet
}) -- DW:11

sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.MaxHaste,{
	head="Dampening Tam",
	ear1="Telos Earring",
	neck="Combatant's Torque",
	legs="Carmine Cuisses +1",
	waist="Kentarch Belt +1",
	ring1="Ilabrat Ring",
})

sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste,{
	ammo="Falcon Eye",
	head="Carmine Mask +1",
	ring2="Chirich Ring",
})	

sets.engaged.Refresh = set_combine(sets.engaged,{
	body="Jhakri Robe +2",
	hands=gear.Herc_Ref_hands,
	feet=gear.Herc_Ref_feet
})

-- Hybrid sets
sets.engaged.Hybrid = {
	head="Malignance Chapeau",	--  6	6
	body="Malignance Tabard",	--	9	9
	hands="Malignance Gloves",	--	5	5
	legs="Malignance Tights",	--	7	7
	feet="Malignance Boots",	--  4	4
	--ring1="Defending Ring", 	-- 10	10
	--	JSE Cape				-- 10
								-- 51	41
}								

sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

sets.engaged.DT.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.Hybrid)
sets.engaged.MidAcc.DT.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, sets.engaged.Hybrid)
sets.engaged.HighAcc.DT.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.engaged.Hybrid)    

sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Hybrid)
sets.engaged.MidAcc.DT.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.engaged.Hybrid)
sets.engaged.HighAcc.DT.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.engaged.Hybrid)    

sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Hybrid)
sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)    

sets.Ref = {
	body="Jhakri Robe +2",
	hands=gear.Herc_Ref_hands,
	feet=gear.Herc_Ref_feet
}

sets.engaged.Refresh = set_combine(sets.engaged, sets.Ref)
sets.engaged.MidAcc.Refresh = set_combine(sets.engaged.MidAcc, sets.Ref)
sets.engaged.HighAcc.Refresh = set_combine(sets.engaged.HighAcc, sets.Ref)

sets.engaged.Refresh.LowHaste = set_combine(sets.engaged.LowHaste, sets.Ref)
sets.engaged.MidAcc.Refresh.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, sets.Ref)
sets.engaged.HighAcc.Refresh.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.Ref)    

sets.engaged.Refresh.HighHaste = set_combine(sets.engaged.HighHaste, sets.Ref)
sets.engaged.MidAcc.Refresh.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.Ref)
sets.engaged.HighAcc.Refresh.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.Ref)    

sets.engaged.Refresh.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.Ref)
sets.engaged.MidAcc.Refresh.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.Ref)
sets.engaged.HighAcc.Refresh.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.Ref)    

sets.Obi = {waist="Hachirin-no-Obi"}

-- Orgnizer set
organizer_items = {
		-- Weapons
		sword1="Tizona",
		sword2="Almace",
		sword3="Thibron",
		sword4="Naegling",
		club1="Maxentius",
		-- Meds
		echos="Echo Drops",
		remedy="Remedy",
		-- Food
		sushi="Sublime Sushi",
		atkfood="Red Curry Bun",
		-- Utils
		warpr="Warp Ring",
		teler="Dim. Ring (Dem)",
		-- Others
		rrpin="Reraise Hairpin"
}