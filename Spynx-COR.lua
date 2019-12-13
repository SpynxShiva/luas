-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
require('rnghelper')

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('Mote-TreasureHunter')
	include('organizer-lib')
	send_command('lua u autora')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	-- QuickDraw Selector
	state.Mainqd = M{['description']='Primary Shot', 'Dark Shot', 'Earth Shot', 'Water Shot', 'Wind Shot', 'Fire Shot', 'Ice Shot', 'Thunder Shot'}
	state.QDMode = M{['description']='Quick Draw Mode', 'STP', 'Enhance', 'Potency', 'TH'}
	
	-- Whether a warning has been given for low ammo
	state.warned = M(false)

	elemental_ws = S{'Aeolian Edge', 'Leaden Salute', 'Wildfire'}

	define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc','HighAcc','Crit')
    state.RangedMode:options('STP','Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('None', 'PDT')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'DT')
	state.HybridMode:options('Normal', 'DT')

	-- Make sure gearinfo is loaded to handle haste/DW
	send_command('lua l gearinfo')

	-- JA bindings
	send_command('bind ^t input /ja "Triple Shot" <me>')
	
	-- Roll toogles
	state.ForceCompensator = M(false, 'Force Compensator')
	send_command('bind ^d gs c toggle ForceCompensator')
	send_command('gs c set ForceCompensator true')
	
	-- QD toogles
	state.MDshot = M(false, "Magic Damage Bonus Shot")
	send_command('bind @q gs c cycle QDMode')
	send_command('bind ^- gs c cycleback mainqd')
	send_command('bind ^= gs c cycle mainqd')
	
	-- Autoshoot toggles
	send_command('bind ^[ gs rh enable')
	send_command('bind ^] gs rh disable')	
	send_command('bind ^; gs rh set "Last Stand"')
	send_command('bind ^\' gs rh set "Leaden Salute"')
	send_command('bind ^c gs rh clear')
	send_command('gs rh disable')
	
	send_command('bind ^t gs c cycle TreasureMode')
	
	-- Gears
	-- Bullets
	gear.RAbullet = "Chrono Bullet"
	gear.WSbullet = "Chrono Bullet"
	gear.MAbullet = "Living Bullet"
	gear.QDbullet = "Living Bullet"
	options.ammo_warning_limit = 5
	
	-- Weapon sets
	state.WeaponSets = M{['description']='Weapon set', 'Melee', 'RangedMelee', 'RangedOnly', 'LeadenSpeed', 'LeadenPower','LeadenMelee'}
	WeaponSetsGear = { 
		["Melee"] = {main="Naegling",sub="Blurred Knife +1",range="Anarchy +2"},
		["RangedMelee"] = {main="Kustawi +1",sub="Blurred Knife +1", range="Fomalhaut"},
		["RangedOnly"] = {main="Kustawi +1",sub="Nusku Shield", range="Fomalhaut"},
		["LeadenSpeed"] = {main="Tauret",sub="Blurred Knife +1",range="Death Penalty"},
		["LeadenPower"] = {main="Naegling",sub="Tauret",range="Death Penalty"},
		["LeadenMelee"] = {main="Naegling",sub="Blurred Knife +1",range="Death Penalty"},
	}	
	
	send_command('bind ^. gs c cycleback WeaponSets')
	send_command('bind ^/ gs c cycle WeaponSets')
	
    select_default_macro_book()
	
	-- Haste auto-detection setup
	Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^d') -- Force compensator (roll Duration)
	
	send_command('unbind ^t') -- TH
	
	send_command('unbind @q') -- QD mode
	send_command('unbind ^-') -- Next QD 
	send_command('unbind ^=') -- Previous QD
	
	send_command('unbind ^[')  -- Autoshot: enable
	send_command('unbind ^]')  -- Autoshot: disable
	send_command('unbind ^;')  -- Autoshot: set Last Stand as WS
	send_command('unbind ^\'') -- Autoshot: set Leaden as WS
	send_command('unbind ^c')  -- Autoshot: clear WS
	
	send_command('unbind ^.') -- Next weapons set
	send_command('unbind ^/') -- PreviousNext weapons set
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    require(player.name..'-COR-sets.lua')
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
	equip(WeaponSetsGear[state.WeaponSets.current])

	-- Check that proper ammo is available if we're using ranged attacks or similar.
	if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
		do_bullet_checks(spell, spellMap, eventArgs)
	end
end


-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    -- Equip compensator only if TPs are very low (to avoid losing them) or if ForceCompensator (CTRL+C) is set
	if (spell.type == 'CorsairRoll' and player.tp < 500 ) or (spell.type == 'CorsairRoll' and state.ForceCompensator.value) then
		add_to_chat(104, 'Compensator used')
		equip({range="Compensator"})
	end	
	
	-- Flurry mode/status check
	if spell.action_type == 'Ranged Attack' then
        if flurry == 2 then
            equip(sets.precast.RA.Flurry2)
        elseif flurry == 1 then
            equip(sets.precast.RA.Flurry1)
        end
	end
	 
	-- Handle full TP on WS
	if spell.type == 'WeaponSkill' and player.tp > 2900 and sets.precast.WS[spell.english].FullTP then
		equip(sets.precast.WS[spell.english].FullTP)
	end
	
	-- Equip obi if weather/day matches for WS/Quick Draw.
    if spell.type == 'WeaponSkill' then
        if elemental_ws:contains(spell.name) then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip(sets.Obi)
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip(sets.Orpheus)
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip(sets.Obi)
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip(sets.Orpheus)
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip(sets.Obi)
            end
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.type == 'CorsairShot' then
		if 	( spell.english ~= "Light Shot" and spell.english ~= "Dark Shot" ) then
			-- Matching double weather (w/o day conflict).
			if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
				equip(sets.Obi)
			-- Target distance under 1.7 yalms.
			elseif spell.target.distance < (1.7 + spell.target.model_size) then
				equip(sets.Orpheus)
			-- Matching day and weather.
			elseif spell.element == world.day_element and spell.element == world.weather_element then
				equip(sets.Obi)
			-- Target distance under 8 yalms.
			elseif spell.target.distance < (8 + spell.target.model_size) then
				equip(sets.Orpheus)
			-- Match day or weather.
			elseif spell.element == world.day_element or spell.element == world.weather_element then
				equip(sets.Obi)
			end
		end
		
		if state.QDMode.value == 'Enhance' then
            equip(sets.MBbonus)
        elseif state.QDMode.value == 'TH' then
            equip(sets.midcast.CorsairShot)
            equip(sets.TreasureHunter)
        elseif state.QDMode.value == 'STP' then
            equip(sets.midcast.CorsairShot.STP)
		end
	end
	
	if spell.action_type == 'Ranged Attack' and buffactive['Triple Shot'] then
		equip(sets.TripleShot)
	end
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	equip(WeaponSetsGear[state.WeaponSets.current])
	
	if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
	
	if spell.english == "Light Shot" then
        send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "doom" then
		if gain then		   
			equip(sets.buff.Doom)
			send_command('@input /p Doomed.')
			disable('waist')
		else
			enable('waist')
			handle_equipping_gear(player.status)
		end
	end
	
	if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            add_to_chat(122, "Flurry status cleared.")
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

function customize_idle_set(idleSet)
    return idleSet
end


function customize_melee_set(meleeSet)
    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    equip(WeaponSetsGear[state.WeaponSets.current])
	handle_equipping_gear(player.status)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local qd_msg = '(' ..string.sub(state.QDMode.value,1,1).. ')'
    
    local e_msg = state.Mainqd.current
    
    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end
	
	

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' QD' ..qd_msg.. ': '  ..string.char(31,001)..e_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
	equip(WeaponSetsGear[state.WeaponSets.current])
 end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
	local bullet_name
	local bullet_min_count = 1
	
	if spell.type == 'WeaponSkill' then
		if spell.skill == "Marksmanship" then
			if spell.name == 'Leaden Salute' or spell.name == 'Wildfire' then
				-- magical weaponskills
				bullet_name = gear.MAbullet
			else
				-- physical weaponskills
				bullet_name = gear.WSbullet
			end
		else
			-- Ignore non-ranged weaponskills
			return
		end
	elseif spell.type == 'CorsairShot' then
		bullet_name = gear.QDbullet
	elseif spell.action_type == 'Ranged Attack' then
		bullet_name = gear.RAbullet
		if buffactive['Triple Shot'] then
			bullet_min_count = 3
		end
	end
	
	local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
	
	-- If no ammo is available, give appropriate warning and end.
	if not available_bullets then
		if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
			add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
			return
		elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
			add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
			return
		else
			add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
			eventArgs.cancel = true
			return
		end
	end
	
	-- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
	if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
		add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
		eventArgs.cancel = true
		return
	end
	
	-- Low ammo warning.
	if spell.type ~= 'CorsairShot' and state.warned.value == false
		and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
		local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
		--local border = string.repeat("*", #msg)
		local border = ""
		for i = 1, #msg do
			border = border .. "*"
		end
		
		add_to_chat(104, border)
		add_to_chat(104, msg)
		add_to_chat(104, border)

		state.warned:set()
	elseif available_bullets.count > options.ammo_warning_limit and state.warned then
		state.warned:reset()
	end
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function update_combat_form()  
	if DW == true then  
		state.CombatForm:set('DW')  
	elseif DW == false then  
		state.CombatForm:reset()  
	end  
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 11 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 11 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MaxHastePlus')
        elseif DW_needed > 21 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
    determine_haste_group()
end


--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action',
    function(act)
        --check if you are a target of spell
        local actionTargets = act.targets
        playerId = windower.ffxi.get_player().id
        isTarget = false
        for _, target in ipairs(actionTargets) do
            if playerId == target.id then
                isTarget = true
            end
        end
        if isTarget == true then
            if act.category == 4 then
                local param = act.param
                if param == 845 and flurry ~= 2 then
                    add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    add_to_chat(122, 'Flurry Status: Flurry II')
                    flurry = 2
              end
            end
        end
	end
)

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
	if cmdParams[1]:lower() == 'qd' then
		send_command('@input /ja "'..state.Mainqd.current..'" <t>')
	else
		gearinfo(cmdParams, eventArgs)
	end
end


function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Drachen Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Puppet Roll"]     = {lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Naturalist's Roll"]       = {lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
        ["Runeist's Roll"]       = {lucky=4, unlucky=8, bonus="Magic Evasion"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    
    if rollinfo then
        add_to_chat(104, '[ Lucky: '..tostring(rollinfo.lucky)..' / Unlucky: '..tostring(rollinfo.unlucky)..' ] '..spell.english..': '..rollinfo.bonus)
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(2, 14)
end

function job_sub_job_change(newSubjob, oldSubjob)
    -- Reload gearswap on SJ change to handle SJ specific sets
	send_command('gs reload')
end

windower.register_event('zone change', 
    function()
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            send_command('gi ugs true')
        end
    end
)
