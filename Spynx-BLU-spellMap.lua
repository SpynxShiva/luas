-- Mappings for gear sets to use for various blue magic spells.
blue_magic_maps = {}

---------------------------
----- Physical Spells -----
---------------------------

blue_magic_maps.Physical = S{'Bilgestorm'}
blue_magic_maps.PhysicalAcc = S{'Heavy Strike'}

blue_magic_maps.PhysicalStr = S{
	'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
	'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
	'Uppercut','Vertical Cleave'
}
	
blue_magic_maps.PhysicalDex = S{
	'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
	'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
	'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
	'Vanity Dive'
}
	
blue_magic_maps.PhysicalVit = S{
	'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
	'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
}
	
blue_magic_maps.PhysicalAgi = S{
	'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
	'Pinecone Bomb','Spiral Spin','Wild Oats'
}

blue_magic_maps.PhysicalInt = S{
	'Mandibular Bite','Queasyshroom'
}

blue_magic_maps.PhysicalMnd = S{
	'Ram Charge','Screwdriver','Tourbillion'
}

blue_magic_maps.PhysicalChr = S{'Bludgeon'}

blue_magic_maps.PhysicalHP = S{'Final Sting'}

---------------------------
----- Magical Spells ------
---------------------------

blue_magic_maps.Magical = S{
	'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere',
	'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
	'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
	'Retinal Glare','Subduction','Tem. Upheaval','Water Bomb','Searing Tempest',
	'Blinding Fulgor','Spectral Floe','Scouring Spate','Anvil Lightning','Silent Storm',
	'Entomb'
}

blue_magic_maps.MagicalDark = S{
	'Dark Orb','Death Ray','Eyes On Me','Evryone. Grudge','Palling Salvo','Tenebral Crush'
}

blue_magic_maps.MagicalMnd = S{
	'Acrid Stream','Magic Hammer','Mind Blast'
}

blue_magic_maps.MagicalChr = S{
	'Mysterious Light'
}

blue_magic_maps.MagicalVit = S{'Thermal Pulse'}

blue_magic_maps.MagicalDex = S{
	'Charged Whisker','Gates of Hades'
}
		
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
	
blue_magic_maps.Breath = S{
	'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
	'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
	'Thunder Breath','Vapor Spray','Wind Breath'
}

blue_magic_maps.Stun = S{
	'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
	'Thunderbolt','Whirl of Rage'
}

---------------------------
----- Other Spells -----
---------------------------

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