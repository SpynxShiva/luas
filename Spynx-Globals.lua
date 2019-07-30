-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()

	-- Augmented Weapons
	gear.Grio_nuke 	= { name="Grioavolr", augments={'Enfb.mag. skill +15','INT+10','Mag. Acc.+24','"Mag.Atk.Bns."+26',}}
	gear.Grio_enf	= gear.Grio_nuke
	gear.Grio_death	= { name="Grioavolr", augments={'Magic burst dmg.+5%','MP+99','"Mag.Atk.Bns."+24',}}
	gear.Grio_MB	= { name="Grioavolr", augments={'Magic burst dmg.+8%','INT+8','Mag. Acc.+12','"Mag.Atk.Bns."+30',}}
	gear.Colada_SB 	= { name="Colada", augments={'Weapon skill damage +1%','STR+15','Accuracy+18','Attack+5',}}
	
	-- Adhemar
	gear.Adhemar_TP_body 	= { name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	gear.Adhemar_TP_hands 	= { name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	gear.Adhemar_TP_head = { name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
	
	gear.Adhemar_RA_hands 	= { name="Adhemar Wrist. +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}}
	gear.Adhemar_RA_legs	= { name="Adhemar Kecks +1", augments={'AGI+12','Rng.Acc.+20','Rng.Atk.+20',}}
    
	gear.Adhemar_SNAP_legs	={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}}

	-- Carmine
	gear.Carmine_LS_hands 	= { name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}
	gear.Carmine_SNAP_hands = { name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}
	
	-- Souveran
	gear.Souv_tank_head	= { name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',},priority=15}
	gear.Souv_tank_body = {name="Souveran Cuirass", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',},priority=15}
	gear.Souv_tank_hands= { name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',},priority=15}
	gear.Souv_tank_legs	= { name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=15}
	gear.Souv_tank_feet	= { name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=15}
	
	gear.Souv_ref_body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}}
	
	-- Amalric
	gear.Amal_macc_head={ name="Amalric Coif +1", augments={'INT+12','Mag. Acc.+25','Enmity-6',}}
	
	gear.Amal_nuke_body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
   	gear.Amal_nuke_hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
	gear.Amal_nuke_legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
	gear.Amal_nuke_feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
	
	gear.Amal_dark_body={ name="Amalric Doublet", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}}
	gear.Amal_dark_hands={ name="Amalric Gages", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}}
	gear.Amal_dark_legs={ name="Amalric Slops", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}}
    
	-- Herculean
	gear.Herc_TP_hands 	= { name="Herculean Gloves", augments={'Accuracy+22 Attack+22','"Triple Atk."+3','MND+9','Accuracy+10','Attack+10',}}
	gear.Herc_TP_feet 	= { name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Triple Atk."+4','VIT+4',}}
	gear.Herc_TP_body	= { name="Herculean Vest", augments={'Accuracy+29','"Triple Atk."+3','AGI+3','Attack+15',}}
	
	gear.Herc_Acc_feet = { name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Triple Atk."+1','Accuracy+14','Attack+13',}}
	
	gear.Herc_CDC_body 	= { name="Herculean Vest", augments={'Accuracy+25 Attack+25','Crit. hit damage +3%','DEX+10','Accuracy+13','Attack+1',}}
	gear.Herc_CDC_hands = { name="Herculean Gloves", augments={'Accuracy+20','Crit. hit damage +3%','DEX+13',}}
	
	gear.Herc_SB_body	= { name="Herculean Vest", augments={'Attack+22','Weapon skill damage +4%','STR+6','Accuracy+15',}}
	gear.Herc_SB_head 	= { name="Herculean Helm", augments={'Weapon skill damage +3%','STR+14','Accuracy+10',}}
	gear.Herc_SB_legs 	= { name="Herculean Trousers", augments={'Attack+25','Weapon skill damage +4%','STR+13','Accuracy+8',}}
	gear.Herc_SB_feet 	= { name="Herculean Boots", augments={'Rng.Atk.+13','Weapon skill damage +3%','STR+11','Accuracy+13','Attack+3',}}
	
	
	gear.Herc_MAB_head 	= { name="Herculean Helm", augments={'"Store TP"+1','"Mag.Atk.Bns."+23','Magic Damage +21','Accuracy+17 Attack+17','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
	gear.Herc_MAB_hands = { name="Herculean Gloves", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Weapon skill damage +3%','MND+1','"Mag.Atk.Bns."+15',}}
	gear.Herc_MAB_legs 	= { name="Herculean Trousers", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','STR+5','"Mag.Atk.Bns."+14',}}
	gear.Herc_MAB_feet 	= { name="Herculean Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +2%','MND+5','"Mag.Atk.Bns."+14',}}
	
	gear.Herc_RA_head = { name="Herculean Helm", augments={'Rng.Acc.+20 Rng.Atk.+20','AGI+15',}}
    	gear.Herc_RA_legs = { name="Herculean Trousers", augments={'Rng.Acc.+25 Rng.Atk.+25','AGI+11','Rng.Acc.+3','Rng.Atk.+14',}}
	
	gear.Herc_Ref_head={ name="Herculean Helm", augments={'Enmity-1','Attack+20','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+11 "Mag.Atk.Bns."+11',}}
	gear.Herc_Ref_hands = { name="Herculean Gloves", augments={'Accuracy+14','STR+6','"Refresh"+2',}}
	gear.Herc_Ref_feet 	= { name="Herculean Boots", augments={'Attack+17','VIT+6','"Refresh"+2',}}
	
	gear.Herc_Reso_feet	={ name="Herculean Boots", augments={'"Triple Atk."+1','STR+14','Accuracy+15','Attack+12',}}
	gear.Herc_Reso_hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','"Triple Atk."+1','STR+10','Accuracy+11',}}
	
	gear.Herc_DT_head = { name="Herculean Helm", augments={'"Fast Cast"+1','Weapon Skill Acc.+12','Damage taken-4%',}}
	gear.Herc_DT_hands = { name="Herculean Gloves", augments={'Damage taken-4%','AGI+7','Accuracy+12',}}
	
	gear.Herc_TH_head = { name="Herculean Helm", augments={'INT+6','Pet: Haste+1','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+10 "Mag.Atk.Bns."+10',}}
	
	-- Merlinic
	gear.Merl_nuke_head = { name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Magic burst dmg.+10%','INT+2','Mag. Acc.+1',}}
	gear.Merl_nuke_body = "Merlinic Jubbah"
	gear.Merl_nuke_legs	= { name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+5%','CHR+8','Mag. Acc.+12','"Mag.Atk.Bns."+12',}}
	gear.Merl_nuke_feet	= { name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic burst dmg.+8%','INT+3','Mag. Acc.+9','"Mag.Atk.Bns."+13',}}
	
	gear.Merl_MB_head 	= gear.Merl_nuke_head
	gear.Merl_MB_body 	= gear.Merl_nuke_body
	gear.Merl_MB_legs 	= gear.Merl_nuke_legs
	gear.Merl_MB_feet	= gear.Merl_nuke_feet
	
	gear.Merl_Ref_hands = { name="Merlinic Dastanas", augments={'Phys. dmg. taken -1%','Pet: "Dbl. Atk."+2','"Refresh"+1',}}
	
	gear.Merl_FC_head	= { name="Merlinic Hood", augments={'"Fast Cast"+5','Mag. Acc.+3','"Mag.Atk.Bns."+12',}}
	gear.Merl_FC_legs 	= { name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Fast Cast"+5','MND+8','Mag. Acc.+6','"Mag.Atk.Bns."+12',}}
	gear.Merl_FC_feet	= { name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+10','"Fast Cast"+6','INT+2','Mag. Acc.+15',}}
	
	gear.Merl_dark_feet	= { name="Merlinic Crackows", augments={'Attack+25','"Drain" and "Aspir" potency +11','MND+8',}}
	
	-- Chironic
	gear.Chir_nuke_hands= { name="Chironic Gloves", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','"Cure" potency +10%','Mag. Acc.+6','"Mag.Atk.Bns."+12',}}
	gear.Chir_ref_hands	= { name="Chironic Gloves", augments={'Attack+11','INT+2','"Refresh"+2','Accuracy+11 Attack+11','Mag. Acc.+8 "Mag.Atk.Bns."+8',}}
	
	-- Valor
	gear.Valor_STP_body = { name="Valorous Mail", augments={'Accuracy+26','"Store TP"+6','DEX+10','Attack+15',}}
	gear.Valor_DA_body 	= { name="Valorous Mail", augments={'Accuracy+14 Attack+14','"Dbl.Atk."+4','STR+8','Attack+9',}}
	gear.Valor_DA_feet	= { name="Valorous Greaves", augments={'Accuracy+11','"Dbl.Atk."+5','STR+7','Attack+4',}}
	gear.Valor_STP_legs = { name="Valor. Hose", augments={'Accuracy+28','"Store TP"+6','STR+7',}}
	
	
	gear.Valor_WSD_head	={ name="Valorous Mask", augments={'Attack+2','Weapon skill damage +4%','STR+12','Accuracy+15',}}
	gear.Valor_WSD_body	={ name="Valorous Mail", augments={'Accuracy+25','Weapon skill damage +4%','STR+8','Attack+12',}}
	gear.Valor_WSD_legs	={ name="Valor. Hose", augments={'Accuracy+7 Attack+7','Weapon skill damage +4%','Accuracy+10',}}
	gear.Valor_WSD_feet	={ name="Valorous Greaves", augments={'Accuracy+17 Attack+17','Weapon skill damage +3%','STR+10','Accuracy+5','Attack+5',}}
    	gear.Valor_WSD_hands={ name="Valorous Mitts", augments={'Accuracy+24','Weapon skill damage +4%','AGI+8','Attack+15',}}
	
	
	-- Odyssean
	gear.Ody_phalanx_head={ name="Odyssean Helm", augments={'Accuracy+5','STR+7','Phalanx +3',}}
    gear.Ody_phalanx_legs={ name="Odyssean Cuisses", augments={'CHR+5','Attack+25','Phalanx +2','Mag. Acc.+15 "Mag.Atk.Bns."+15',}}
	gear.Ody_phalanx_body={ name="Odyss. Chestplate", augments={'Pet: "Mag.Atk.Bns."+25','"Repair" potency +1%','Phalanx +2','Accuracy+3 Attack+3','Mag. Acc.+2 "Mag.Atk.Bns."+2',}}
	
	gear.Ody_CP_feet={ name="Odyssean Greaves", augments={'Mag. Acc.+17','"Cure" potency +5%','MND+1',},priority=0}
	
	gear.Ody_FC_legs={ name="Odyssean Cuisses", augments={'Mag. Acc.+2','"Fast Cast"+5','MND+3',},priority=1}
	gear.Ody_FC_feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+5','Mag. Acc.+7',}}
	
	-- Taeon
	gear.Taeon_SNAP_head = { name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}}
	gear.Taeon_SNAP_body = { name="Taeon Tabard", augments={'"Snapshot"+5','"Snapshot"+4',}}

	gear.Taeon_FC_body = { name="Taeon Tabard", augments={'"Fast Cast"+4',}}
	
	-- Telchine
	gear.Telchine_enh_body = { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +7',}}
	gear.Telchine_enh_head = { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}}
    gear.Telchine_enh_hands = { name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}}
	gear.Telchine_enh_legs = { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +8',}}
	gear.Telchine_enh_feet = { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}}
	gear.Telchine_CPR_hands = { name="Telchine Gloves", augments={'Potency of "Cure" effect received+7%',}}
    
	
	-- Yorium
	gear.Yorium_enm_hands = { name="Yorium Gauntlets", augments={'Enmity+7',},priority=1}
	
	-- Ambuscade Capes
	-- RNG
	gear.RNG_WSPhys_Cape 	= { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}
	gear.RNG_WSMagic_Cape 	= gear.RNG_WSPhys_Cape
	gear.RNG_SNAP_Cape 		= { name="Belenus's Cape", augments={'"Snapshot"+10',}}
	gear.RNG_RA_Cape 		= { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	gear.RNG_TP_Cape 		= gear.RNG_RA_Cape
	
	-- COR
	gear.COR_WSMagic_Cape 	= { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.COR_WSPhys_Cape 	= { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.COR_SB_Cape 		= { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.COR_SNAP_Cape 		= { name="Camulus's Mantle", augments={'"Snapshot"+10',}}
	gear.COR_RA_Cape 		= { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	gear.COR_TP_Cape 		= { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.COR_DW_Cape		= { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10',}}
	
	-- SCH
	gear.SCH_nuke_Cape 	= { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.SCH_FC_Cape 	= { name="Lugh's Cape", augments={'INT+1','"Fast Cast"+10',}}
	
	-- BLM
	gear.BLM_nuke_Cape	= { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.BLM_death_Cape	= { name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	gear.BLM_FC_Cape 	= "Swith Cape +1"
	
	-- BLU
	gear.BLU_TP_Cape	= { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.BLU_CDC_Cape	= { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	gear.BLU_SB_Cape	= { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.BLU_nuke_Cape	= { name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
	
	-- RUN
	gear.RUN_STRWS_Cape = { name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}
	gear.RUN_DEXWS_Cape = { name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
	gear.RUN_TP_Cape 	= { name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	gear.RUN_tank_Cape 	= { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Parrying rate+5%',}}
	gear.RUN_FC_Cape  	= { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}
	

	-- GEO
	gear.GEO_pet_Cape	= { name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}}
    gear.GEO_nuke_Cape	= { name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	
	-- THF
	gear.THF_WS_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    gear.THF_TP_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	
	-- RDM
	gear.RDM_MND_Cape = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20',}}
    gear.RDM_INT_Cape ={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	
	-- SAM
	gear.SAM_TP_Cape = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	gear.SAM_WS_Cape = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	
	-- PLD
	gear.PLD_tank_Cape 	= { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10',},priority=15}
	gear.PLD_FC_Cape 	= { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}}
	gear.PLD_TP_Cape 	= { name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.PLD_WS_Cape 	= gear.PLD_TP_Cape
	
	-- DRG
	gear.DRG_WSDA_Cape	= { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.DRG_WSD_Cape	= { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
    gear.DRG_TP_Cape	= { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	
	-- SMN
	gear.SMN_Phys_Cape	= { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20',}}
	
	-- MNK
	gear.MNK_TP_Cape 	= { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
    gear.MNK_WS_Cape	= gear.MNK_TP_Cape
	
	-- DNC
	gear.DNC_TP_Cape 	= { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.DNC_WS_Cape 	= { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	
	-- WHM
	gear.WHM_FC_Cape 	= { name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
	
	-- Others
	gear.dark_ring = { name="Dark Ring", augments={'Spell interruption rate down -3%','Phys. dmg. taken -6%','Magic dmg. taken -4%',}}
	
	-- Crafting gear
	sets.crafting={
		sub="Toreutic Ecu",
		head="Shaded Specs.",
		neck="Goldsm. Torque",
		body="Goldsmith's Smock",
		hands="Alchemist's Cuffs",
		left_ring="Orvail Ring",
		right_ring="Craftmaster's Ring",
	}
	
	sets.fishing={
		range="Lu Shang's F. Rod",
		head="Tlahtlamah Glasses",
		body="Fisherman's Smock",
		hands="Fsh. Gloves",
		legs="Angler's Hose",
		feet="Waders",
		left_ring="Pelican Ring",
	}
	
end
