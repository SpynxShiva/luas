
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false

	include('Mote-TreasureHunter')
	
	-- Mappings for gear sets to use for various blue magic spells.
    blue_magic_maps = {}
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{'Bilgestorm'}

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{'Heavy Strike'}

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{'Bludgeon'}

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{'Final Sting'}

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Subduction','Tem. Upheaval','Water Bomb','Searing Tempest',
		'Blinding Fulgor','Spectral Floe','Scouring Spate','Anvil Lightning','Silent Storm',
		'Entomb','Tenebral Crush'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{'Thermal Pulse'}

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn','Silent Storm'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool','Occultation'
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar',
        'Pyric Bulwark','Thunderbolt','Tourbillion','Uproot','Mighty Guard', 'Cruel Joke'
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('STP','Normal','MidAcc','HighAcc')
    state.HybridMode:options('Normal', 'DT','Refresh')
	state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
	
	-- Toggles
	state.MagicBurst = M(false, 'Magic Burst')
	send_command('bind ^m gs c toggle MagicBurst')
	
	state.HasteMode = M{['description']='Haste Mode', 'Haste II', 'Haste I'}
	send_command('bind @h gs c cycle HasteMode')
    
	state.DropHP = M(false, 'Drop HP')
	send_command('bind @h gs c toggle DropHP')
	
	-- Weapon sets
	state.WeaponSets = M{['description']='Weapon set', 'Standard', 'Magic', 'Savage'}
	WeaponSetsGear = { 
		["Standard"] = {main="Tizona",sub="Almace"},
		["Magic"] = {main="Nibiru Cudgel",sub="Nibiru Cudgel"},
		["Savage"] = {main="Sequence",sub=gear.Colada_SB},
	}
	
	send_command('bind ^- gs c cycleback WeaponSets')
	send_command('bind ^= gs c cycle WeaponSets')
	
	select_default_macro_book()
	set_lockstyle()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^m')
	send_command('unbind ^c')
	send_command('unbind @h')
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    sets.buff['Chain Affinity'] = {feet="Assimilator's Charuqs +1"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
    sets.buff.Enchainment = {body="Luhlaza Jubbah +1"}
    sets.buff.Efflux = {legs="Mavi Tayt +2"}
    
	sets.TreasureHunter = {waist="Chaac Belt"}
	
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
	
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Jukukik Feather",
        head=gear.Adhemar_TP_head,
		neck="Fotia Gorget",
		ear1="Mache Earring +1",
		ear2="Mache Earring +1",
        body=gear.Herc_CDC_body,
		hands=gear.Herc_CDC_hands,
		ring1="Begrudging Ring",
		ring2="Epona's Ring", 
        back=gear.BLU_CDC_Cape,
		waist="Fotia Belt",
		legs="Samnuha Tights",
		feet="Thereoid Greaves"
	}
    
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,{
		ammo="Mantoptera Eye",
        head=gear.Herc_SB_head,
		neck="Caro Necklace",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
        body="Assimilator's Jubbah +3",
		hands="Jhakri Cuffs +2",
		ring1="Karieyh Ring +1",
		ring2="Epaminondas's Ring",
        back=gear.BLU_SB_Cape,
		waist="Prosilio Belt +1",
		legs="Luhlaza Shalwar +3",--gear.Herc_SB_legs,
		feet=gear.Herc_SB_feet
	})
	
	sets.precast.WS['Savage Blade'].Acc=set_combine(sets.precast.WS['Savage Blade'],{
		waist="Grunfeld Rope"
	})
	
	sets.precast.WS["Savage Blade"].FullTP = set_combine(sets.precast.WS["Savage Blade"],{
		ear1="Odnowa Earring +1"
	})

	sets.precast.WS['Expiacion'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Expiacion'].Acc= sets.precast.WS['Savage Blade'].Acc
	sets.precast.WS["Expiacion"].FullTP = set_combine(sets.precast.WS["Expiacion"],{
		ear1="Odnowa Earring +1"
	})
	
	
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,{
		head="Jhakri Coronal +1",
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
        head=gear.Herc_SB_head,neck="Caro Necklace",ear1="Telos Earring",ear2="Dignitary's Earring",
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
	
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.midcast['Blue Magic'].Magical,{
		head="Pixie Hairpin +1",
		hands="Jhakri Cuffs +2",
		legs="Luhlaza Shalwar +3",
		ring1="Epaminondas's Ring",
		ring2="Archon Ring",
	})
	
	sets.magic_burst = {
									-- MB1	MB2
		body="Samnuha Coat", 		--		8
		hands=gear.Amal_nuke_hands,	--		6
		feet="Jhakri Pigaches +2", 	--	5
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
		neck="Erra Pendant",
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
	
	sets.self_healing_cure_obj = set_combine(sets.self_healing,{
		head="Assim. Keffiyeh +2",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="K'ayres Ring",
		back="Moonbeam Cape",
	})
	
	-- Buff spells
	sets.midcast['Blue Magic'].SkillBasedBuff = {
		-- Base						--	424
		neck="Incanter's Torque", 	--	10
		body="Assim. Jubbah +3",	--	24
		ring1="Stikini Ring +1",		-- 	5
		ring2="Stikini Ring +1",		--	5
        back="Cornflower Cape",		--	15
		legs="Mavi Tayt +2",		--	15
		feet="Luhlaza Charuqs",		--	6
	}								-- 504
	
	sets.midcast['Blue Magic'].Buff = sets.precast.FC
	
	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {
        head="Amalric Coif +1",
		waist="Emphatikos Rope"
	})
    
	sets.midcast.Aquaveil =  {
		head="Amalric Coif +1",	--	2
		legs="Shedir Seraweels",--	1
		waist="Emphatikos Rope",--	1
	}
	
    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {					-- Refresh
		ammo="Ginsen",				
		head="Rawhide Mask",		-- 1
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
		ammo="Staunch Tathlum +1", 	--    2		  2
		head=gear.Herc_DT_head,		--	  4		  4
		neck="Loricate Torque +1",	--	  6		  6
		ear1="Etiolation Earring", 	--			  3
		ear2="Ethereal Earring",	-- 			  
		body="Ayanmo Corazza +2",	--	  6		  6
		hands=gear.Herc_DT_hands,	--	  6		  4
		ring1="Defending Ring",		--	 10		 10
		ring2="Dark Ring",			--	  6		  4
		waist="Flume Belt +1",		--	  4
		back="Moonbeam Cape",		--	  5 	  5
		legs="Ayanmo Cosciales +2",	--	  5		  5
		feet=gear.Herc_Ref_feet,	--	  2
		
	})								--   56		 49
    sets.idle.Town = set_combine(sets.idle,{})
    sets.latent_refresh = {waist="Fucho-no-obi"}
	
    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle.PDT,{})
    sets.defense.MDT = set_combine(sets.idle.PDT,{})
    sets.Kiting = set_combine(sets.idle,{legs="Carmine Cuisses +1"})

    -- Engaged sets
    
	-- 0 haste - DW req: 49(DW3), 44(DW4)
	sets.engaged  = {
		ammo="Ginsen",				
		head=gear.Adhemar_TP_head,		
		neck="Lissome Necklace", 
		ear1="Suppanomimi", 		-- 5
		ear2="Eabani Earring", 		-- 4
		body=gear.Adhemar_TP_body,	-- 6
		hands=gear.Adhemar_TP_hands,
		ring1="Hetairoi Ring", 		
		ring2="Epona's Ring",
		back=gear.BLU_TP_Cape,
		waist="Reiki Yotai", 		-- 7
		legs="Carmine Cuisses +1", 	-- 6
		feet=gear.Herc_TP_feet
	}								--28
		
    sets.engaged.STP = set_combine(sets.engaged,{
		neck="Ainia Collar",
        ring1="Petrov Ring",
		
	})
		
	sets.engaged.MidAcc = set_combine(sets.engaged,{
		neck="Combatant's Torque",
		waist="Kentarch Belt +1",
		ring1="Ilabrat Ring",
	})
	
	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc,{
		ammo="Honed Tathlum",
		ear1="Telos Earring",
		ear2="Cessance Earring",
		legs="Carmine Cuisses +1",	
		head="Carmine Mask +1",
		ring1="Chirich Ring",
		ring2="Chirich Ring",
		feet=gear.Herc_Acc_feet,
	})
	
	-- 15% haste - DW req: 42(DW3), 37(DW4)
	sets.engaged.LowHaste = set_combine(sets.engaged,{})
	sets.engaged.STP.LowHaste = set_combine(sets.engaged.STP,{
		neck="Ainia Collar",
        ring2="Petrov Ring",
	})
	sets.engaged.MidAcc.LowHaste = set_combine(sets.engaged.LowHaste,{
		neck="Combatant's Torque",
		waist="Kentarch Belt +1",
		ring1="Ilabrat Ring",
	})
	sets.engaged.HighAcc.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste,{
		ammo="Honed Tathlum",
		ear1="Telos Earring",
		ear2="Cessance Earring",
		legs="Carmine Cuisses +1",
		head="Carmine Mask +1",
		ring2="Chirich Ring",
		feet=gear.Herc_Acc_feet,
	})
	
	-- 30% Haste - DW req: 31(DW3), 26(DW4)
	sets.engaged.HighHaste = set_combine(sets.engaged,{
		legs="Samnuha Tights",
	})
	sets.engaged.STP.HighHaste = set_combine(sets.engaged.HighHaste,{
		neck="Ainia Collar",
        ring2="Petrov Ring",
	})
	sets.engaged.MidAcc.HighHaste = set_combine(sets.engaged.HighHaste,{
		head="Dampening Tam",
		ear1="Telos Earring",
		legs="Carmine Cuisses +1",
		neck="Combatant's Torque",
		waist="Kentarch Belt +1",
		ring1="Ilabrat Ring",
	})
	sets.engaged.HighAcc.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste,{
		ammo="Honed Tathlum",
		ear1="Telos Earring",
		ear2="Cessance Earring",
		head="Carmine Mask +1",
		ring2="Chirich Ring",
		legs="Carmine Cuisses +1",
		feet=gear.Herc_Acc_feet,
	})
	
	-- Cap Haste - DW req: 11(DW3), 6(DW4)
	sets.engaged.MaxHaste = set_combine(sets.engaged,{ -- 1202 acc
		ear1="Suppanomimi",		
		ear2="Cessance Earring",
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
	})
	sets.engaged.STP.MaxHaste = set_combine(sets.engaged.MaxHaste,{ -- 1184 acc
		ear1="Telos Earring",
		ear2="Dedition Earring",
		neck="Ainia Collar",
        ring1="Petrov Ring",
		waist="Reiki Yotai",
		legs="Samnuha Tights",
	})
	sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.MaxHaste,{ -- 1286
		head="Dampening Tam",
		ear1="Telos Earring",
		neck="Combatant's Torque",
		legs="Carmine Cuisses +1",
		waist="Kentarch Belt +1",
		ring1="Ilabrat Ring",
	})
	sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste,{ -- 1363
		ammo="Honed Tathlum",
		head="Carmine Mask +1",
		ring2="Chirich Ring",
		feet=gear.Herc_Acc_feet,
	})	
	
	sets.engaged.Refresh = set_combine(sets.engaged,{
		body="Jhakri Robe +2",
		hands=gear.Herc_Ref_hands,
		feet=gear.Herc_Ref_feet
	})
	
    -- Hybrid sets
	sets.engaged.Hybrid = {
		ammo="Staunch Tathlum +1", 	--	2	2
		body="Ayanmo Corazza +2",	--	5	5
		neck="Loricate Torque +1", 	--	6	6
		hands=gear.Herc_DT_hands,	--	6	4
		ring1="Defending Ring", 	-- 10	10
		ring2="Dark Ring",			--	6   4
		legs="Ayanmo Cosciales +2",	--	4	4
	}								-- 39	35
	
	sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    sets.engaged.DT.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.engaged.Hybrid)    
    sets.engaged.STP.DT.LowHaste = set_combine(sets.engaged.STP.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.engaged.Hybrid)    
    sets.engaged.STP.DT.HighHaste = set_combine(sets.engaged.HighHaste.STP, sets.engaged.Hybrid)

    sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)    
    sets.engaged.STP.DT.MaxHaste = set_combine(sets.engaged.STP.MaxHaste, sets.engaged.Hybrid)
	
	
	sets.Ref = {
		body="Jhakri Robe +2",
		hands=gear.Herc_Ref_hands,
		feet=gear.Herc_Ref_feet
	}
	
	sets.engaged.Refresh = set_combine(sets.engaged, sets.Ref)
    sets.engaged.MidAcc.Refresh = set_combine(sets.engaged.MidAcc, sets.Ref)
    sets.engaged.HighAcc.Refresh = set_combine(sets.engaged.HighAcc, sets.Ref)
    sets.engaged.STP.Refresh = set_combine(sets.engaged.STP, sets.Ref)

    sets.engaged.Refresh.LowHaste = set_combine(sets.engaged.LowHaste, sets.Ref)
    sets.engaged.MidAcc.Refresh.LowHaste = set_combine(sets.engaged.MidAcc.LowHaste, sets.Ref)
    sets.engaged.HighAcc.Refresh.LowHaste = set_combine(sets.engaged.HighAcc.LowHaste, sets.Ref)    
    sets.engaged.STP.Refresh.LowHaste = set_combine(sets.engaged.STP.LowHaste, sets.Ref)

    sets.engaged.Refresh.HighHaste = set_combine(sets.engaged.HighHaste, sets.Ref)
    sets.engaged.MidAcc.Refresh.HighHaste = set_combine(sets.engaged.MidAcc.HighHaste, sets.Ref)
    sets.engaged.HighAcc.Refresh.HighHaste = set_combine(sets.engaged.HighAcc.HighHaste, sets.Ref)    
    sets.engaged.STP.Refresh.HighHaste = set_combine(sets.engaged.HighHaste.STP, sets.Ref)

    sets.engaged.Refresh.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.Ref)
    sets.engaged.MidAcc.Refresh.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.Ref)
    sets.engaged.HighAcc.Refresh.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.Ref)    
    sets.engaged.STP.Refresh.MaxHaste = set_combine(sets.engaged.STP.MaxHaste, sets.Ref)
	
	
    sets.Obi = {waist="Hachirin-no-Obi"}
	sets.DarkAffinity = {head="Pixie Hairpin +1",ring1="Archon Ring"}
	
	-- Orgnizer set
	organizer_items = {
			-- Weapons
			sword1="Tizona",
			sword2="Almace",
			sword3="Sequence",
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
			shihei="Shihei",
			rrpin="Reraise Hairpin",
			ref_head="Amalric Coif +1"
	}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)		
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and spell.english == 'Savage Blade' and 
		(
			player.tp > 2750 
		or 
			(player.equipment.main == "Sequence" and player.tp > 2250)
		)
	then
        equip(sets.precast.WS['Savage Blade'].FullTP)
    end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            if spell.english== 'Magic Fruit' then
				if state.DropHP.value then
					add_to_chat(122, 'Self curing to hit 500hp obj')
					equip(sets.self_healing_cure_obj)
				else
					equip(sets.self_healing)
				end
			end
        end
    end
	
	-- MB
	if state.Buff['Burst Affinity'] and spell.skill == 'Blue Magic' and state.MagicBurst.value then
		add_to_chat(122, 'Using MB gear')
		equip(sets.magic_burst)
	end
	
	-- Equip obi is spell matches weather/day
	if spell.skill == 'Blue Magic' and (spell.element == world.weather_element or spell.element == world.day_element) then
		equip(sets.Obi)
	end
	
	-- Equip DarkAffinity if spell is dark based
	if spell.element == 'Dark' and not spell.english == 'Dream Flower' then 
		equip(sets.DarkAffinity)
	end
	
    if spell.english == 'Battery Charge' or spell.name:match('refresh')  then
		equip({head="Amalric Coif +1",waist="Gishdubar Sash"})
	end
	
