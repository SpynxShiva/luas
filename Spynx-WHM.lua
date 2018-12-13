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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

	chironic_hands_ref = { name="Chironic Gloves", augments={'Attack+11','INT+2','"Refresh"+2','Accuracy+11 Attack+11','Mag. Acc.+8 "Mag.Atk.Bns."+8',}}
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {main=gear.FastcastStaff,ammo="Incantor Stone",
        head="Nahtirah Hat",neck="Orunmila's Torque",ear2="Loquacious Earring",
        body="Anhur Robe",hands="Gendewitha Gages +1",ring1="Kishar Ring",		--  4
		ring2="Prolix Ring",		--  2
        waist="Witful Belt",legs="Gendewitha Spats"}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {legs="Orison Pantaloons +2"})

    sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {main="Queller Rod",sub="Sors Shield",ammo="Incantor Stone",head="Orison Cap +2",back="Pahtli Cape",feet="Hygieia Clogs"})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {body="Piety Briault"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Nahtirah Hat",ear1="Roundel Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = ""
    sets.precast.WS = {
        head="Nahtirah Hat",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Refraction Cape",waist=gear.ElementalBelt,legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    sets.precast.WS['Flash Nova'] = {
        head="Nahtirah Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
        back="Toro Cape",waist="Fotia Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    

    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Nahtirah Hat",ear2="Loquacious Earring",
        body="Anhur Robe",hands="Gendewitha Gages",
        back="Swith Cape +1",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    -- Cure sets
    gear.default.obi_waist = "Goading Belt"
    gear.default.obi_back = "Mending Cape"

    sets.midcast.Cure = {
		main="Queller Rod",sub="Sors Shield",ammo="Incantor Stone",
        head="Gendewitha Caubeen",neck="Orison Locket",ear1="Nourishing Earring",ear2="Mendi. Earring",
        body="Heka's Kalasiris",hands="Bokwus Gloves",
        back="Pahtli Cape",waist="Korin Obi",legs="Orison Pantaloons +2",feet="Medium's Sabots"}
	
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure, {})

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {})

    sets.midcast.StatusRemoval = {
        head="Orison Cap +2",legs="Orison Pantaloons +2"
	}

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {
		main="Gada",sub="Ammurapi Shield",
		head="Telchine Cap",neck="Incanter's Torque",
		body="Telchine chasuble", hands="Telchine Gloves",
		back="Perimede Cape ",legs="Telchine Braconi", feet="Telchine Pigaches"
	}

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
		waist="Siegel Sash",	-- 20
		neck="Nodens Gorget",	-- 30
		legs="Shedier Seraweels"-- 35
	})
	
	sets.midcast.Haste= sets.midcast['Enhancing Magic']

    sets.midcast.Auspice = sets.midcast['Enhancing Magic']

    sets.midcast.BarElement = sets.midcast['Enhancing Magic']

    sets.midcast.Regen = {main="Bolelabunga",sub="Genmei Shield",
        body="Cleric's Briault",hands="Orison Mitts +2"}

    sets.midcast.Protectra = set_combine(sets.precast.FC, {})
	
    sets.midcast.Shellra = set_combine(sets.precast.FC, {})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
		main="Vadose Rod",		--	1
		sub="Ammurapi Shield",
		head="Amalric Coif +1",	--	2
		legs="Shedir Seraweels",--	1
		waist="Emphatikos Rope",--	1
	})
	
	-- Custom spell classes
    sets.midcast.MndEnfeebles = {main="Lehbrailg +2", sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Aquasoul Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Piety Duckbills +1"}

    sets.midcast.IntEnfeebles = {main="Lehbrailg +2", sub="Mephitis Grip",
        head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Sangoma Ring",
        back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Piety Duckbills +1"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
        hands="Serpentes Cuffs",
        waist="Austerity Belt",legs="Assid. Pants +1"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {main="Queller Rod", sub="Genmei Shield",ammo="Homiliary",
        head="Befouled Crown",neck="Loricate Torque +1",ear1="Nourish. Earring",ear2="Loquacious Earring",
        body="Witching Robe",hands=chironic_hands_ref,ring1="Defending Ring", ring2="Dark Ring",
        back="Umbra Cape",waist="Witful Belt",legs="Assid. Pants +1",feet="Chironic Slippers"}

	sets.idle.PDT = {head="Nahtirah Hat",body="Onca suit"}

    sets.idle.Town = set_combine(sets.idle , {})
    
    sets.idle.Weak = set_combine(sets.idle , {})
    
    -- Defense sets

    sets.defense.PDT = set_combine(sets.idle , {})

    sets.defense.MDT = set_combine(sets.idle , {})

    sets.Kiting = set_combine(sets.idle , {})

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = set_combine(sets.idle , {})


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Orison Mitts +2"}
	
	organizer_items = {
	  echos="Echo Drops",
	  warpr="Warp Ring",
	  cpring="Capacity Ring",
	  teler="Dim. Ring (Dem)",
	  cmantle="Mecisto. Mantle",
	  food="Pear Crepe"
	}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
    
    if spell.skill == 'Healing Magic' then
        gear.default.obi_back = "Solemnity Cape"
    else
        gear.default.obi_back = "Toro Cape"
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
        elseif default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
            return "CureSolace"
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 1)
end
