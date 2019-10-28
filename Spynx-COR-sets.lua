--------------------------------------
-- Precast sets
--------------------------------------
sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}

sets.precast.FC = {
	head="Carmine Mask +1", 	--	14
	body=gear.Taeon_FC_body,	--	 8
	hands="Leyline Gloves", 	--	 8
	feet="Carmine Greaves +1",	--	 8
	neck="Orunmila's Torque",  	--	 5
	ear1="Loquacious Earring", 	--	 2
	ring1="Kishar Ring",		--	 4
}								--  49

sets.precast.CorsairRoll = {
	-- Compensator is equipped only if low TP or forced
	main="Lanun Knife",
	head="Lanun tricorne +1",	
	body="Malignance Tabard",		
	hands="Chasseur's Gants +1",  	
	legs="Desultor Tassets",
	feet="Malignance Boots",		
	neck="Regal Necklace",	
	waist="Flume Belt +1",
	ring1="Defending Ring",
	ring2="Luzaf's Ring",
	ear1="Genmei Earring",		
	ear2="Etiolation Earring",	
	back="Camulus's Mantle"
}

sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac"})
sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})

-- Snapshot caps at 70 - 
sets.precast.RA = {					-- SNAP		RAPID
	-- COR Gifts/base				--	10		 30
	ammo=gear.RAbullet,			
	head=gear.Taeon_SNAP_head,		--	10
	body="Oshosi Vest +1",			-- 	14
	hands=gear.Carmine_SNAP_hands,	--	 8		 11
	feet="Meg. Jam. +2",			--	10
	legs=gear.Adhemar_SNAP_legs,	--	 9		 10
	waist="Yemaya Belt",			--			 5
	back=gear.COR_SNAP_Cape,		--	10
}									--	71		 56


sets.precast.RA.Flurry1 = set_combine(sets.precast.RA,{
								-- SNAP		RAPID
	body="Laksa. Frac +3",		-- -10		20
})								--	57		76

sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1,{
								-- SNAP		RAPID
	head="Chass. Tricorne",  	-- -10		12
	feet="Pursuer's Gaiters", 	-- -10	    10
	waist="Impulse Belt", 		--   3		-5
								--  40		93
})

-- Weaponskill sets
sets.precast.WS = {
	ammo=gear.WSbullet,
	head=gear.Herc_RA_head,
	body="Laksa. Frac +3",
	hands="Meg. Gloves +2",
	legs="Meg. Chausses +2",
	feet="Lanun Bottes +3",
	neck="Fotia Gorget",
	ear1="Ishvara Earring",
	ear2="Moonshade Earring",
	ring1="Regal Ring",
	ring2="Epaminondas's Ring",
	back=gear.COR_WSPhys_Cape,
	waist="Fotia Belt",
}

sets.precast.WS['Leaden Salute'] = {
	ammo=gear.MAbullet,
	head="Pixie Hairpin +1",
	body="Lanun Frac +3",
	hands=gear.Carmine_LS_hands,
	legs=gear.Herc_MAB_legs,
	feet="Lanun Bottes +3",
	neck="Comm. Charm +1",
	waist="Eschan Stone",
	ear1="Friomisi Earring",
	ear2="Moonshade Earring",
	ring1="Dingir Ring",
	ring2="Archon Ring",
	back=gear.COR_WSMagic_Cape
}

sets.precast.WS['Leaden Salute'].FullTP = {ear2="Hecate's Earring"}

sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS['Leaden Salute'],{
	head=gear.Herc_MAB_head,
	ear2="Hecate's Earring",
	ring2="Epaminondas's Ring"
})

sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Wildfire']

sets.precast.WS["Last Stand"] = sets.precast.WS

sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
	head="Meghanada Visor +2",
	neck="Iskur Gorget",
	ear2="Telos Earring",
	feet="Meg. Jam. +2",
	ring1="Cacoethic Ring +1",
	waist="Kwahu Kachina Belt",
})

