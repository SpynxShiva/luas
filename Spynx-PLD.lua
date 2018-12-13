require 'organizer-lib'
---------------------------------------------------------------------------------------------------------------------------------------
-------------------------------- Initialization function that defines sets and variables to be used -----------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
 
-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end

 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Acc','DW','SW')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal')
	state.IdleMode:options('Normal', 'Refresh')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.CastingMode:options('Normal', 'DT','SID')
	
	state.WeaponLock =false
	state.DropHP = false
	send_command('bind ^c gs c toggle DropHP')
	send_command('bind !l gs c toggle WeaponLock')
    
	select_default_macro_book()
end

 function user_unload()
	send_command('unbind ^=')
	send_command('unbind ^c')
	send_command('unbind !l')
end
-- Define sets and vars used by this job file.
function job_setup()

end

function init_gear_sets()
	--------------------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------------------Precast sets-----------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------------------------

	--------------------------------
    --- JA Precast
    --------------------------------
    sets.precast.JA['Invincible'] = set_combine(sets.precast.JA['Provoke'], {}) -- legs="Cab. Breeches +1"
    sets.precast.JA['Holy Circle'] = set_combine(sets.precast.JA['Provoke'], {feet="Rev. Leggings +1"})
    sets.precast.JA['Shield Bash'] = set_combine(sets.precast.JA['Provoke'], {left_ear="Knightly Earring"}) 
    sets.precast.JA['Intervene'] = sets.precast.JA['Shield Bash']
    sets.precast.JA['Sentinel'] = set_combine(sets.precast.JA['Provoke'], {feet="Caballarius Leggings"}) 
    sets.precast.JA['Rampart'] =  set_combine(sets.precast.JA['Provoke'], {}) -- The amount of damage absorbed is variable, determined by VIT*2
    sets.precast.JA['Fealty'] = set_combine(sets.precast.JA['Provoke'], {}) -- feet="Chev. Sabatons +1"
    sets.precast.JA['Divine Emblem'] = set_combine(sets.precast.JA['Provoke'], {}) -- feet="Chev. Sabatons +1"
	sets.precast.JA['Cover'] = set_combine(sets.precast.JA['Rampart'], {}) -- 15 + min(max(floor((user VIT + user MND - target VIT*2)/4),0),15)
    
	sets.precast.JA['Chivalry'] = {} -- add MND for Chivalry
	
	-- Active buffs
	sets.buff['Rampart'] = {}
    sets.buff['Cover'] = {body="Cab. Surcoat +1"}
	
	------------------------ Sub WAR ------------------------ 
	sets.precast.JA['Provoke'] =  {							--    ENM		HP
		main={name="Burtgang",				priority=11},	--	  18
		sub={name="Ajax +1",				priority=10},	--	  11		80
		ammo={name="Egoist's Tathlum",		priority=9},	--				45
		head={name="Loess Barbuta +1",		priority=0},	--   9-14	   105
		neck={name="Unmoving Collar +1",	priority=12},	-- 	   10		
		ear1={name="Cryptic Earring",		priority=8},	--		4	    40
		ear2={name="Odnowa Earring +1",		priority=7},	--			   100
		body=gear.Souv_tank_body,							--     17	   146
		hands= gear.Yorium_enm_hands,						--	   11       29
		ring1={name="Apeile Ring",			priority=15},	--	  5-9		
		ring2={name="Apeile Ring +1",		priority=14},	--    5-9		
		back={name=enmity_cape,				priority=5},	--	   10		60
		waist={name="Creed Baudrier",		priority=13},	--	    5		40
		legs={name=gear.Souv_tank_legs, 	priority=3},	--	    7	   137
		feet={name="Eschite Greaves",		priority=2},	--	   15		98
	}														--109-122	   935
	
	sets.precast.JA['Warcry'] = sets.precast.JA['Provoke'] 
    sets.precast.JA['Defender'] = sets.precast.JA['Provoke']
	
	------------------------ Sub DNC ------------------------ 
    sets.precast.Waltz = {} -- Waltz set (chr and vit)
	
    sets.precast.Step = sets.precast.JA['Provoke']
    sets.precast.Flourish = sets.precast.JA['Provoke']
     
    ------------------------ Sub RUN ------------------------ 
    sets.precast.JA['Ignis'] = sets.precast.JA['Provoke']   
    sets.precast.JA['Gelus'] = sets.precast.JA['Provoke'] 
    sets.precast.JA['Flabra'] = sets.precast.JA['Provoke'] 
    sets.precast.JA['Tellus'] = sets.precast.JA['Provoke']  
    sets.precast.JA['Sulpor'] = sets.precast.JA['Provoke'] 
    sets.precast.JA['Unda'] = sets.precast.JA['Provoke'] 
    sets.precast.JA['Lux'] = sets.precast.JA['Provoke']     
    sets.precast.JA['Tenebrae'] = sets.precast.JA['Provoke'] 
    
	sets.precast.JA['Vallation'] = sets.precast.JA['Provoke'] 
    sets.precast.JA['Pflug'] = sets.precast.JA['Provoke'] 
          
    -------------------------------------
	---- Magic Precast
	-------------------------------------
	-- FC Cap: 80% - HP variation 979-902=77
	sets.precast.FC = { 	  						 		--	 HP		FC		PDT		MDT
		main={name="Vampirism",				priority=12},	--			 7
		ammo={name="Egoist's Tathlum",		priority=11},	--   45 	 						   
		head={name="Carmine Mask +1",		priority=0},	--	 38		12		 
		neck={name="Orunmila's Torque",		priority=10},	--			 5
		body={name="Reverence Surcoat +3",	priority=15},	--	254 	10		 11		 11
		ring2={name="Moonlight Ring",		priority=9},	--  100
		ring1={name="Kishar Ring",			priority=8},	--   		 4
		sub={name="Nibiru Shield",			priority=13},	--	 80		 7
		ear1={name="Odnowa Earring",		priority=15},	--	100		 				  1
		ear2={name="Odnowa Earring +1",		priority=14},	--  110		 				  2
		hands=gear.Souv_tank_hands,							--  134	  			  4		  5	
		waist={name="Creed Baudrier",		priority=6}, 	--	 40		
		back=gear.PLD_FC_Cape,								--   60		10
		legs={name="Odyssean Cuisses",		priority=2},    --	 54		 5
		feet=gear.Ody_FC_feet,								--	 20     10 
	}											 			-- 1035		69		 15		 19
	
	-- HP variation 979-982 = +3
	sets.precast.FC.DT = {									--	 HP		FC		PDT		MDT
		main={name="Burtgang",				priority=15},	--	 		 	   (18)
		ammo={name="Egoist's Tathlum",		priority=14},	--   45 	 						   
		head={name="Loess Barbuta +1",		priority=0},	--	105    		 	 10		 10
		neck={name="Loricate Torque +1",	priority=13},	--					  6		  6
		body={name="Reverence Surcoat +3",	priority=15},	--	254 	10		 11		 11
		ring2={name="Moonlight Ring",		priority=11},	--  100		 		  4		  4
		ring1={name="Defending Ring",		priority=10}, 	--   				 10		 10
		sub={name="Nibiru Shield",			priority=9},	--	 80		 7
		ear2={name="Odnowa Earring +1",		priority=8},	--  100		 				  2
		ear1={name="Odnowa Earring",		priority=7},	--	100		 				  1
		hands=gear.Souv_tank_hands,							--  134	  			  3		  4	
		waist={name="Creed Baudrier",		priority=5},	--	 40		
		back=gear.PLD_FC_Cape,								--   60		10
		legs=gear.Ody_FC_legs,									--	 54		 5
		feet=gear.Ody_FC_feet,								--	 20     10 
	}														-- 1182		42		 44		 48
	
	sets.precast.FC.LowHP = set_combine(sets.precast.FC,{
		ear1="Loquac. Earring",
		ear2="Etiolation Earring",
		ring1="Defending Ring",
		ring2="Dark Ring",
		hands="Leyline Gloves"
	})
	
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC , {waist="Siegel Sash"})
	sets.precast.FC['Enhancing Magic'].DT = set_combine(sets.precast.FC.DT,{waist="Siegel Sash"})
	
	-- FC Cap: 80% - HP variation 979-902=77
	sets.precast.FC.Cure =  { 	  					 		--	 HP		FC		PDT		MDT
		main={name="Vampirism",				priority=12},	--			 7
		ammo={name="Egoist's Tathlum",		priority=11},	--   45 	 						   
		head={name="Carmine Mask +1",		priority=0},	--	 38		 9		 
		neck={name="Orunmila's Torque",		priority=10},	--			 5
		body={name="Reverence Surcoat +3",	priority=15},	--	254		10		 11		 11
		ring1={name="Meridian Ring",		priority=9},	--   90
		ring2={name="Moonlight Ring",		priority=8},	--	100 			  4		  4
		sub={name="Nibiru Shield",			priority=13},	--	 80		 7
		ear1={name="Odnowa Earring",		priority=15},	--	100		 				  1
		ear2={name="Odnowa Earring +1",		priority=14},	--  110		 				  2
		hands=gear.Souv_tank_hands,							--  134	  			  3		  4	
		waist={name="Creed Baudrier",		priority=6}, 	--	 40		
		back=gear.PLD_FC_Cape,								--   60		10
		legs={name="Odyssean Cuisses",		priority=2},    --	 54		 5
		feet=gear.Ody_FC_feet,								--	 20      8
	}											 			--	912		63		  7	  	 11		   
	
	sets.precast.FC.Cure.DT = sets.precast.FC.DT			--  982			35		 45		 47
	
	-------------------------------------
	---- WS Precast
	-------------------------------------
	sets.precast.WS = {
		ammo="Jukukik Feather",
		head="Valorous Mask",neck="Fotia Gorget",ear1="Brutal Earring",ear2={name="Odnowa Earring +1",priority=10},
		body=dd_body,hands="Valorous Mitts",ring1="Petrov Ring",ring2={name="Meridian Ring",priority=11},
		back=gear.PLD_WS_Cape,waist="Fotia Belt",legs="Sulevi. Cuisses +1",feet="Valorous Greaves"
	}
	
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS,{}) --Stat Modifier:     73~85% MND  fTP:    1.0
    sets.precast.WS['Sanguine Blade'] = { --Stat Modifier:  50%MND / 30%STR MAB+    fTP:2.75
		ammo="Pemphredo Tathlum",
		head="Jumalik Helm",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Found. Breastplate",hands="Founder's Gauntlets", ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Izdubar Mantle",waist="Eschan Stone",legs="Augury Cuisses",feet="Founder's Greaves"
	} 
    sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Sanguine Blade']
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS,{}) --Stat Modifier: 50%MND / 50%STR fTP: 1000:4.0 2000:10.25 3000:13.75
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS,{}) --Stat Modifier:  80%DEX  fTP:2.25
    sets.precast.WS['Atonement'] = set_combine(sets.precast.JA['Provoke'],{
		head="Odyssean Helm",neck="Fotia Gorget",ear1={name="Odnowa Earring",priority=10},ear2={name="Odnowa Earring +1",priority=11},
		hands="Odyssean Gauntlets",
		waist="Fotia Belt",feet="Sulevia's Leggings +1"
	})--Stat Modifier: WS damage/Enmity{
           
    ------------------------------------------------------------------------------------------------
    -----------------------------------------Midcast sets-------------------------------------------
    ------------------------------------------------------------------------------------------------
    
	--------------------------------
    --- Magic Midcast
    --------------------------------
	sets.midcast.FastRecast = sets.precast.FC
	sets.midcast.FastRecast.DT = sets.precast.FC.DT
	
	-- SID set to lose no HP over FC one
	-- Cap: 102% - 10% (merits) = 92%
	sets.midcast.SID =	{							
														--	HP	ENM		PDT		MDT		SID
		-- SIRD merits									--								 10
		ammo={name="Staunch Tathlum +1",	priority=14},	--					 			 10
		main={name="Burtgang",			priority=15},	--		18		(18)
		sub="Ochain",
		head=gear.Souv_tank_head,						-- 280		 	  4      		 20
		neck={name="Moonbeam Necklace", priority=12},	--	 	10						 10	
		ear1={name="Odnowa Earring",	priority=11},	-- 100		 	  		  1
		ear2={name="Odnowa Earring +1",	priority=10},	-- 110		 	  		  2
		body={name="Rev. Surcoat +3",	priority=9},	-- 254 	10	 	 11	 	 11
		hands={name="Eschite Gauntlets",priority=0},	--  29   7 	  		 			 15
		ring1={name="Defending Ring",	priority=1},	--	   		 	 10  	 10		
		ring2={name="Moonlight Ring",	priority=8},	-- 1000		  	  4	  	  4
		back=gear.PLD_tank_Cape,						-- 600	10		  		  
		waist={name="Rumination Sash",	priority=6},	--					 			 10
		legs={name="Founder's Hose",	priority=5},	--  54   			 			 30 		
		feet=gear.Souv_tank_feet						-- 227	 5 
	}													--1058 	34	 	 29	 	 28 	105
	
	
	-- Divine based+merits=420
	sets.midcast.Divine = { 	  						--	 HP		PDT		MDT		DIV
		main={name="Burtgang",			priority=15},	--			(18)			
		ammo={name="Egoist's Tathlum",	priority=14},	--   45 								   
		head={name="Jumalik Helm",		priority=0},	--	 45		  5				20
		neck={name="Incanter's Torque",	priority=13},	--					  		10		  
		body={name="Rev. Surcoat +3",	priority=12},	--	244 	 10		10		17
		ring2={name="Moonlight Ring",	priority=1},	--  100		  4		 4		
		ring1={name="Defending Ring",	priority=2}, 	--   		 10		10	
		sub={name="Nibiru Shield",		priority=11},	--	 80					
		ear2={name="Odnowa Earring +1",	priority=10},	--  100				 2	
		ear1={name="Odnowa Earring",	priority=9},   --	100				 1	
		hands={name="Eschite Gauntlets",priority=3},	--  29		 		 4		20
		waist={name="Asklepian Belt",	priority=4},   	--	 						10		
		back=gear.PLD_FC_Cape,							--   60					
		legs=gear.Souv_tank_legs,						--	137		  3		 3			
		feet=gear.Souv_tank_feet						--	152 			 4 	
	}											 		-- 1072		 32		34 		497
	
	-- Enhancing base+merits: 350
	sets.midcast['Enhancing Magic'] = {					--	 HP		PDT		MDT		ENH
		ammo={name="Egoist's Tathlum",	priority=11},	--   45 	 						
		head={name="Carmine Mask +1",priority=1},		--	 38		 	 			 10 
		neck={name="Incanter's Torque",priority=15},	--							 10
		ear2={name="Odnowa Earring +1",	priority=14},	--  100				 2	
		ear1={name="Odnowa Earring",priority=13}, 		--	100				 1	
		body={name="Rev. Surcoat +3",priority=12},		--	244 	10	     10
		hands={name="Eschite Gauntlets",priority=2},	--  29   	 4
		ring1={name="Defending Ring",priority=3},		--	  		10       10		
		ring2={name="Moonlight Ring",priority=10},		--	100		 4		  4
		back={name="Reiki Cloak",priority=11},			--	130	 	  		  8	    
		waist={name="Rumination Sash",priority=4},		-- 
		legs={name="Carmine Cuisses +1",priority=5},	--	 50						 18
		feet=gear.Souv_tank_feet						--	227		 5 
	}													--	913		32		 34		388	
	
	-- Enhancing base+merits: 350
	sets.midcast['Enhancing Magic'].DT = {				--	 HP		PDT		MDT		ENH
		ammo={name="Egoist's Tathlum",	priority=11},	--   45 	 						
		head={name="Loess Barbuta +1",priority=1},		--	105    	10		 10
		neck={name="Loricate Torque +1",priority=15},	--		     6	  	  6
		ear1={name="Odnowa Earring",priority=14}, 		--	100				 1	
		ear2={name="Odnowa Earring +1",priority=13},	--  100				  2
		body={name="Rev. Surcoat +3",priority=12},		--	254 	11	     11
		hands={name="Eschite Gauntlets",priority=2},	--  109   	 4
		ring1={name="Defending Ring",priority=3},		--	  		10       10		
		ring2={name="Moonlight Ring",priority=11},		--	100
		back={name="Reiki Cloak",priority=10},			--	130	 	  		  8	    
		waist={name="Rumination Sash",priority=4},		-- 
		legs={name="Carmine Cuisses +1",priority=5},	--	 50						 18
		feet=gear.Souv_tank_feet						--	227		 5 
	}													-- 1000		49		 51		368	

	sets.midcast['Blue Magic'] = sets.precast.JA['Provoke']
	sets.midcast['Blue Magic'].DT = sets.midcast.SID
	sets.midcast['Blue Magic'].SID = sets.midcast.SID
	sets.midcast.Utsusemi = sets.midcast.SID
	
    sets.midcast.Flash = set_combine(sets.precast.JA['Provoke'], {})
    sets.midcast.Flash.DT = set_combine(sets.precast.JA['Provoke'], {})
	
    -- Formula: (Divine Magic Skill/8)+12.5 = (495/8)+12.5= 61+12.5=73.5
	sets.midcast.Enlight = sets.midcast.Divine
    sets.midcast['Enlight II'] = sets.midcast.Enlight
    
	sets.midcast.Reprisal =	set_combine(sets.precast.FC,{
		hands="Leyline Gloves",ammo="Sapience Orb",ear1="Loquacious earring"
	}) -- 81FC
     
	 sets.midcast.Reprisal.DT = sets.precast.FC.DT
	 sets.midcast.Reprisal.SID = sets.midcast.Reprisal.DT
	 
	-- Enhancing base+merits: 350
	
	sets.midcast.Phalanx = {							--	 HP		PDT		MDT		ENH		PHA
		main="Deacon Sword",							--	 								4
		sub="Priwen",									--	 80								2
		ammo={name="Staunch Tathlum +1",	priority=0},	--							   		
		head=gear.Ody_phalanx_head,						--	112		 	 		 			3 
		neck={name="Incanter's Torque",	priority=2},	--							 10
		ear1={name="Odnowa Earring",priority=15}, 		--	100				 1	
		ear2={name="Odnowa Earring +1",	priority=14},	--  100				  2
		body={name="Rev. Surcoat +3",	priority=13},	--	254 	11	     11
		hands=gear.Souv_tank_hands,	 					--  199	  	 4		  5				5		
		ring1={name="Defending Ring",	priority=3},	--	  		10       10		
		back={name="Weard Mantle",		priority=4},	--	 40	 	 3 		  3	 			4   
		ring2={name="Moonlight Ring",	priority=12},	--	100		 4		  4
		waist={name="Rumination Sash",	priority=5},	-- 
		legs=gear.Ody_phalanx_legs,						--	 54						 		2
		feet=gear.Souv_tank_feet                        --	227 	 5						5
	}													-- 1236		35		 35		388		25
	
	sets.midcast.Phalanx.DT = {							--	 HP		PDT		MDT		ENH		PHA
		main="Deacon Sword",							--	 								4
		sub="Priwen",									--	 80								2
		ammo={name="Staunch Tathlum +1",	priority=0},	--							   		
		head={name="Loess Barbuta +1",	priority=11},	--	105    	10		 10
		neck={name="Incanter's Torque",	priority=2},	--							 10
		ear1={name="Odnowa Earring",	priority=15}, 	--	100				  1	
		ear2={name="Odnowa Earring +1",	priority=14},	--  100				  2
		body={name="Rev. Surcoat +3",	priority=13},	--	254 	11	     11
		hands=gear.Souv_tank_hands,	 					--  134	  	 3		  4				5		
		ring1={name="Defending Ring",	priority=3},	--	  		10       10		
		back={name="Weard Mantle",		priority=4},	--	 40	 	 3 		  3	 			3   
		ring2={name="Moonlight Ring",	priority=7},	--	100		 4		  4		 
		waist={name="Rumination Sash",	priority=5},	-- 
		legs={name="Carmine Cuisses +1",priority=6},	--	 50						 18
		feet=gear.Souv_tank_feet                        --	152 	 4 				 		4
	}													-- 1014		51		 49		388		11
	
	sets.midcast.Phalanx.SID = sets.midcast.Phalanx.DT
	
    sets.midcast.Banish = sets.precast.WS['Sanguine Blade']
    sets.midcast['Banish II'] = sets.precast.WS['Sanguine Blade']
    sets.midcast.Holy = sets.precast.WS['Sanguine Blade']
    sets.midcast['Holy II'] = sets.precast.WS['Sanguine Blade']
     
	-- CAPS: 50% potency/30% received
	sets.midcast.Cure = {									--	 HP		PDT		MDT		CP		CPR
		sub={name="Nibiru Shield",			priority=15},	--	 80		 6		  6
		ammo={name="Egoist's Tathlum",		priority=11},	--   45 	 						
		head=gear.Souv_tank_head,							--  280		 4
		neck={name="Phalaina Locket",		priority=2},	--							 4		 4			 
		ear1={name="Odnowa Earring",		priority=15}, 	--  100 			  1		 		 
		ear2={name="Odnowa Earring +1",		priority=14},	--  100				  2
		body=gear.Souv_tank_body,							--  146  	 9     	  9		10		10
		hands={name="Macabre Gauntlets +1",	priority=6},	--   49  	 4		  		11		
		back={name="Solemnity Cape",		priority=4},	--	 	 	 4 		  4		 7
		ring2={name="Moonlight Ring",		priority=8},	--  100		 4		  4
		ring1={name="Meridian Ring",		priority=7},	--	 90
		waist={name="Creed Baudrier",		priority=13},	-- 
		legs=gear.Souv_tank_legs,							--	137		 3		  3				17
		feet=gear.Ody_CP_feet								-- 	 20 	 				12		  		  			
	}														-- 1165		34		 29		44		31
		
    sets.midcast.Cure.DT = sets.midcast.Cure
	
	--  30% received:  10%(BODY) + 17% (LEGS) + 5(FEET) = 32% (CAP)
	sets.self_healing = sets.midcast.Cure
	sets.self_healing.DT = set_combine( sets.self_healing, {} )
	
	sets.midcast.Raise = sets.midcast.SID
    
	--Spell interupt down (pro shell raise)	
     ------------------------------------------------------------------------------------------------
    -------------------------------------------Idle sets---------------------------------------------
    -------------------------------------------------------------------------------------------------
	 
    -- Status
	sets.Doom = {waist="Gishdubar Sash"} 
    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
	
    sets.ResistCharm = {}
     
    sets.resting = {}     
    -- Idle sets
    sets.idle = {
		main="Burtgang",ammo="Homiliary",
		head=gear.Souv_tank_head, neck="Vim Torque +1", ear1="Thureous Earring", ear2="Ethereal Earring", 
		body= gear.Souv_ref_body  --[["Reverence Surcoat +3"--]] , hands=gear.Souv_tank_hands, ring1="Defending Ring", ring2="Moonlight Ring",
		back=gear.PLD_tank_Cape, waist="Flume Belt +1", legs="Carmine Cuisses +1", feet=gear.Souv_tank_feet
	}
	
    sets.idle.Refresh = set_combine ( sets.idle,{body="Jumalik Mail"})
	
	sets.idle.Town = sets.idle
	sets.idle.Weak = set_combine(sets.idle,{head="Twilight helm",body="Twilight mail"})
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
	
     
	sets.latent_refresh = {waist="Fucho-no-Obi"}
	 
    sets.defense.PDT = { -- Caps: PDT: 50%; MDT 50% (37.5% with Aegis to reach 87.5%cap)
															--	HP	PDT		MDT		BDT		Enmity	
		main={name="Burtgang",				priority=15},	--		(18)
		sub="Ochain",
		ammo={name="Staunch Tathlum +1",		priority=0},	--		  2		  2		  2		
		head=gear.Souv_tank_head,							-- 280	  4				  7		 	 		 
		neck={name="Creed Collar",			priority=14},
		ear1={name="Thureous Earring",		priority=1},	--  30
		ear2={name="Odnowa Earring +1",		priority=13},	-- 110			  3
		body={name="Reverence Surcoat +3",	priority=15}, 	-- 146	 11		 11		 11		17
		hands=gear.Souv_tank_hands,							-- 199	  4		  5		 	 	
		ring1={name="Defending Ring",		priority=3}, 	--		 10		 10	     10
		ring2={name="Moonlight Ring",		priority=2},	-- 100	  4		  4		  4 
		back=gear.PLD_tank_Cape,							--  60							10		  	
		waist={name="Flume Belt +1",		priority=4}, 	--		  4
		legs=gear.Souv_tank_legs,							-- 162	  4		  4		  4		 9
		feet=gear.Souv_tank_feet							-- 227	  5						 9
		-- Set bonus										--	 	  8		  8		  8
	} 														--1294	 56		 47		 46		41
 
	sets.defense.MDT = set_combine (sets.defense.PDT,{sub="Aegis"})

	--Doom/RR
    sets.buff.Doom = {ring1="Saida Ring", ring2="Purity Ring", waist="Gishdubar Sash"}
	sets.Kiting = {legs="Carmine Cuisses +1"}

 
    --------------------------------------
    -- Engaged sets
    --------------------------------------
    sets.engaged = { -- Capped haste, Capped MDT and PDT (with Aegis and Flyssa)
		ammo="Ginsen",
		head="Flamma Zucchetto +2",neck="Lissome Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body=gear.Valor_STP_body,hands="Sulev. Gauntlets +2",ring1="Flamma Ring",ring2="Hetairoi Ring",
		back=gear.PLD_TP_Cape,waist="Sailfi Belt +1",legs="Sulev. Cuisses +2",feet="Flamma Gambieras +2"
	}

    sets.engaged.Acc = set_combine(sets.engaged,{
		neck="Sanctity Necklace",
		waist="Kentarch Belt +1",
		feet="Sulev. Leggings +1"
	})

	--[[sets.engaged.DW={
		ammo="Ginsen",
		head={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','"Dbl.Atk."+2','STR+3',}},
		body={ name="Valorous Mail", augments={'Accuracy+25 Attack+25','Damage taken-3%',}},
		hands="Sulev. Gauntlets +1",
		legs="Sulevi. Cuisses +1",
		feet={ name="Valorous Greaves", augments={'"Dbl.Atk."+4','Accuracy+7','Attack+4',}},
		neck="Asperity Necklace",
		waist="Reiki Yotai",
		left_ear="Brutal Earring",
		right_ear="Suppanomimi",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back="Bleating Mantle",
	}
	
	sets.engaged.SW={
		ammo="Ginsen",
		head={ name="Valorous Mask", augments={'Accuracy+22 Attack+22','"Dbl.Atk."+2','STR+3',}},
		body={ name="Valorous Mail", augments={'Accuracy+25 Attack+25','Damage taken-3%',}},
		hands="Sulev. Gauntlets +1",
		legs="Sulevi. Cuisses +1",
		feet={ name="Valorous Greaves", augments={'"Dbl.Atk."+4','Accuracy+7','Attack+4',}},
		neck="Asperity Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Petrov Ring",
		right_ring="Rajas Ring",
		back="Bleating Mantle",
	}
	]]--
	
	sets.WakeSleep = {neck="Vim Torque +1"}
	
	-- Organizer items to always have in inventory:
	organizer_items = {
		-- Weapons
		weapon1="Burtgang",
		weapon2="Demersal Degen +1",
		shield1="Aegis",
		shield2="Ochain",
		shield3="Priwen",
		-- Meds
		echos="Echo Drops",
		remedy="Remedy",
		waters="Holy Water",
		-- Food
		mevafood="Miso Ramen",
		deffood="Black Curry Bun",
		-- Utils
		warpr="Warp Ring",
		cpring="Capacity Ring",
		cpring2="Trizek Ring",
		cmantle="Mecisto. Mantle",
	}  
	
	end
------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------Job-specific hooks that are called to process player actions at specific points in time-----------
------------------------------------------------------------------------------------------------------------------------------------------
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
     
    return idleSet
end
 
function customize_defense_set(defenseSet)
    if state.PhysicalDefenseMode.value == 'PDT' and buffactive[403] then
		defenseSet = set_combine(defenseSet, {sub="Priwen"})
	end
    return defenseSet
end
 
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-- General hooks for change events.
-------------------------------------------------------------------------------------------------------------------
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spellMap == 'Cure' and spell.target.type == 'SELF' and state.DropHP then
		equip(sets.precast.FC.LowHP)
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
 
end
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
	
	update_defense_mode()
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    
end
-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    if state.WeaponLock == true then
		disable('main','sub')
	else
		enable('main','sub')
	end
	
	update_defense_mode()
end


function update_defense_mode()
	if state.DefenseMode.value == 'Physical' and buffactive[403] then 
		equip({sub="Priwen"})
	elseif state.DefenseMode.value == 'Physical' then
			equip({sub="Ochain"})
	elseif state.DefenseMode.value == 'Magical'  then
		equip({sub="Aegis"})
	end
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    -- Display DropHP status
	if state.DropHP == true then
        add_to_chat(122, 'DropHP: [On]')
    elseif state.DropHP == false then
        add_to_chat(122, 'DropHP: [Off]')
    end
	
	if state.WeaponLock == true then
        add_to_chat(122, 'WeaponLock: [On]')
    elseif state.WeaponLock == false then
        add_to_chat(122, 'WeaponLock: [Off]')
    end
end

function job_buff_change(buff, gain)
        if buff == "cover" then
                if gain then
                        equip(sets.buff['Cover'])
                        disable('Body')
                else
                        enable('Body')
                        handle_equipping_gear(player.status)
                end
        elseif buff == "doom" then
			if gain then           
				equip(sets.buff.Doom)
				send_command('@input /p Doomed.')
				disable('ring1','ring2','waist')
			else
				enable('ring1','ring2','waist')
				handle_equipping_gear(player.status)
			end
		elseif buff == "petrification" then
			if gain then    
				send_command('@input /p Petrified')		
			end
		elseif buff == "Charm" then
			if gain then  			
				send_command('@input /p Charmed')		
			else	
					send_command('input /p '..player.name..' is no longer Charmed, please wake me up!')
			end
        end
		
		if gain and status == "sleep" then  
			add_to_chat(4,'Swapping in Vim Torque to take you up!')
			equip(sets.WakeSleep)
		elseif not gain and status == "sleep" then
			add_to_chat(4,'Removing Vim Torque')
			handle_equipping_gear(player.status)
		end
		
		update_defense_mode()
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 13)
end

function job_post_midcast(spell, action, spellMap, eventArgs)
  if spellMap == 'Cure' and spell.target.type == 'SELF' then
    if state.CastingMode.value == 'DT' then
      equip(sets.self_healing.DT)
    else
      equip(sets.self_healing)
  end
end
  end

-- Curing rules
function refine_various_spells(spell,action,spell_map,event_args)
 
    local cures = S{'Cure','Cure II','Cure III','Cure IV'}
     
    if cures:contains(spell.english) then
     
        local spell_recasts = windower.ffxi.get_spell_recasts()
         
        if spell_recasts[spell.recast_id] > 0 then
            event_args.cancel = true
             
            if spell.english == 'Cure IV' then
                send_command('@input /ma "Cure III" '..tostring(spell.target.raw))
                return
            elseif spell.english == 'Cure III' then
                send_command('@input /ma "Cure II" '..tostring(spell.target.raw))
                return
            elseif spell.english == 'Cure II' then
                send_command('@input /ma "Cure" '..tostring(spell.target.raw))
                return
            else
                add_to_chat(122,'All Cure spells are on cooldown. Canceling the cast.')
                return
            end
        end     
    end 
end

