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
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Impetus'] = buffactive['Impetus'] or false

    info.impetus_hit_count = 0
    windower.raw_register_event('action', on_action_for_impetus)
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','MidAcc','HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal')

	send_command('bind ^t gs c cycle TreasureMode')

	select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.TreasureHunter = {
        head=gear.Herc_TH_head, -- 2
        body="Volte Jupon",		-- 2
  	}

    -- Precast Sets
	sets.precast.FC = {
		head=gear.Herc_FC_head,		--  13
		neck="Orunmila's Torque",  	--	 5
		ear1="Loquacious Earring", 	--	 2
		ear2="Etiolation Earring",	-- 	 1
		body=gear.Taeon_FC_body,	--	 8
		hands="Leyline Gloves", 	--	 8
	}								--	37

    -- Idle sets
    sets.idle = {
        ammo="Staunch Tathlum +1",	--  3	3
        head="Nyame Helm",			--  7	7
        neck="Bathy Choker +1",
        ear1="Infused Earring",
        ear2="Telos Earring",
        body="Nyame Mail",          --	9	9
        hands="Nyame Gauntlets",	--	7	7
        ring1="Shadow Ring",
        ring2="Gelatinous Ring +1", --  7	-1
        waist="Moonbow Belt +1 +1",    -- 	6   6
        back="Moonlight Cape",      --  6	6
        legs="Nyame Flanchard",     --  8	8
        feet="Nyame Sollerets",	    --  7	7
	}								-- 60   52

    -- Engaged sets
    sets.engaged = {
		ammo="Ginsen",
        head=gear.Adhemar_TP_head,
        neck="Mnk. Nodowa +2",
        ear1="Sherida Earring",
        ear2="Telos Earring",
		body="Ken. Samue +1",
        hands=gear.Adhemar_TP_hands,
        ring1="Niqmaddu Ring",
        ring2="Gere Ring",
		back=gear.MNK_TP_Cape,
        waist="Moonbow Belt +1",
        legs="Hes. Hose +3",
        feet="Anch. Gaiters +3"
	}

	sets.buff.Impetus = {body="Bhikku Cyclas +1"}
    sets.buff.ImpetusWS = {body="Bhikku Cyclas +1", ear2="Schere Earring"}

    sets.engaged.Impetus = set_combine(sets.engaged,sets.buff.Impetus )

    sets.engaged.MidAcc = set_combine(sets.engaged, {
        legs="Ken. Hakama +1",
    })
    sets.engaged.MidAcc.Impetus = set_combine(sets.engaged.MidAcc, sets.buff.Impetus)

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        head="Ken. Jinpachi +1",
        feet="Ken. Sune-Ate +1",
        ring1="Ilabrat Ring",
    })
    sets.engaged.HighAcc.Impetus = set_combine(sets.engaged.HighAcc, {})

    sets.DT = {                     --	PDT		MDT
        head="Ken. Jinpachi +1",
		body="Malignance Tabard",	--	9	    9
        hands="Malignance Gloves",	--	5	    5
        legs="Mpaca's Hose",        --  9    	9
        feet="Ken. Sune-Ate +1",
		-- Belt						--  6		6
		-- Cape						-- 10
  	}                               -- 39      29

    sets.engaged.DT = set_combine(sets.engaged,sets.DT )

    sets.engaged.DT.Impetus = set_combine(sets.engaged.DT, sets.buff.Impetus)

    sets.engaged.MidAcc.DT = set_combine(sets.engaged.DT, {})
    sets.engaged.MidAcc.DT.Impetus = set_combine(sets.engaged.DT.MidAcc, sets.buff.Impetus)

    sets.engaged.HighAcc.DT = set_combine(sets.engaged.MidAcc.DT, {})
    sets.engaged.HighAcc.DT.Impetus = set_combine(sets.engaged.HighAcc.DT, sets.buff.Impetus)

    -- WS Sets
    sets.precast.WS = {
        ammo="Knobkierrie",
        head=gear.Adhemar_TP_head,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Odr Earring",
        body="Ken. Samue +1",
        hands="Ryuo Tekko +1",
        ring1="Niqmaddu Ring",
        ring2="Gere Ring",
        back=gear.MNK_WS_Cape,
        waist="Moonbow Belt +1",
        legs="Mpaca's Hose",
        feet=gear.Herc_critDmg_feet
    }

    sets.precast.WS['Victory Smite'] = sets.precast.WS

	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS,{
        head="Ken. Jinpachi +1",
        body=gear.Adhemar_TP_body,
        hands=gear.Adhemar_TP_hands,
        feet="Ken. Sune-Ate +1"
    })

	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS,{
		head="Ken. Jinpachi +1",
		body=gear.Adhemar_TP_body,
		legs="Jokushu Haidate",
        feet="Ken. Sune-Ate +1",
	})

	-- Organizer set
  	organizer_items = {
        weapon1="Verethragna",
        weapon2="Godhands",
        sushi="Sublime Sushi",
        atkfood="Red Curry Bun",
  	}

end

function job_post_precast(spell, action, spellMap, eventArgs)
  if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") and info.impetus_hit_count > 8 then
      equip(sets.buff.ImpetusWS)
  end
end

function job_buff_change(buff, gain)
    if ( buff == "Impetus" and gain ) or buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    else
        classes.CustomMeleeGroups:clear()
    end
end

function update_melee_groups()
      classes.CustomMeleeGroups:clear()

      if buffactive.impetus then
          classes.CustomMeleeGroups:append('Impetus')
      end
end

function job_update(cmdParams, eventArgs)
    update_melee_groups()
end

function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 5)
end

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
    if state.Buff['Impetus'] then

		previous_count = info.impetus_hit_count

        -- count melee hits by player
        if action.actor_id == player.id then
            if action.category == 1 then
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- Reactions (bitset):
                        -- 1 = evade
                        -- 2 = parry
                        -- 4 = block/guard
                        -- 8 = hit
                        -- 16 = JA/weaponskill?
                        -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        if (action.reaction % 4) > 0 then
                            add_to_chat(123,'Missed attack - Impetus hit count = 0')
							info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 1
                        end
                    end
                end
            elseif action.category == 3 then
                -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- Can't tell if any hits were missed, so have to assume all hit.
                -- Increment by the minimum number of weaponskill hits: 2.
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- This will only be if the entire weaponskill missed or was parried.
                        if (action.reaction % 4) > 0 then
                            add_to_chat(123,'Missed attack - Impetus hit count = 0')
							info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 2
                        end
                    end
                end
            end
        elseif action.actor_id ~= player.id and action.category == 1 then
            -- If mob hits the player, check for counters.
            for _,target in pairs(action.targets) do
                if target.id == player.id then
                    for _,action in pairs(target.actions) do
                        -- Spike effect animation:
                        -- 63 = counter
                        -- ?? = missed counter
                        if action.has_spike_effect then
                            -- spike_effect_message of 592 == missed counter
                            if action.spike_effect_message == 592 then
                                add_to_chat(123,'Missed attack - Impetus hit count = 0')
								info.impetus_hit_count = 0
                            elseif action.spike_effect_animation == 63 then
                                info.impetus_hit_count = info.impetus_hit_count + 1
                            end
                        end
                    end
                end
            end
        end

        if info.impetus_hit_count > previous_count then
			add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
		end
    else
        info.impetus_hit_count = 0
    end

end