sets.precast.WS["Savage Blade"] = {
	head=gear.Herc_SB_head,
	neck="Caro Necklace",
	ear1="Ishvara Earring",
	ear2="Moonshade Earring",
	body="Laksa. Frac +3",
	hands="Meg. Gloves +2",
	ring1="Epaminondas's Ring",
	ring2="Karieyh Ring +1",
	back=gear.COR_SB_Cape,
	waist="Prosilio Belt +1",
	legs=gear.Herc_SB_legs,
	feet="Lanun Bottes +3"
}

sets.precast.WS["Savage Blade"].FullTP = set_combine(sets.precast.WS["Savage Blade"],{
	ear1="Odnowa Earring +1"
})

sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS["Savage Blade"],{
	head="Meghanada Visor +2",
	neck="Combatant's Torque",
	ear1="Telos Earring",
	waist="Grunfeld Rope",
	ring1="Regal Ring",
})


sets.precast.WS['Requiescat']=sets.precast.WS["Savage Blade"]

sets.precast.JA['Fold'] = {hands="Commodore Gants +2"}
--------------------------------------
-- Midcast sets
--------------------------------------
sets.midcast.CorsairShot = {
	ammo=gear.QDbullet,
	head=gear.Herc_MAB_head,
	body="Lanun Frac +3",
	hands=gear.Carmine_LS_hands,
	legs=gear.Herc_MAB_legs,
	feet=gear.Herc_MAB_feet,
	neck="Sanctity Necklace",
	ear1="Hecate's Earring",
	ear2="Friomisi Earring",
	ring1="Dingir Ring",
	ring2="Shiva Ring +1",
	back="Gunslinger's Cape",
	waist="Eschan Stone"
}

sets.midcast.CorsairShot.Resistant = set_combine(sets.midcast.CorsairShot, {
	head="Malignance Chapeau",
	body="Malignance Tabard",
    hands="Malignance Gloves",
	legs="Malignance Tights",
	feet="Malignance Boots",
	neck="Sanctity Necklace",
	ear1="Hermetic Earring",
	ear2="Digni. Earring"
})

sets.midcast.CorsairShot.STP  = {
	head="Malignance Chapeau",
	neck="Iskur Gorget",
	ear1="Dedition Earring",
    ear2="Telos Earring",
	body="Malignance Tabard",
    hands="Malignance Gloves",
	ring1="Chirich Ring",
    ring2="Chirich Ring",
	back=gear.COR_RA_Cape,
	waist="Kentarch Belt +1",
	legs="Malignance Tights",
	feet="Malignance Boots",
}

sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Resistant
sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot.Resistant

sets.midcast.RA = {
	ammo=gear.RAbullet,	
	head="Malignance Chapeau",
	body="Malignance Tabard",
    hands="Malignance Gloves",
	legs="Malignance Tights",
	feet="Malignance Boots",
	neck="Iskur Gorget",
	ear1="Telos Earring",
	ear2="Enervating Earring",
	ring1="Dingir Ring",
	ring2="Ilabrat Ring",
	back=gear.COR_RA_Cape,
	waist="Yemaya Belt"
}

sets.midcast.RA.Acc = set_combine(sets.midcast.RA,{
	body="Laksa. Frac +3",
	waist="Kwahu Kachina Belt",
	ring1="Regal Ring",
	ring2="Cacoethic Ring +1",
})

sets.midcast.RA.STP = set_combine(sets.midcast.RA, {
	ear2="Dedition Earring",
})

sets.TripleShot = {
        body="Oshosi Vest +1",
}


--------------------------------------
-- Idle/resting/defense sets
--------------------------------------
-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
sets.idle = {					-- PDT	MDT
	ammo=gear.RAbullet,
	head="Malignance Chapeau", 	-- 6	6
	neck="Loricate Torque +1",	-- 6	6
    ear1="Odnowa Earring +1",	-- 		2
	ear2="Etiolation Earring",	-- 		3
	body="Malignance Tabard",	-- 9	9
	hands="Malignance Gloves",	-- 5	5
    ring1="Defending Ring",		--10   10
	ring2="Shadow Ring",		
    back=gear.COR_TP_Cape,		--10
	waist="Flume Belt +1",		-- 4
	legs="Carmine Cuisses +1",	
	feet="Malignance Boots"		-- 4	4
}								--55   45

