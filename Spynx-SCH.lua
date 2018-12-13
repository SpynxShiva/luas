-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.

                                        Light Arts              Dark Arts

        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
	include('sammeh_custom_functions.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	helix_timer = ''
    helix_duration = 234

    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'DT')
    state.CastingMode:options('Normal', 'Resistant','Exp')
    state.IdleMode:options('Normal', 'PDT') -- ,'AntiStun'

    -- Table and variable initialization
	info.low_nukes = S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder"}
    info.mid_nukes = S{"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
                       "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",}
    info.high_nukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
						"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}
	state.MagicBurst = M(false, 'Magic Burst')
	state.SpellUpgrade = M(false, 'SpellUpgrade')
	state.AutoSublimation = M(true, 'AutoSublimation')
	
	state.Skillchain = M{['description']='Skillchain', "Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder", "Dark", "Light"}
	skillChainSpell = {
		["Stone"] = {
			["open"]="Aero",
			["close"]="Stone",
			["name"]="Scission",
			["helix"]="Geohelix II",
		},
		["Water"] = {
			["open"]="Stone",
			["close"]="Water",
			["name"]="Reverberation",
			["helix"]="Hydrohelix II",
		},
		["Aero"]  =	{
			["open"]="Blizzard",
			["close"]="Water",
			["name"]="Fragmentation",
			["helix"]="Anemohelix II",
		},
		["Fire"]  =	{
			["open"]="Fire",
			["close"]="Thunder",
			["name"]="Fusion",
			["helix"]="Pyrohelix II",
		},
		["Blizzard"] = {
			["open"]="Water",
			["close"]="Blizzard",
			["name"]="Induration",
			["helix"]="Cryohelix II",
		},
		["Thunder"] = {
			["open"]="Blizzard",
			["close"]="Water",
			["name"]="Fragmentation",
			["helix"]="Ionohelix II",
		},
		["Dark"] = {
			["open"]="Aero",
			["close"]="Noctohelix",
			["name"]="Gravitation",
			["helix"]="Noctohelix II",
		},
		["Light"] = {
			["open"]="Fire",
			["close"]="Thunder",
			["name"]="Fusion",
			["helix"]="Luminohelix II",
		},
	}
    
	-- Commands binding
	--  ! = alt, ^ = ctrl, @ = windows key, # = menu key/app key
	
	-- Modes toggle
	send_command('bind ^m gs c toggle MagicBurst')
	send_command('bind ^s gs c toggle AutoSublimation')
	send_command('bind ^- gs c cycleback Skillchain')
	send_command('bind ^= gs c cycle Skillchain')
	
	-- Spell
	send_command('bind ^k input /ma Klimaform')
	
	-- JA
	send_command('bind ^p input /ja "Ebullience" <me>')
	send_command('bind ^a gs c scholar aoe')
	send_command('bind ^d gs c scholar duration')
	send_command('bind ^t gs c scholar speed')
	
	
	-- Default gear to be used when no weather/day bonus
	gear.default.obi_waist = "Refoccilation Stone"
	gear.default.obi_ring = "Shiva Ring +1"
	gear.default.obi_back = gear.SCH_nuke_Cape
	
	dark_ring={ name="Dark Ring", augments={'Spell interruption rate down -3%','Phys. dmg. taken -6%','Magic dmg. taken -4%',}}
	
	select_default_macro_book()
	set_lockstyle()
	
	-- Default wait time between spells
	waittime = 2.6
end