end


function job_post_aftercast(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
		if not midaction() then
            handle_equipping_gear(player.status)
        end
    elseif state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet  = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
    update_active_abilities()
end

function update_active_abilities()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Efflux'] = buffactive['Efflux'] or false
    state.Buff['Diffusion'] = buffactive['Diffusion'] or false
end

function display_current_job_state(eventArgs)
	
	-- Display MB status
	if state.MagicBurst.value == true then
        add_to_chat(122, 'Magic Burst: [On]')
    elseif state.MagicBurst.value == false then
        add_to_chat(122, 'Magic Burst: [Off]')
    end
	
	if state.WeaponSets.current ~= nil then
		add_to_chat(104, 'Weapons set:'..state.WeaponSets.current)
	end
	
    eventArgs.handled = true
end


-- Function triggered by any state change
function job_state_change(stateField, newValue, oldValue)
    -- Aby proc management
	if state.WeaponSets.current then
        equip(WeaponSetsGear[state.WeaponSets.current])
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()

    -- Gearswap can't detect the difference between Haste I and Haste II
    -- so use winkey-H to manually set Haste spell level.

    -- Haste (buffactive[33]) - 15%
    -- Haste II (buffactive[33]) - 30%
    -- Haste Samba - 5~10%
    -- Honor March - 12~16%
    -- Victory March - 15~28%
    -- Advancing March - 10~18%
    -- Embrava - 25%
    -- Mighty Guard (buffactive[604]) - 15%
    -- Geo-Haste (buffactive[580]) - 30~40%

    classes.CustomMeleeGroups:clear()

    if state.HasteMode.value == 'Haste II' then
        if(((buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604])) or
            (buffactive[33] and (buffactive[580] or buffactive.embrava)) or
            (buffactive.march == 2 and buffactive[604]) or buffactive.march == 3) then
            add_to_chat(122, 'Magic Haste Level: 43%')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ((buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba']) then
            add_to_chat(122, 'Magic Haste Level: 35%')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif ((buffactive[580] or buffactive[33] or buffactive.march == 2) or
            (buffactive.march == 1 and buffactive[604])) then
            add_to_chat(122, 'Magic Haste Level: 30%')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif (buffactive.march == 1 or buffactive[604]) then
            add_to_chat(122, 'Magic Haste Level: 15%')
            classes.CustomMeleeGroups:append('LowHaste')
        end
    else
        if (buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or
            (buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604])) or
            (buffactive.march == 2 and (buffactive[33] or buffactive[604])) or
            (buffactive[33] and buffactive[604] and buffactive.march ) or buffactive.march == 3 then
            add_to_chat(122, 'Magic Haste Level: 43%')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ((buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or
            (buffactive.march == 2 and buffactive['haste samba']) or
            (buffactive[580] and buffactive['haste samba'] ) then
            add_to_chat(122, 'Magic Haste Level: 35%')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif (buffactive.march == 2 ) or
            ((buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            (buffactive[580] ) or  -- geo haste
            (buffactive[33] and buffactive[604]) then
            add_to_chat(122, 'Magic Haste Level: 30%')
            classes.CustomMeleeGroups:append('HighHaste')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            add_to_chat(122, 'Magic Haste Level: 15%')
            classes.CustomMeleeGroups:append('LowHaste')
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(2, 7)
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 11')
end