sets.idle.DT = set_combine(sets.idle,{legs="Malignance Tights"})

-- Defense sets
sets.defense.PDT = sets.idle.DT
sets.defense.MDT = sets.idle.DT
sets.Kiting = {legs="Carmine Cuisses +1"}

--------------------------------------
-- Melee sets
--------------------------------------
sets.engaged = {
	head=gear.Adhemar_TP_head,
	body=gear.Adhemar_TP_body,
	hands=gear.Adhemar_TP_hands,
	legs="Samnuha Tights",
	feet=gear.Herc_TP_feet,
	neck="Iskur Gorget",
	ear1="Cessance Earring",
	ear2="Brutal Earring",
	ring1="Hetairoi Ring",
	ring2="Epona's Ring",
	back=gear.COR_TP_Cape,
	waist="Windbuffet Belt +1",
}

sets.engaged.LowAcc = set_combine(sets.engaged, {
	head="Dampening Tam",
	ring1="Chirich Ring",
	neck="Combatant's Torque",
})

sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
	ear2="Telos Earring",
	ring1="Regal Ring",
	ring2="Ilabrat Ring",
	waist="Kentarch Belt +1",
})

sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
	head="Carmine Mask +1",
	feet=gear.Herc_Acc_feet,
	ear2="Mache Earring +1",
	ring2="Ramuh Ring +1",
	waist="Olseni Belt",
})

sets.engaged.STP = set_combine(sets.engaged, {
	feet="Carmine Greaves +1",
	ring1="Chirich Ring",
	ring2="Chirich Ring",
})

-- * DNC Subjob DW Trait: +15%
-- * NIN Subjob DW Trait: +25%

-- No Magic Haste (74% DW to cap)
sets.engaged.DW = {
	head=gear.Adhemar_TP_head,
	body=gear.Adhemar_TP_body, 	--6
	hands="Floral Gauntlets", 	--5
	legs="Carmine Cuisses +1", 	--6
	feet=gear.Taeon_DW_feet, 	--9
	neck="Iskur Gorget",
	ear1="Suppanomimi", 		--5
	ear2="Eabani Earring", 		--4
	ring1="Hetairoi Ring",
	ring2="Epona's Ring",
	back=gear.COR_DW_Cape, 		--10
	waist="Reiki Yotai", 		--7
} 								-- 52%

sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
	head="Dampening Tam",
	ring1="Chirich Ring",
	neck="Combatant's Torque",
})

sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
	ear1="Cessance Earring",
	ear2="Telos Earring",
	ring1="Regal Ring",
	ring2="Ilabrat Ring",
	waist="Kentarch Belt +1",
})

sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
	head="Carmine Mask +1",
	feet=gear.Herc_Acc_feet,
	ear2="Mache Earring +1",
})

sets.engaged.DW.STP = set_combine(sets.engaged.DW, {
	ring1="Chirich Ring",
	ring2="Chirich Ring",
})

-- 15% Magic Haste (67% DW to cap)
sets.engaged.DW.LowHaste = {
	head=gear.Adhemar_TP_head,
	body=gear.Adhemar_TP_body, --6
	hands="Floral Gauntlets", --5
	legs="Carmine Cuisses +1", --6
	feet=gear.Taeon_DW_feet, --9
	neck="Iskur Gorget",
	ear1="Suppanomimi", --5
	ear2="Eabani Earring", --4
	ring1="Hetairoi Ring",
	ring2="Epona's Ring",
	back=gear.COR_TP_Cape,
	waist="Reiki Yotai", --7
} -- 42%

sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
	head="Dampening Tam",
	ring1="Chirich Ring",
	neck="Combatant's Torque",
})

sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
	ear2="Telos Earring",
	ring1="Regal Ring",
	ring2="Ilabrat Ring",
	waist="Kentarch Belt +1",
})

sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
	head="Carmine Mask +1",
	feet=gear.Herc_Acc_feet,
	ear1="Cessance Earring",
	ear2="Mache Earring +1",
})