function user_unload()
	send_command('unbind ^m')
	send_command('unbind ^s')
	send_command('unbind ^-')
	send_command('unbind ^=')
	send_command('unbind ^k')
	send_command('unbind ^p')
	send_command('unbind ^a')
	send_command('unbind ^d')
	send_command('unbind ^t')
	send_command('unbind ^x')	
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants"}

    -- Fast cast sets for spells

    sets.precast.FC = {				-- FC	QC  GRIM%
        main="Oranyan",				--	7
		sub="Enki Strap", 		
		ammo="Impatiens",			--		 2
		head=gear.Merl_FC_head,		-- 13
		neck="Orunmila's Torque",	--  5
		ear1="Etiolation Earring", 	--  1
		ear2="Loquacious Earring",	--  2
        body="Anhur Robe",			-- 10
		hands="Gendewitha Gages +1",--	7
        back=gear.SCH_FC_Cape,		-- 10
		ring1="Kishar Ring",		--  4
		ring2="Prolix Ring",		--  2
		waist="Witful Belt",		--	3	 3
		legs="Psycloth Lappas",		--	7
		feet="Academic's Loafers +3"-- 			  12
									-- 71	 5	  12
	}												

	-- Cast time: 15% (BODY) + 8% (BACK) = 23%
    sets.precast.FC.Cure = set_combine(sets.precast.FC,{})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	sets.precast.Stoneskin = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	-- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC

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

    sets.midcast.CureWithLightWeather = set_combine(sets.midcast.Cure,{back="Twilight Cape",waist="Hachirin-no-Obi"})

    sets.midcast.Curaga = sets.midcast.Cure

	sets.midcast.Cursna = {waist="Gishdubar Sash",ring1="Purity Ring"}
	
    -- Enhancing magic affects potency for: phalanx, barspells, embrava
    sets.midcast['Enhancing Magic'] = {
		--	Scholar base in LA:		--	404 
		main="Gada",				--	18
		sub="Ammurapi Shield",
		head="Befouled Crown",		-- 	16
		neck="Incanter's Torque",	-- 	10
		body=gear.Telchine_enh_body,--	12
		hands=gear.Chir_ref_hands,	--	15
		ear1="Andoaa Earring",		-- 	5
		ring1="Stikini Ring +1",	--	8
		ring2="Stikini Ring +1",	--	8
		back="Fi Follet Cape +1",	--	9
		waist="Olympus Sash",		-- 5
		legs="Academic's pants +1",	-- 	20
		feet="Kaykaus Boots",		--	20		
									-- 550
	}							
	
	sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'],{
		main="Gada",
		sub="Ammurapi Shield",
		head=gear.Telchine_enh_head,
		body=gear.Telchine_enh_body, 
		hands=gear.Telchine_enh_hands,
		legs=gear.Telchine_enh_legs, 
		feet=gear.Telchine_enh_feet,
	})
	
	sets.midcast.Phalanx = set_combine( sets.midcast['Enhancing Magic'] , {} )
	sets.midcast.Haste = sets.midcast.EnhancingDuration
	
	sets.midcast.Regen = set_combine( sets.midcast.EnhancingDuration, {
		main="Bolelabunga",
		head="Arbatel Bonnet",
		back=gear.SCH_nuke_Cape
	})

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash",	-- 20
		neck="Nodens Gorget",	-- 30
		legs="Shedier Seraweels"-- 35
	})
	
    sets.midcast.Storm = set_combine(sets.midcast.EnhancingDuration, {}) --feet="Pedagogy Loafers"
	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
		main="Vadose Rod",		--	1
		sub="Ammurapi Shield",
		head="Amalric Coif +1",	--	2
		legs="Shedir Seraweels",--	1
		waist="Emphatikos Rope",--	1
	})
	
    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration,{ring1="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = set_combine(sets.midcast.EnhancingDuration,{ring1="Sheltered Ring"})
    sets.midcast.Shellra = sets.midcast.Shell

	sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1",
        waist="Gishdubar Sash"
    })
	
    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
		main=gear.Grio_enf,sub="Mephitis Grip",ammo="Pemphredo Tathlum",
        head="Amalric Coif +1",neck="Incanter's Torque",ear1="Regal Earring",ear2="Dignitary's Earring",
        body=gear.Merl_nuke_body,hands=gear.Chir_nuke_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back=gear.SCH_nuke_Cape,waist="Luminary Sash",legs="Chironic Hose",feet="Academic's Loafers +3"
	}

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {} )
	sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dark Magic'] = set_combine(sets.midcast.MndEnfeebles,{
		main="Rubicundity",sub="Genmei Shield",
		neck="Erra Pendant",
		body=gear.Amal_dark_body,hands=gear.Amal_dark_hands,ring1="Evanescence Ring",ring2="Archon Ring",
		back="Bookworm's Cape",waist="Fucho-No-Obi",legs=gear.Amal_dark_legs,feet=gear.Merl_dark_feet
	})
	
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'],{}) 
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = sets.midcast.IntEnfeebles --sets.midcast.FastRecast -- Pure fast recast, use only when not critical
	
	sets.midcast.Stun.Resistant = sets.midcast.IntEnfeebles


    -- Elemental Magic sets are default for handling low-tier nukes (magic damage>MAB>int)
    sets.midcast['Elemental Magic'] = {
		main="Akademos",sub="Enki Strap", ammo="Pemphredo Tathlum",
        head=gear.Merl_nuke_head,neck="Sanctity Necklace",ear1="Barkarole Earring",ear2="Regal Earring",
        body=gear.Amal_nuke_body,hands=gear.Amal_nuke_hands,ring1=gear.ElementalRing,ring2="Shiva Ring +1",
        back=gear.SCH_nuke_Cape,waist=gear.ElementalObi,legs=gear.Amal_nuke_legs,feet=gear.Amal_nuke_feet
	}
	
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
		body="Merlinic Jubbah",hands=gear.Chir_nuke_hands,ring1="Resonance Ring",
        legs=gear.Merl_FC_legs,feet=gear.Merl_nuke_feet
	}) -- Add extra macc/elemental magic
		
		
	sets.midcast['Elemental Magic'].Exp = set_combine(sets.midcast['Elemental Magic'],{body="Seidr Cotehardie"})

	sets.midcast.Kaustra = set_combine(sets.midcast['Elemental Magic'],{head="Pixie Hairpin +1",ring2="Archon Ring"})

	
	
    -- High tier nukes (MAB>int>magic damage)
    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {})
	sets.midcast['Elemental Magic'].HighTierNuke.Exp = set_combine(sets.midcast['Elemental Magic'].Exp,{})
	
    -- Spell/condition specific sets
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})
	
	sets.midcast['Elemental Magic'].Helix = set_combine(sets.midcast['Elemental Magic'],{
		sub="Enki Strap",
		ring1="Shiva Ring +1",
		back=gear.SCH_nuke_Cape
	})
	
	sets.magic_burst = set_combine(sets.midcast['Elemental Magic'],{
										--	MB
		main="Akademos",				-- 10
		sub="Enki Strap",		
		head=gear.Merl_nuke_head,		-- 10
		neck="Mizukage-no-Kubikazari",	-- 10
		hands=gear.Amal_nuke_hands,		-- (6)
		ring1="Mujin Band",				-- (5)
		ring2="Locus Ring",				-- 5
		legs=gear.Merl_MB_legs			-- 5
										-- 40 + 11
	}) 

	
	sets.magic_burst.Helix = set_combine(sets.magic_burst,{
	})
	
    -- Sets to return to when not performing an action.

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = { main="Akademos",sub="Enki Strap",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Genmei Earring",
        body="Jhakri Robe +2",hands=gear.Chir_ref_hands,ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Moonbeam Cape",waist="Refoccilation Stone",legs="Assiduity Pants +1",feet="Chironic Slippers"}
		
	sets.idle.Town = set_combine(sets.idle, {
		head="Amalric Coif +1",
		body=gear.Amal_nuke_body,
		hands=gear.Amal_nuke_hands,
		legs=gear.Amal_nuke_legs,
		feet=gear.Amal_nuke_feet,
	})	
	
	sets.idle.PDT = set_combine(sets.idle,{
									-- 	PDT	MDT
		ammo="Staunch Tathlum +1",	--	2	2
		head="Gende. Caubeen +1",	--	4	4		
		neck="Loricate Torque +1",	--	6	6
		ear1="Etiolation Earring",	--		3
		ear2="Odnowa Earring +1",	--		2
		body="Mallquis Saio +2",	--	8	8
		hands="Gende. Gages +1",	--	4	3
		ring1="Dark Ring",			--	6	4
		ring2="Defending Ring",		--	10	10
		back="Moonbeam Cape",		--	5	5
		legs="Artsieq Hose",		--	5
		feet="Gende. Galosh. +1"	--	4	4
	})								--	54	51
	
    sets.idle.Weak = sets.idle.PDT
	
	sets.idle.AntiStun=set_combine(sets.idle.PDT,{body='Onca Suit', ear1='Domin. Earring +1'})
	
	-- Defense sets
    sets.defense.PDT = sets.idle.PDT

    sets.defense.MDT = sets.idle.PDT 

    sets.Kiting = {}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged =  sets.idle -- Won't really melee on sch, setting a set with high level gear with haste just in case
	sets.engaged.DT = sets.idle.PDT

	-- WS
	sets.precast.WS.Myrkr= {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",neck="Orunmila's Torque",ear1="Gifted Earring",ear2="Etiolation Earring",
		body="Weather. Robe +1",hands="Bokwus Gloves",ring1="Mephitas's Ring",ring2="Mephitas's Ring +1",
		back="Fi Follet Cape +1",waist="Shinjutsu-No-Obi +1",legs=gear.Amal_nuke_legs,feet="Arbatel Loafers +1"
	} -- Stack at much mp as possible. MP recovered= 20% or total * TP/10000 (40% at 1000,60% at 3000).
	
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Rapture'] = {head="Savant's Bonnet +2"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Penury'] = {} -- legs="Savant's Pants +2"
    sets.buff['Parsimony'] = {} --legs="Savant's Pants +2"
    sets.buff['Celerity'] = {} --feet="Pedagogy Loafers"
    sets.buff['Alacrity'] = {} --feet="Pedagogy Loafers"

    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}

    sets.buff.FullSublimation = {main="Siriti",sub="Genmei Shield",ear1="Savant's Earring"} -- head="Academic's Mortarboard", body="Pedagogy Gown"
    sets.buff.PDTSublimation = sets.buff.FullSublimation

    --sets.buff['Sandstorm'] = {feet="Desert Boots"}
	
	-- Organizer set
	organizer_items = {
	  -- Weapons
	  --Food
	  food="Pear Crepe",
	  hqfood="Crepe Belle Helene",
	  -- Meds
	  echos="Echo Drops",
	  remedy="Remedy",
	  --Utils
	  warpr="Warp Ring",
	  teler="Dim. Ring (Dem)",
	  -- Others
	  eobi="Hachirin-No-Obi",
	  ecape="Twilight Cape",
	  ering="Zodiac Ring",
	  --
	  feet1=gear.Merl_FC_feet
	}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
