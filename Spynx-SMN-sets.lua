--Table of Contents
--You can search the file for the #'s to aid in search, ex. Ctrl + F, input #11 to find the midcast section which contains healing, stoneskin, etc
--#1 Staves
--#2 Augmented Items & JSE Cape
--#3 Magical Pacts
--#4 Ward Pacts
--#5 Physical Pacts
--#6 Hybrid Pacts
--#7 Toggled/Situational Sets 
--#8 Job Abilities
--#9 Fast Cast
--#10 Weapon Skills
--#11 Midcast Sets
--#12 Idle/DT Sets
--#13 Perp Sets
--#14 Avatar Melee/DT Sets
--#15 Engaged Sets 

--[#1 Staves ]--
gear.SMN_mab_staff = "Espiritus"
gear.SMN_skill_staff = "Espiritus"
gear.SMN_phys_staff = { name="Gridarvor", augments={'Pet: Accuracy+70','Pet: Attack+70','Pet: "Dbl. Atk."+15',}}

--[#2 Augmented Items & JSE Cape ]--
gear.SMN_skill_Cape = "Conveyance Cape"
gear.SMN_phys_Cape  = "Campestres's Cape"
gear.SMN_mab_Cape = gear.SMN_phys_Cape
gear.SMN_idle_Cape=gear.SMN_phys_Cape
gear.SMN_FC_Cape="Swith Cape +1"
gear.SMN_TPBONUS_legs = "Enticer's Pants"

--[#3 Magical Pacts ]--
sets.petmab = { 
	main=gear.SMN_mab_staff,
    sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head={ name="Helios Band", augments={'Pet: Attack+26 Pet: Rng.Atk.+26','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+6',}},
    body="Con. Doublet +2",
	hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Blood Pact Dmg.+10','Pet: STR+8',}},
    legs= "Apogee Slacks +1",
    feet= "Helios Boots",
    neck="Adad Amulet",
    waist="Regal Belt",
    ear1="Gelos Earring",
    ear2="Lugalbanda Earring",
    ring1="Varar Ring +1",
    ring2="Varar Ring +1",
    back=gear.SMN_mab_Cape
}
sets.petmabacc = set_combine(sets.petmab,{})
sets.pethybridacc = set_combine(sets.petmab,{})

--[#4 Ward Pacts ]--
--Max out Summoning Magic Skill
sets.smnskill = { 
	main=gear.SMN_skill_staff,
	sub="Elan Strap +1",
	ammo="Sancus Sachet +1",	
	head="Convoker's Horn +1",	--15
	body="Anhur Robe",			--12
	hands="Lamassu Mitts +1",	--22
	legs="Assiduity pants +1",	
	feet="Apogee Pumps",
	neck="Incanter's Torque",	--10
	waist="Kobo Obi",			-- 8
	ear1="Cath Palug Earring",	-- 5
	ear2="Andoaa earring",		-- 5
	ring1="Stikini Ring +1",		-- 5
	ring2="Stikini Ring +1",		-- 5
	back=gear.SMN_skill_Cape	--11
}
sets.midcast.Pet.BloodPactWard = {} -- Any override from sets.smnskill
sets.midcast.Pet.BloodPactWard = set_combine(sets.smnskill,sets.midcast.Pet.BloodPactWard)
sets.ward = sets.midcast.Pet.BloodPactWard

-- Tp bonus and HP+ gear, SMN skill doesn't matter
sets.midcast.Pet.HealingWard = {}
sets.healingward = sets.midcast.Pet.HealingWard
sets.midcast.Pet.TPBloodPactWard = set_combine(sets.smnskill,{legs=gear.SMN_TPBONUS_legs,})

sets.midcast.Pet.DebuffBloodPactWard = { -- Override smnskill, add SMN skill and avatar magic accuracy
	neck="Adad Amulet",
	waist="Incarnation Sash",
	back=gear.SMN_mab_Cape,
}
sets.midcast.Pet.DebuffBloodPactWard = set_combine(sets.smnskill,sets.midcast.Pet.DebuffBloodPactWard)
sets.debuff = sets.midcast.Pet.DebuffBloodPactWard

--[#5 Physical Pacts ]--
sets.midcast.Pet.PhysicalBloodPactRage = { --does physical damage only, like pred claws and spinning dive and volt strike
	main=gear.SMN_phys_staff,
    sub="Elan Strap +1",
    ammo="Sancus Sachet +1",
    head={ name="Helios Band", augments={'Pet: Attack+26 Pet: Rng.Atk.+26','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+6',}},
    body="Convoker's Doublet +3",
	hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Blood Pact Dmg.+10','Pet: STR+8',}},
    legs="Apogee Slacks +1",
    feet="Helios Boots",
    neck="Shulmanu Collar",
    waist="Incarnation Sash",
    ear1="Gelos Earring",
    ear2="Lugalbanda Earring",
    ring1="Cath Palug ring",
    ring2="Varar Ring +1",
    back=gear.SMN_phys_Cape
}
sets.physicalpact = sets.midcast.Pet.PhysicalBloodPactRage
sets.midcast.Pet.PhysicalBloodPactRageAcc = set_combine(sets.midcast.Pet.PhysicalBloodPactRage,{})
sets.midcast.Pet.TPPhysicalBloodPactRage = set_combine(sets.midcast.Pet.PhysicalBloodPactRage,{legs=gear.SMN_TPBONUS_legs})
sets.midcast.Pet.TPPhysicalBloodPactRageAcc = set_combine(sets.midcast.Pet.PhysicalBloodPactRageAcc,{legs=gear.SMN_TPBONUS_legs})

--[#6 Hybrid Pacts ]--
sets.midcast.Pet.HybridBloodPactRage = set_combine(sets.midcast.Pet.PhysicalBloodPactRage,{ -- Flaming Crush set
	main=gear.SMN_mab_staff,
	feet="Apogee Pumps",
	neck="Adad Amulet",
	waist="Regal Belt"
})
sets.hybridpact = sets.midcast.Pet.HybridBloodPactRage
sets.midcast.Pet.HybridBloodPactRageAcc = set_combine(sets.midcast.Pet.HybridBloodPactRage,{})

sets.midcast.Pet.MagicalBloodPactRage = set_combine(sets.midcast.Pet.PhysicalBloodPactRage,{ --At this time is only your flaming crush set
	main="Espiritus",
	feet="Apogee Pumps",
	neck="Adad Amulet"
})

sets.midcast.Pet.MagicalBloodPactRage = set_combine(sets.petmab,sets.midcast.Pet.MagicalBloodPactRage)
sets.midcast.Pet.MagicalBloodPactRageAcc = set_combine(sets.midcast.Pet.MagicalBloodPactRage,sets.petmabacc)
sets.midcast.Pet.TPMagicalBloodPactRage = set_combine(sets.petmab,{legs=gear.SMN_TPBONUS_legs})
sets.midcast.Pet.TPMagicalBloodPactRageAcc = set_combine(sets.midcast.Pet.TPMagicalBloodPactRage,sets.petmabacc)
sets.midcast.Pet.IfritMagicalBloodPactRage = sets.midcast.Pet.MagicalBloodPactRage
sets.midcast.Pet.IfritMagicalBloodPactRageAcc = set_combine(sets.midcast.Pet.IfritMagicalBloodPactRage,sets.petmabacc)
sets.magicalpact = sets.midcast.Pet.MagicalBloodPactRage

sets.midcast.BloodPactWard = sets.smnskill

--[#7 Toggled/Situational Sets ]--
sets.latent_refresh = {waist="Fucho-no-obi"}

--[ Items To Keep with Organizer ]--
organizer_items = {
	i1="Warp Ring",
	i2="Dim. Ring (Dem)",
	i3="Remedy",
	i4="Echo Drops",
	i5="Akamochi",
	i6="Kusamochi",
	i7="Shiromochi"
}

--[#8 Job Abilities ]--

-- Precast sets to enhance JAs

sets.precast.JA['Astral Flow'] = {}

sets.precast.JA['Mana Cede'] = {}
sets.precast.JA['Elemental Siphon'] = set_combine(sets.smnskill,{})
useall_bp_reduction_gear = true
sets.precast.BloodPactWard = {			-- I (15)	II (10) 	
		main=gear.SMN_skill_staff, 		--			2
		ammo="Sancus Sachet +1", 			-- 			6
		head="Beckoner's Horn +1",		-- 
		body="Convoker's Doublet +3", 	--15
		back=gear.SMN_skill_Cape 		-- 			3
}										--15		11

sets.precast.BloodPactWard = set_combine(sets.smnskill,sets.precast.BloodPactWard)
sets.precast.BloodPactRage = sets.precast.BloodPactWard

sets.burstmode = {}
sets.burstmode.Burst = {}

--[#9 Fast Cast ]--

-- Fast cast sets for spells
sets.precast.FC = {					--FC	QM
	--	/RDM						--15
	main="Oranyan",					-- 7
	sub="Elan Strap +1",
	ammo="Impatiens",				--  	2
	head=gear.Merl_FC_head,			--13	
	neck="Orunmila's Torque",		-- 5
	left_ear="Etiolation Earring",	-- 1
	right_ear="Loquacious earring",	-- 2
	body="Anhur Robe", 				--10
	ring1="Kishar Ring",			-- 4
	ring2="Prolix Ring",			-- 2
	back="Perimede Cape",			--		4
	waist="Witful belt", 			-- 3	3
	legs="Psycloth Lappas", 		-- 7
	feet=gear.Merl_FC_feet,			--11
}									--80	9


sets.precast.Interrupt = {
	main="Bolelabunga",
	sub="Culminus",				--10
	ammo="Impatiens",			--10
	hands="Amalric Gages +1",	--11
	ear1="Halasz Earring",		--5
	ring1="Evanescence Ring",	-- 5
	feet="Amalric Nails +1",	--15
	waist="Emphatikos Rope",	--12
}
								
--[#10 Weapon Skills ]--
-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
-- Default set for any weaponskill that isn't any more specifically defined
sets.precast.WS = {}
sets.precast.PhysicalWS = {}
sets.precast.WS = sets.precast.PhysicalWS

sets.precast.WS['Myrkr'] = {
	ammo="Sancus Sachet +1",
	head="Pixie Hairpin +1",neck="Orunmila's Torque",ear1="Gifted Earring",ear2="Etiolation Earring",
	body="Weather. Robe +1",hands="Bokwus Gloves",ring1="Mephitas's Ring",ring2="Mephitas's Ring +1",
	back=gear.SMN_skill_Cape,waist="Shinjutsu-No-Obi +1",legs="Amalric Slops",feet="Apogee Pumps",
}

sets.precast.MagicalWS = {}
sets.precast.WS['Flash Nova'] = set_combine(sets.precast.MagicalWS, {})
sets.precast.WS['Rock Crusher'] = set_combine(sets.precast.MagicalWS, {})
sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.MagicalWS, {})
sets.precast.WS['Cataclysm'] = set_combine(sets.precast.MagicalWS, {})
sets.precast.WS['Shining Strike'] = set_combine(sets.precast.MagicalWS, {})
sets.precast.WS['Garland of Bliss'] = set_combine(sets.precast.MagicalWS, {})


--[#11 Midcast Sets ]--
-- Potency: 10% (HEAD) + 5(EAR2) + 15% (BODY) + 10 (HANDS) + 10 (LEGS) + 9 FEET = 59%
-- Received: 5% (RING1) + 4 (neck) +7 (hands) + 10 (waist)= 26% (4% under cap)
sets.midcast.Cure = {				--	CP		CPR
	head="Gendewitha caubeen +1",	--	10	
	neck="Phalaina Locket",			--	4		4
	ear2="Mendi. Earring",			--	5
	body="Vrikodara Jupon",			--	13
	hands=gear.Telchine_CPR_hands,	--	10		7
	ring1="Kunaji Ring",			--			5
	ring2="Asklepian Ring",			--			3
	waist="Gishdubar Sash",			--			10
	legs="Gyve Trousers",			--	10
	feet="Medium's sabots"			--	9
} 									--	61		29		

sets.midcast.CureAurora = {--When you are SCH subjob and cast aurorastorm it will use these items for much more potent Cure 3
	waist="Hachirin-No-Obi",
	back="Twilight Cape",
}
sets.midcast.CureAurora = set_combine(sets.midcast.Cure,sets.midcast.CureAurora)

sets.midcast.CureSelf = set_combine(sets.midcast.Cure,{})
sets.midcast.CureSelfAurora = set_combine(sets.midcast.Cure,sets.midcast.CureAurora)

sets.midcast.Weather = {
	back="Twilight Cape"
}
sets.midcast['Summoning Magic'] = sets.midcast.BloodPactWard

sets.midcast.Cursna = {}          
sets.midcast.CursnaSelf = {	waist="Gishdubar Sash",}
sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna,sets.midcast.CursnaSelf)

sets.midcast['Enhancing Magic'] = {
	main="Gada",
	sub="Ammurapi Shield",
	neck="Incanter's Torque",
	head=gear.Telchine_enh_head,
	body=gear.Telchine_enh_body,
	hands=gear.Telchine_enh_hands,
	legs=gear.Telchine_enh_legs,
	feet=gear.Telchine_enh_feet,
	left_ear="Etiolation Earring", 
	right_ear="Andoaa earring",--+5
	waist="Shinjutsu-no-obi +1",
	back="Perimede Cape",
	left_ring={name="Mephitas's Ring +1",priority=3},
	right_ring={name="Mephitas's Ring",priority=3},
}
sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{})

sets.midcast.Stoneskin = {
	neck="Nodens Gorget", 		-- 30
	waist="Siegel Sash",		-- 20
	legs="Shedier Seraweels", 	-- 35
}
--350  + 80 = 430 hp
sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],sets.midcast.Stoneskin)

sets.midcast.Refresh = {
	head="Amalric Coif +1",
	waist="Gishdubar Sash",
}

sets.midcast.Phalanx = {
	head="Befouled Crown",
	neck="Incanter's Torque",--+10
	ear2="Andoaa earring",	 --+5
	ring1="Stikini Ring +1",
	ring2="Stikini Ring +1"
}

sets.midcast.RefreshSelf = {
	waist="Gishdubar Sash",
}
sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
	main="Vadose Rod",		--	1
	sub="Ammurapi Shield",
	head="Amalric Coif +1",	--	2
	legs="Shedir Seraweels",--	1
	waist="Emphatikos Rope",--	1
})
sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],sets.midcast.Refresh)
sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'],sets.midcast.Phalanx)
sets.midcast.Refresh = set_combine(sets.midcast.Refresh,sets.midcast.RefreshSelf)


sets.midcast['Enfeebling Magic'] = {
	main=gear.Grio_enf,
	sub="Enki Strap",
	ammo="Pemphredo Tathlum",
	head="Amalric Coif +1",
	body=gear.Merl_nuke_body,
	hands=gear.Amal_nuke_hands,
	legs="Psycloth Lappas",
	feet=gear.Merl_nuke_feet,
	neck="Incanter's Torque",
	waist="Luminary Sash",
	left_ear="Regal Earring",
	right_ear="Digni. Earring",
	left_ring="Stikini Ring +1",
	right_ring="Stikini Ring +1",
	back="Izdubar Mantle"
}

sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

sets.precast.FC['Dispelga'] = set_combine(sets.precast.FC,{main="Daybreak"})
sets.midcast["Dispelga"] = set_combine(sets.midcast['Enfeebling Magic'],{main="Daybreak"})



sets.midcast.interruption = sets.precast.Interrupt

--[#12 Idle/DT sets ]--

-- Resting sets
sets.resting = {
	main="Chatoyant Staff",
	sub="Enki Strap",
	waist="Fucho-no-obi",
	legs="Assiduity pants +1",
}

sets.idlekeep = {
	hands="Asteria Mitts +1",
}

-- Idle sets
sets.idle = {
	main="Daybreak",
	sub="Genmei Shield",
	ammo="Staunch Tathlum +1",
	head="Beckoner's Horn +1",
	body="Shomonjijoe +1",
	hands="Asteria Mitts +1",
	legs="Assiduity pants +1",
	feet="Apogee Pumps",
	neck="Loricate Torque +1",
	waist="Fucho-no-Obi",
	ear1="Cath Palug Earring",
	ear2="Genmei Earring",
	ring1="Stikini Ring +1",
	ring2="Stikini Ring +1",
	back="Moonbeam Cape",
}

sets.damagetaken = {}

sets.damagetaken.None = {}
sets.damagetaken.DT = {
	main="Mafic Cudgel", 		--10
	sub="Genmei Shield", 		--10
	neck="Loricate Torque +1",	-- 6
	ring1="Defending Ring", 	--10
	ring2="Gelatinous Ring +1", -- 7
	back="Moonbeam Cape",		-- 5
}

sets.magiceva = {}

sets.petdamagetaken = {}
sets.petdamagetaken.DT = {
	neck="Empath Necklace",
	ear1="Handler's Earring +1",--4PDT
	ear2="Handler's Earring",	--3PDT
	legs="Psycloth Lappas",		--4
	back=gear.SMN_idle_Cape,
}

sets.petdamagetaken.Full = sets.petdamagetaken.DT

sets.precast.FC.PDT = set_combine(sets.precast.FC, sets.damagetaken.PDT)
sets.idle.PDT = set_combine(sets.idle,sets.damagetaken.PDT )

--[#13 Perp Sets ]--
sets.idle.Avatar = set_combine(sets.idle,{ 
	main="Gridarvor",
	sub="Elan Strap +1",
	ammo="Sancus Sachet +1",
	head="Beckoner's Horn +1",
	body="Shomonjijoe +1",
	hands="Asteria Mitts +1",
	legs="Assiduity pants +1",
	feet="Apogee Pumps",
	neck="Caller's Pendant",
	waist="Lucidity Sash",
	ear1="Cath Palug Earring",
	ear2="Evans earring",
	ring1="Defending Ring",
	ring2="Evoker's Ring",
	back=gear.SMN_idle_Cape,
})

sets.favor= set_combine(sets.idle.Avatar,{
	neck="Caller's Pendant",
	ring1="Stikini Ring +1"
})
sets.favor.mpsaver=sets.favor
sets.favor.allout=set_combine(sets.idle.Avatar,{
	ring1="Stikini Ring +1",
	ring2="Stikini Ring +1",
	back=gear.SMN_skill_Cape
})

sets.idle.Spirit = set_combine(sets.midcast.Pet.BloodPactWard, {})
sets.perp = sets.idle.Avatar
sets.engaged = sets.perp 
sets.engaged.Perp = sets.perp
sets.idlehealer = sets.idle

sets.perp.Weather = {}
sets.perp.Carbuncle = set_combine(sets.perp, {hands="Asteria Mitts +1"})
sets.perp['Cait Sith'] = set_combine(sets.perp, {hands="Lamassu Mitts +1"})

--[#14 Avatar Melee/DT Sets ]--
sets.Avatar = {}
sets.Avatar.Haste = set_combine(sets.idle.Avatar,{ --Warning! This set equipped whenever your pet is engaged, even if you aren't
})
sets.Avatar.Haste.Full = {}

--[#15 Engaged Sets ]--
sets.engaged.Melee = sets.idle