sets.engaged.DW.STP.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
	ring1="Chirich Ring",
	ring2="Chirich Ring",
})

-- 30% Magic Haste (56% DW to cap)
sets.engaged.DW.MidHaste = {
	head=gear.Adhemar_TP_head,
	body=gear.Adhemar_TP_body, --6
	hands=gear.Adhemar_TP_hands,
	legs="Samnuha Tights",
	feet=gear.Taeon_DW_feet, --9
	neck="Iskur Gorget",
	ear1="Suppanomimi", --5
	ear2="Eabani Earring", --4
	ring1="Hetairoi Ring",
	ring2="Epona's Ring",
	back=gear.COR_TP_Cape,
	waist="Reiki Yotai", --7
} -- 31%

sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
	head="Dampening Tam",
	ring1="Chirich Ring",
	neck="Combatant's Torque",
})

sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
	legs="Meg. Chausses +2",
	ear2="Telos Earring",
	ring1="Regal Ring",
	ring2="Ilabrat Ring",
	waist="Kentarch Belt +1",
})

sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
	head="Carmine Mask +1",
	legs="Carmine Cuisses +1",
	feet=gear.Herc_Acc_feet,
	ear1="Cessance Earring",
	ear2="Mache Earring +1",
})

sets.engaged.DW.STP.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
	ring1="Chirich Ring",
	ring2="Chirich Ring",
})

-- 35% Magic Haste (51% DW to cap)
sets.engaged.DW.HighHaste = {
	head=gear.Adhemar_TP_head,
	body=gear.Adhemar_TP_body, --6
	hands=gear.Adhemar_TP_hands,
	legs="Samnuha Tights",
	feet=gear.Herc_TP_feet,
	neck="Iskur Gorget",
	ear1="Suppanomimi", --5
	ear2="Eabani Earring", --4
	ring1="Hetairoi Ring",
	ring2="Epona's Ring",
	back=gear.COR_TP_Cape,
	waist="Reiki Yotai", --7
} -- 27%

sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
	head="Dampening Tam",
	ring1="Chirich Ring",
	neck="Combatant's Torque",
})

sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
	legs="Meg. Chausses +2",
	ear2="Telos Earring",
	ring1="Regal Ring",
	ring2="Ilabrat Ring",
	waist="Kentarch Belt +1",
})

sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
	head="Carmine Mask +1",
	legs="Carmine Cuisses +1",
	feet=gear.Herc_Acc_feet,
	ear1="Cessance Earring",
	ear2="Mache Earring +1",
})

sets.engaged.DW.STP.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
	ring1="Chirich Ring",
	ring2="Chirich Ring",
})

-- 45% Magic Haste (36% DW to cap)
sets.engaged.DW.MaxHaste = {
	head=gear.Adhemar_TP_head,
	body=gear.Adhemar_TP_body, --6
	hands=gear.Adhemar_TP_hands,
	legs="Samnuha Tights",
	feet=gear.Herc_TP_feet,
	neck="Iskur Gorget",
	ear1="Suppanomimi", --5
	ear2="Telos Earring",
	ring1="Hetairoi Ring",
	ring2="Epona's Ring",
	back=gear.COR_TP_Cape,
	waist="Windbuffet Belt +1",
} -- 11%

sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
	head="Dampening Tam",
	ring1="Chirich Ring",
	waist="Kentarch Belt +1",
})

sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
	legs="Meg. Chausses +2",
	neck="Combatant's Torque",
	ear1="Cessance Earring",
	ring1="Regal Ring",
	ring2="Ilabrat Ring",
})

sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
	head="Carmine Mask +1",
	legs="Carmine Cuisses +1",
	feet=gear.Herc_Acc_feet,
	ear2="Mache Earring +1",
})

sets.engaged.DW.STP.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
	feet="Carmine Greaves +1",
	ring1="Chirich Ring",
	ring2="Chirich Ring",
})

