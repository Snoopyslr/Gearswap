-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
	state.IdleMode:options('Normal', 'Sphere','Town')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.Weapons:options('Mandau','HighDmg','MagicWeapons','KrakenClub')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None','Suppa','DWEarrings','DWMax'}
	state.AmbushMode = M(false, 'Ambush Mode')

	gear.da_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.wsd_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind !` input /ra <t>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace gs c weapons Throwing;gs c update')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {hands="Plunderer's Armlets +1",feet="Skulk. Poulaines +1"})
    sets.ExtraRegen = {}
    sets.Kiting = {feet="Skadi's Jambeaux +1"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
    sets.buff['Sneak Attack'] = {}
    sets.buff['Trick Attack'] = {}
		
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.Suppa = {ear1="Suppanomimi", ear2="Sherida Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket",hands="Floral Gauntlets",waist="Reiki Yotai"}
	sets.Ambush = {} --body="Plunderer's Vest +1"
	
	-- Weapons sets
	sets.weapons.Mandau = {main="Mandau",sub="Odium"}
	sets.weapons.HighDmg = {main="Taming Sari",sub="Odium"}
	sets.weapons.MagicWeapons = {main="Malevolence",sub="Malevolence"}
	sets.weapons.KrakenClub = {main="Mandau",sub="Kraken Club"}


	
    -- Actions we want to use to tag TH.
    sets.precast.Step = {ammo="Falcon Eye",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Telos Earring",ear2="Digni. Earring",
        body="Mummu Jacket +2",hands="Adhemar Wrist. +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.da_jse_back,waist="Olseni Belt",legs="Mummu Kecks +2",feet=gear.herculean_acc_feet}
		
    sets.precast.JA['Violent Flourish'] = {ammo="Falcon Eye",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Telos Earring",ear2="Digni. Earring",
        body="Mummu Jacket +2",hands="Adhemar Wrist. +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.da_jse_back,waist="Olseni Belt",legs="Mummu Kecks +2",feet=gear.herculean_acc_feet}
		
	sets.precast.JA['Animated Flourish'] = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {} --head="Skulker's Bonnet"
    sets.precast.JA['Accomplice'] = {} --head="Skulker's Bonnet"
    sets.precast.JA['Flee'] = {} --feet="Pillager's Poulaines +1"
    sets.precast.JA['Hide'] = {} --body="Pillager's Vest +1"
    sets.precast.JA['Conspirator'] = {} --body="Skulker's Vest"
    sets.precast.JA['Steal'] = {hands="Pill. Armlets +1"}
	sets.precast.JA['Mug'] = {}
    sets.precast.JA['Despoil'] = {legs="Skulker's Culottes",feet="Skulk. Poulaines +1"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Yamarang",
        head="Mummu Bonnet +2",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Handler's Earring +1",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        back="Moonlight Cape",waist="Chaac Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}

	sets.Self_Waltz = {head="Mummu Bonnet +2",body="Passion Jacket",ring1="Asklepian Ring"}
		
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Impatiens",
		head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
		legs="Rawhide Trousers"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


    -- Ranged snapshot gear
    sets.precast.RA = {range="Comet Tail"}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
	ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
    body="Meg. Cuirie +1",
    hands="Meg. Gloves +1",
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+18 Attack+18','Crit. hit damage +4%','DEX+5','Accuracy+1','Attack+11',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Regal Ring",
    right_ring="Ilabrat Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	}
	
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque"})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {neck="Combatant's Torque",ear1="Telos Earring",body="Meg. Cuirie +2",waist="Olseni Belt",legs="Meg. Chausses +2",feet=gear.herculean_acc_feet})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque",ear1="Telos Earring",body="Meg. Cuirie +2",waist="Olseni Belt",legs="Meg. Chausses +2",feet=gear.herculean_acc_feet})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body="Adhemar Jacket",back=gear.wsd_jse_back})
    sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.wsd_jse_back})
    sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {body=gear.herculean_wsd_body})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet +1",body="Meg. Cuirie +2",legs="Darraigner's Brais"})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet +1",body="Meg. Cuirie +2",legs="Darraigner's Brais"})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet +1",body="Meg. Cuirie +2",legs="Darraigner's Brais"})

    sets.precast.WS["Mandalic Stab"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
    sets.precast.WS["Mandalic Stab"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
    sets.precast.WS["Mandalic Stab"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
	sets.precast.WS["Mandalic Stab"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.wsd_jse_back})
    sets.precast.WS["Mandalic Stab"].Fodder = set_combine(sets.precast.WS["Mandalic Stab"], {body=gear.herculean_wsd_body})
    sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet +1",body="Meg. Cuirie +2",legs="Darraigner's Brais"})
    sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet +1",body="Meg. Cuirie +2",legs="Darraigner's Brais"})
    sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet +1",body="Meg. Cuirie +2",legs="Darraigner's Brais"})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
    sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",body="Meg. Cuirie +2",back=gear.wsd_jse_back})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.wsd_jse_back})
    sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {body=gear.herculean_wsd_body})
    sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet +1",body="Meg. Cuirie +2",legs="Darraigner's Brais"})
    sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet +1",body="Meg. Cuirie +2",legs="Darraigner's Brais"})
    sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Yetshila",head="Adhemar Bonnet +1",body="Meg. Cuirie +2",legs="Darraigner's Brais"})
	
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Yetshila",head="Adhemar Bonnet +1",neck="Fotia Gorget",body="Abnoba Kaftan",hands="Mummu Wrists +2",ring1="Begrudging Ring",waist="Fotia Belt",legs="Darraigner's Brais",feet="Mummu Gamash. +2"})
    sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Adhemar Bonnet +1",neck="Fotia Gorget",body="Abnoba Kaftan",hands="Mummu Wrists +2",ring1="Begrudging Ring",waist="Fotia Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {head="Mummu Bonnet +2",ring1="Begrudging Ring",neck="Fotia Gorget",body="Sayadio's Kaftan",hands="Mummu Wrists +2",waist="Fotia Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {head="Mummu Bonnet +2",body="Mummu Jacket +2",hands="Mummu Wrists +2",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})

    sets.precast.WS['Last Stand'] = {
        head="Mummu Bonnet +2",neck="Fotia Gorget",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.wsd_jse_back,waist="Fotia Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"}

    sets.precast.WS['Aeolian Edge'] = {
	ammo="Seeth. Bomblet +1",
    head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+25','Mag. Acc.+23 "Mag.Atk.Bns."+23','Accuracy+16 Attack+16',}},
    body={ name="Samnuha Coat", augments={'Mag. Acc.+9','"Mag.Atk.Bns."+10','"Fast Cast"+2',}},
    hands={ name="Herculean Gloves", augments={'Mag. Acc.+5','"Mag.Atk.Bns."+26','Accuracy+18 Attack+18','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Accuracy+18 Attack+18','Crit. hit damage +4%','DEX+5','Accuracy+1','Attack+11',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Regal Ring",
    right_ring="Ilabrat Ring",
    back="Toro Cape"
	}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Sherida Earring"}
	sets.AccMaxTP = {ear1="Zennaroi Earring",ear2="Sherida Earring"}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
        back="Moonlight Cape",waist="Tempus Fugit",legs="Rawhide Trousers",feet=gear.herculean_dt_feet}

    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})

	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)

    -- Ranged gear

    sets.midcast.RA = {
        head="Mummu Bonnet +2",neck="Combatant's Torque",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.da_jse_back,waist="Chaac Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"}

    sets.midcast.RA.Acc = {
        head="Mummu Bonnet +2",neck="Combatant's Torque",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Mummu Jacket +2",hands="Mummu Wrists +2",ring1="Apate Ring",ring2="Regal Ring",
        back=gear.da_jse_back,waist="Chaac Belt",legs="Mummu Kecks +2",feet="Mummu Gamash. +2"}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +2",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Sheltered Ring",
        back="Moonlight Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}
		
    sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})

    sets.idle.Weak = set_combine(sets.idle, {})
	
	sets.idle.Town ={
	ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
    body={ name="Herculean Vest", augments={'Accuracy+22','"Drain" and "Aspir" potency +5','Quadruple Attack +3',}},
    hands={ name="Herculean Gloves", augments={'"Counter"+1','Enmity-7','Quadruple Attack +2','Accuracy+9 Attack+9',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Phys. dmg. taken -3%','AGI+7','Quadruple Attack +3','Accuracy+3 Attack+3','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    neck="Combatant's Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	}

	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Defense sets

    sets.defense.PDT = {
	ammo="Staunch Tathlum",
    head="Meghanada Visor +1",
    body="Meg. Cuirie +1",
    hands="Meg. Gloves +1",
    legs="Meg. Chausses +1",
    feet="Meg. Jam. +1",
    neck="Twilight Torque",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Ethereal Earring",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape"
	}

    sets.defense.MDT = {
	ammo="Staunch Tathlum",
    head="Meghanada Visor +1",
    body="Meg. Cuirie +1",
    hands="Meg. Gloves +1",
    legs="Meg. Chausses +1",
    feet="Meg. Jam. +1",
    neck="Twilight Torque",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Ethereal Earring",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape"
	}
		
	sets.defense.MEVA = {
	ammo="Staunch Tathlum",
    head="Meghanada Visor +1",
    body="Meg. Cuirie +1",
    hands="Meg. Gloves +1",
    legs="Meg. Chausses +1",
    feet="Meg. Jam. +1",
    neck="Twilight Torque",
    waist="Flume Belt +1",
    left_ear="Etiolation Earring",
    right_ear="Ethereal Earring",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back="Moonbeam Cape"
	}


    --------------------------------------
    -- Melee sets  
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
	ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
    body={ name="Herculean Vest", augments={'Accuracy+22','"Drain" and "Aspir" potency +5','Quadruple Attack +3',}},
    hands={ name="Herculean Gloves", augments={'"Counter"+1','Enmity-7','Quadruple Attack +2','Accuracy+9 Attack+9',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Phys. dmg. taken -3%','AGI+7','Quadruple Attack +3','Accuracy+3 Attack+3','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    neck="Combatant's Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	}
		
    sets.engaged.SomeAcc = {
	ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
    body={ name="Herculean Vest", augments={'Accuracy+22','"Drain" and "Aspir" potency +5','Quadruple Attack +3',}},
    hands={ name="Herculean Gloves", augments={'"Counter"+1','Enmity-7','Quadruple Attack +2','Accuracy+9 Attack+9',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Phys. dmg. taken -3%','AGI+7','Quadruple Attack +3','Accuracy+3 Attack+3','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    neck="Combatant's Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	}
    
	sets.engaged.Acc = {
	ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
    body={ name="Herculean Vest", augments={'Accuracy+22','"Drain" and "Aspir" potency +5','Quadruple Attack +3',}},
    hands={ name="Herculean Gloves", augments={'"Counter"+1','Enmity-7','Quadruple Attack +2','Accuracy+9 Attack+9',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Phys. dmg. taken -3%','AGI+7','Quadruple Attack +3','Accuracy+3 Attack+3','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    neck="Combatant's Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	}
		
    sets.engaged.FullAcc = {
	ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
    body={ name="Herculean Vest", augments={'Accuracy+22','"Drain" and "Aspir" potency +5','Quadruple Attack +3',}},
    hands={ name="Herculean Gloves", augments={'"Counter"+1','Enmity-7','Quadruple Attack +2','Accuracy+9 Attack+9',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Phys. dmg. taken -3%','AGI+7','Quadruple Attack +3','Accuracy+3 Attack+3','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    neck="Combatant's Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	}

    sets.engaged.Fodder = {
	ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
    body={ name="Herculean Vest", augments={'Accuracy+22','"Drain" and "Aspir" potency +5','Quadruple Attack +3',}},
    hands={ name="Herculean Gloves", augments={'"Counter"+1','Enmity-7','Quadruple Attack +2','Accuracy+9 Attack+9',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Phys. dmg. taken -3%','AGI+7','Quadruple Attack +3','Accuracy+3 Attack+3','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    neck="Combatant's Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	}

    sets.engaged.PDT = {
	ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
    body={ name="Herculean Vest", augments={'Accuracy+22','"Drain" and "Aspir" potency +5','Quadruple Attack +3',}},
    hands={ name="Herculean Gloves", augments={'"Counter"+1','Enmity-7','Quadruple Attack +2','Accuracy+9 Attack+9',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Phys. dmg. taken -3%','AGI+7','Quadruple Attack +3','Accuracy+3 Attack+3','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    neck="Combatant's Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	}

    sets.engaged.SomeAcc.PDT = {
	ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
    body={ name="Herculean Vest", augments={'Accuracy+22','"Drain" and "Aspir" potency +5','Quadruple Attack +3',}},
    hands={ name="Herculean Gloves", augments={'"Counter"+1','Enmity-7','Quadruple Attack +2','Accuracy+9 Attack+9',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Phys. dmg. taken -3%','AGI+7','Quadruple Attack +3','Accuracy+3 Attack+3','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    neck="Combatant's Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	}
		
    sets.engaged.Acc.PDT = {
	ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
    body={ name="Herculean Vest", augments={'Accuracy+22','"Drain" and "Aspir" potency +5','Quadruple Attack +3',}},
    hands={ name="Herculean Gloves", augments={'"Counter"+1','Enmity-7','Quadruple Attack +2','Accuracy+9 Attack+9',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Phys. dmg. taken -3%','AGI+7','Quadruple Attack +3','Accuracy+3 Attack+3','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    neck="Combatant's Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	}

    sets.engaged.FullAcc.PDT = {
	ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
    body={ name="Herculean Vest", augments={'Accuracy+22','"Drain" and "Aspir" potency +5','Quadruple Attack +3',}},
    hands={ name="Herculean Gloves", augments={'"Counter"+1','Enmity-7','Quadruple Attack +2','Accuracy+9 Attack+9',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Phys. dmg. taken -3%','AGI+7','Quadruple Attack +3','Accuracy+3 Attack+3','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    neck="Combatant's Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	}
		
    sets.engaged.Fodder.PDT = {
	ammo="Seeth. Bomblet +1",
    head={ name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}},
    body={ name="Herculean Vest", augments={'Accuracy+22','"Drain" and "Aspir" potency +5','Quadruple Attack +3',}},
    hands={ name="Herculean Gloves", augments={'"Counter"+1','Enmity-7','Quadruple Attack +2','Accuracy+9 Attack+9',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Phys. dmg. taken -3%','AGI+7','Quadruple Attack +3','Accuracy+3 Attack+3','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
    neck="Combatant's Torque",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Oneiros Ring",
    right_ring="Epona's Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 3)
    else
        set_macro_page(1, 3)
    end
end