--function midcast(spell)
--	 if spell.name:match('helix') then
--            equip(sets.midcast['Elemental Magic'].Helix)
--	end
--end

function job_post_precast(spell, action, spellMap, eventArgs)
	if 
		( buffactive['dark arts'] and spell.type == 'WhiteMagic') or
		( buffactive['addendum: black'] and spell.type == 'WhiteMagic') or
		( buffactive['addendum: white'] and spell.type == 'BlackMagic') or
		( buffactive['light arts'] and spell.type == 'BlackMagic')
	then
		-- Grimoire effect not active, capping FC and QC
		equip({back='Perimede Cape',feet=gear.Merl_FC_feet})
	end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Equip MB gear if MB status flagged
	if spell.skill == 'Elemental Magic' and state.MagicBurst.value and spell.name:match('helix') then
        equip(sets.magic_burst.Helix)
		add_to_chat(122, 'Helix MB used')
	elseif spell.skill == 'Elemental Magic' and state.MagicBurst.value and spell.english == 'Impact' then
		-- Prevent MB head to be equipped interrupting impact cast
		equip(set_combine(sets.magic_burst,sets.midcast.Impact))
		add_to_chat(122, 'MB used')
	elseif spell.skill == 'Elemental Magic' and state.MagicBurst.value then
		equip(sets.magic_burst)
		add_to_chat(122, 'MB used')
	elseif spell.name:match('helix') then
		equip(sets.midcast['Elemental Magic'].Helix)
		add_to_chat(122, 'Helix used')
    end
	
	-- Equip dark MAB gear if needed
	if spell.english == 'Noctohelix' or spell.english == 'Noctohelix II' or spell.english == 'Kaustra' then
		add_to_chat(122, 'Dark nuke - Adding dark MAB gear')
		equip({head="Pixie Hairpin +1",ring2="Archon Ring"})
	end
	
	-- Determine if Enhancing Magic spell is based on skill(potency) or not (duration)
	if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
    end
	
	-- Equip gear with stratagems bonus if they apply
	if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