sets.engaged.DW.MaxHastePlus = set_combine(sets.engaged.DW.MaxHaste, {back=gear.COR_DW_Cape})
sets.engaged.DW.LowAcc.MaxHastePlus = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {back=gear.COR_DW_Cape})
sets.engaged.DW.MidAcc.MaxHastePlus = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {back=gear.COR_DW_Cape})
sets.engaged.DW.HighAcc.MaxHastePlus = set_combine(sets.engaged.DW.HighAcc.MaxHaste, {back=gear.COR_DW_Cape})
sets.engaged.DW.STP.MaxHastePlus = set_combine(sets.engaged.DW.STP.MaxHaste, {back=gear.COR_DW_Cape})

-- Hybrid sets
sets.engaged.Hybrid = {
	head="Malignance Chapeau", 	-- 6
	--neck="Loricate Torque +1",	-- 6
    hands="Malignance Gloves",	-- 5
	body="Malignance Tabard",	-- 9
    ring1="Defending Ring",		--10
    legs="Malignance Tights",	-- 7
    feet="Malignance Boots"		-- 4
	-- JSE Cap					--10
}								--51 - Capped with 10 PDT off JSE cape and shell

sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
sets.engaged.DW.LowAcc.DT = set_combine(sets.engaged.DW.LowAcc, sets.engaged.Hybrid)
sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)
sets.engaged.DW.STP.DT = set_combine(sets.engaged.DW.STP, sets.engaged.Hybrid)

sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
sets.engaged.DW.LowAcc.DT.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.Hybrid)
sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)
sets.engaged.DW.STP.DT.LowHaste = set_combine(sets.engaged.DW.STP.LowHaste, sets.engaged.Hybrid)

sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
sets.engaged.DW.LowAcc.DT.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.Hybrid)
sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)
sets.engaged.DW.STP.DT.MidHaste = set_combine(sets.engaged.DW.STP.MidHaste, sets.engaged.Hybrid)

sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
sets.engaged.DW.LowAcc.DT.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.Hybrid)
sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)
sets.engaged.DW.STP.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste.STP, sets.engaged.Hybrid)

sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
sets.engaged.DW.LowAcc.DT.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.Hybrid)
sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)
sets.engaged.DW.STP.DT.MaxHaste = set_combine(sets.engaged.DW.STP.MaxHaste, sets.engaged.Hybrid)

sets.engaged.DW.DT.MaxHastePlus = set_combine(sets.engaged.DW.MaxHastePlus, sets.engaged.Hybrid)
sets.engaged.DW.LowAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.LowAcc.MaxHastePlus, sets.engaged.Hybrid)
sets.engaged.DW.MidAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.MidAcc.MaxHastePlus, sets.engaged.Hybrid)
sets.engaged.DW.HighAcc.DT.MaxHastePlus = set_combine(sets.engaged.DW.HighAcc.MaxHastePlus, sets.engaged.Hybrid)
sets.engaged.DW.STP.DT.MaxHastePlus = set_combine(sets.engaged.DW.STP.MaxHastePlus, sets.engaged.Hybrid)    

sets.buff.Doom = {waist="Gishdubar Sash"}
sets.Obi = {waist="Hachirin-no-Obi"}
sets.MBbonus = {feet="Chasseur's Bottes +1"}


sets.TreasureHunter = {
	head=gear.Herc_TH_head, -- 2
	body="Volte Jupon",		-- 2
}

-- Orgnizer set
organizer_items = {
	-- Weapons
	dagger1="Kustawi +1",
	dagger2="Tauret",
	dagger3="Blurred Knife +1",
	shield="Nusku Shield",
	sword1="Naegling",
	gun1="Fomalhaut",
	gun2="Compensator",
	gun3="Anarchy +2",
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
	eobi="Hachirin-No-Obi",
	--shihei="Shihei",
	cards="Trump Card",
	cardcase="Trump Card Case",
	obulletpouch="Orichalcum Bullet Pouch",
	cape1=gear.COR_TP_Cape,
	cape2=gear.COR_DW_Cape,
	-- Temporary items to be added to sets when fully augmented
	temp1="Lanun Knife",
	temp2="Commodore Charm +1",
	
}