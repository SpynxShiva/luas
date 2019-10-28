
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
	include('Mote-TreasureHunter')
	tagged_mobs = T{}
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false

	require(player.name..'-BLU-spellMap.lua')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','MidAcc','HighAcc')
    state.HybridMode:options('Normal', 'DT') --,'Refresh')
	state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

	-- Make sure gearinfo is loaded to handle haste/DW
	send_command('lua l gearinfo')
	
	-- Toggles
	state.MagicBurst = M(false, 'Magic Burst')
	
	send_command('bind ^m gs c toggle MagicBurst')
	send_command('bind ^t gs c cycle TreasureMode')
	
	-- Weapon sets
	state.WeaponSets = M{['description']='Weapon set', 'Standard', 'Magic', 'Savage','Expi'}
	WeaponSetsGear = { 
		["Standard"] = {main="Tizona",sub="Almace"},
		["Magic"] = {main="Naegling",sub="Maxentius"},
		["Savage"] = {main="Naegling",sub="Thibron"},
		["Expi"] = {main="Tizona",sub="Thibron"},
	}
	
	send_command('bind ^- gs c cycleback WeaponSets')
	send_command('bind ^= gs c cycle WeaponSets')
	
	select_default_macro_book()
	set_lockstyle()
	
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
    send_command('unbind ^m')
	send_command('unbind ^c')
	send_command('unbind ^t')
	send_command('unbind ^-')
	send_command('unbind ^=')
end


-- Set up gear sets.
function init_gear_sets()
    require(player.name..'-BLU-sets.lua')
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
    
	if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
    end
	
	-- Self-healing
	if (spellMap == 'Cure' or spellMap == 'Healing' ) and spell.target.type == 'SELF' then
            equip(sets.self_healing)
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
	
	-- TH
	if state.TreasureMode.value ~= 'None' and spell.target.type == 'MONSTER' and not allMobsInRangeTagged() then
		add_to_chat(122, 'Using TH gear!')
		equip(sets.TreasureHunter)
	end
	
end


function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Dream Flower" then
            send_command('@timers c "Dream Flower ['..spell.target.name..']" 90 down spells/00098.png')
        elseif spell.english == "Soporific" then
            send_command('@timers c "Sleep ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sheep Song" then
            send_command('@timers c "Sheep Song ['..spell.target.name..']" 60 down spells/00098.png')
        elseif spell.english == "Yawn" then
            send_command('@timers c "Yawn ['..spell.target.name..']" 60 down spells/00098.png')
        elseif spell.english == "Entomb" then
            send_command('@timers c "Entomb ['..spell.target.name..']" 60 down spells/00547.png')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
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
    handle_equipping_gear(player.status)
    update_active_abilities()
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
    determine_haste_group()
end

function update_combat_form()  
	if DW == true then  
		state.CombatForm:set('DW')  
	elseif DW == false then  
		state.CombatForm:reset()  
	end  
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
    if state.WeaponSets.current then
        equip(WeaponSetsGear[state.WeaponSets.current])
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(2, 7)
end

function set_lockstyle()
	send_command('wait 2; input /lockstyleset 11')
end

--[[
	AoE TH functions
]]--

windower.register_event('action', function(act)
    if act['category'] == 4 and state.TreasureMode.value ~= 'None' then
		for k,v in pairs(act.targets) do 
			if v.id ~= windower.ffxi.get_player().id and not tagged_mobs[v.id] then
				-- Add mobs to TH tagged
				tagged_mobs[v.id] = os.time()
			end
		end
		
		cleanup_th_mobs()
	end
end)

function allMobsInRangeTagged()
	for i,v in pairs(windower.ffxi.get_mob_array()) do
		if 
			v.valid_target 
			and v.is_npc
			and v.spawn_type == 16
			and math.sqrt(v.distance) < 11
			and not tagged_mobs[v.id] 
		then
			return false
		end
	end
	return true
end

function cleanup_th_mobs()
    local current_time = os.time()
    local remove_mobs = S{}
    
	-- Search list and flag old entries.
    for target_id,action_time in pairs(tagged_mobs) do
        local time_since_last_action = current_time - action_time
		if time_since_last_action > 180 then
			remove_mobs:add(target_id)
        end
    end
    -- Clean out mobs flagged for removal.
    for mob_id,_ in pairs(remove_mobs) do
        tagged_mobs[mob_id] = nil
    end
end

--[[
	Auto-haste functions
]]--
function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
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

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 11 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 11 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 21 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 27 and DW_needed <= 37 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 37 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

windower.register_event('zone change', 
    function()
        send_command('gi ugs true')
		
		for k,v in pairs(windower.ffxi.get_abilities().job_traits) do 
			if v == 19 then -- Treasure hunter
				add_to_chat(122, 'Found TH job traits, setting TH set to TH+3')
				sets.TreasureHunter = sets.TH3
				
				return
			end
		end
		
		sets.TreasureHunter = sets.TH4
    end
)