end

function job_aftercast(spell)
    aftercast_start = os.clock()
	if spell.action_type ~= 'Magic' then
		aftercast_start = nil
	end
	
	if spell.english == 'Sleep' or spell.english == 'Sleepga' then
		send_command('@wait 50;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
	elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
		send_command('@wait 80;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
	elseif spell.english == 'Break' or spell.english == 'Breakga' then
		send_command('@wait 20;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
	elseif not spell.interrupted and spell.name:match('helix') then
		send_command('@timers d "'..helix_timer..'"')
        helix_timer = spell.english
        send_command('@timers c "'..helix_timer..'" '..helix_duration..' down spells/00879.png')
	end	
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
    if spell.type ~= 'JobAbility' and state.AutoSublimation.value then
        auto_sublimation()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
	elseif stateField == 'Skillchain' then	
		windower.send_command('bind ^x input /ma "' .. skillChainSpell[state.Skillchain.value]["helix"] ..'" <t>')
		windower.send_command('alias hx input /ma "' .. skillChainSpell[state.Skillchain.value]["helix"] ..'" <t>')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not (buffactive['light arts']      or buffactive['dark arts'] or
                       buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end

    update_active_strategems()
    update_sublimation()
end

function auto_sublimation()
    local abil_recasts = windower.ffxi.get_ability_recasts()
    if not (buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete']) then
        if not (buffactive['Invisible'] or buffactive['Weakness']) then
            if abil_recasts[234] == 0 then
                send_command('@wait 2;input /ja "Sublimation" <me>')
            end
        end
    --elseif buffactive['Sublimation: Complete'] then
    --    if player.mpp < 80 and abil_recasts[234] == 0 then
    --        send_command('@wait 2;input /ja "Sublimation" <me>')
    --    end
    end         
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    -- Display MB status
	if state.MagicBurst.value == true then
        add_to_chat(122, 'Magic Burst: [On]')
    elseif state.MagicBurst.value == false then
        add_to_chat(122, 'Magic Burst: [Off]')
    end

	-- Display spell upgrade status
	if state.SpellUpgrade.value == true then
        add_to_chat(122, 'Spell Upgrade: [On]')
    elseif state.SpellUpgrade.value == false then
        add_to_chat(122, 'Spell Upgrade: [Off]')
    end
	
	
	-- AUto sublimation toggle
	if state.AutoSublimation.value == true then
        add_to_chat(122, 'Auto Sublimation: [On]')
    elseif state.AutoSublimation.value == false then
        add_to_chat(122, 'Auto Sublimation: [Off]')
    end
	
	local msg = ''

	local currentStrats = get_current_strategem_count()
	local arts
	if buffactive['Light Arts'] or buffactive['Addendum: White'] then
		arts = 'Light Arts'
	elseif buffactive['Dark Arts'] or buffactive['Addendum: Black'] then
		arts = 'Dark Arts'
	else
		arts = 'No Arts Activated'
	end
	add_to_chat(122, 'Current Available Strategems: ['..currentStrats..'], '..arts..'')
	
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'open' then
        skillchainSpell('open')
		eventArgs.handled = true
	elseif cmdParams[1]:lower() == 'close' then
		skillchainSpell('close')
		eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'helix' then
		send_command('@input /ma '..skillChainSpell[state.Skillchain.value]["helix"]..' <t>')
		eventArgs.handled = true
    end
end

function skillchainSpell(openOrClose)
	immanenceCmd = ""
	-- Activate Dark Arts if not active
	if not ( buffactive['dark arts'] or buffactive['addendum: black'] ) then
		add_to_chat(122, 'Activating Dark Arts to enable Immanence')
		immanenceCmd = immanenceCmd .. '/ja "Dark Arts" <me>; wait 1.5; input '
	end
	
	-- Use Immanence if not active
	if not buffactive['Immanence'] then
		immanenceCmd = immanenceCmd .. '/ja "Immanence" <me>; wait 1.5;input '
	end
	
	send_command('@input /p ' .. (openOrClose == 'close' and 'Closing' or 'Opening') .. ' '..skillChainSpell[state.Skillchain.value]["name"]..' >> <t>')
	send_command('@input '.. immanenceCmd .. '/ma '..skillChainSpell[state.Skillchain.value][openOrClose]..' <t>')
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element and state.CastingMode.value ~= 'Resistant' then
            equip(sets.buff['Klimaform'])
        end
    end

	if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use
	if not cmdParams[2] then
		add_to_chat(123,'Error: No strategem command given.')
		return
	end

	local currentStrats = get_current_strategem_count()
	local newStratCount = currentStrats - 1
	local strategem = cmdParams[2]:lower()
	
	if currentStrats > 0 and strategem ~= 'light' and strategem ~= 'dark' then
		add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
	elseif currentStrats == 0 then
		add_to_chat(122, '***Out of strategems! Canceling...***')
		return
	end

	if strategem == 'light' then
		if buffactive['light arts'] then
			send_command('input /ja "Addendum: White" <me>')
			add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
		elseif buffactive['addendum: white'] then
			add_to_chat(122,'Error: Addendum: White is already active.')
		elseif buffactive['dark arts']  or buffactive['addendum: black'] then
			send_command('input /ja "Light Arts" <me>')
			add_to_chat(122, '***Changing Arts! Current Charges Available: ['..currentStrats..']***')
		else
			send_command('input /ja "Light Arts" <me>')
		end
	elseif strategem == 'dark' then
		if buffactive['dark arts'] then
			send_command('input /ja "Addendum: Black" <me>')
			add_to_chat(122, '***Current Charges Available: ['..newStratCount..']***')
        elseif buffactive['addendum: black'] then
			add_to_chat(122,'Error: Addendum: Black is already active.')
		elseif buffactive['light arts'] or buffactive['addendum: white'] then
			send_command('input /ja "Dark Arts" <me>')
			add_to_chat(122, '***Changing Arts! Current Charges Available: ['..currentStrats..']***')
		else
			send_command('input /ja "Dark Arts" <me>')
		end
	elseif buffactive['light arts'] or buffactive['addendum: white'] then
		if strategem == 'cost' then
			send_command('@input /ja Penury <me>')
		elseif strategem == 'speed' then
			send_command('@input /ja Celerity <me>')
		elseif strategem == 'aoe' then
			send_command('@input /ja Accession <me>')
		elseif strategem == 'power' then
			send_command('@input /ja Rapture <me>')
		elseif strategem == 'duration' then
			send_command('@input /ja Perpetuance <me>')
		elseif strategem == 'accuracy' then
			send_command('@input /ja Altruism <me>')
		elseif strategem == 'enmity' then
			send_command('@input /ja Tranquility <me>')
		elseif strategem == 'skillchain' then
			add_to_chat(122, 'Activating Dark Arts to enable Immanence')
			windower.send_command('@input /ja "Dark Arts" <me>; wait 1.5; input /ja "Immanence" <me>')		
			--add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
		elseif strategem == 'addendum' then
			send_command('@input /ja "Addendum: White" <me>')
		else
			add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
		end
	elseif buffactive['dark arts']  or buffactive['addendum: black'] then
		if strategem == 'cost' then
			send_command('@input /ja Parsimony <me>')
		elseif strategem == 'speed' then
			send_command('@input /ja Alacrity <me>')
		elseif strategem == 'aoe' then
			send_command('@input /ja Manifestation <me>')
		elseif strategem == 'power' then
			send_command('@input /ja Ebullience <me>')
		elseif strategem == 'duration' then
			add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
		elseif strategem == 'accuracy' then
			send_command('@input /ja Focalization <me>')
		elseif strategem == 'enmity' then
			send_command('@input /ja Equanimity <me>')
		elseif strategem == 'skillchain' then
			send_command('@input /ja Immanence <me>')
		elseif strategem == 'addendum' then
			send_command('@input /ja "Addendum: Black" <me>')
		else
			add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
		end
	elseif strategem == 'skillchain' then
		add_to_chat(122, 'Activating Dark Arts to enable Immanence')
		windower.send_command('@input /ja "Dark Arts" <me>; wait 1.5; input /ja "Immanence" <me>')		
	else
		add_to_chat(123,'No arts has been activated yet.')
	end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end


function job_pretarget(spell)
	checkblocking(spell)
    if spell.action_type == 'Magic' then
        if aftercast_start and os.clock() - aftercast_start < waittime then
            windower.add_to_chat(8,"Precast too early! Adding Delay:"..waittime - (os.clock() - aftercast_start))
            cast_delay(waittime - (os.clock() - aftercast_start))
        end
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 3)
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 10')
end