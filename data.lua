local modname = "__Age_of_Empires_II_soundpack__"
local vol = 15

local function makeSound(sound, volume)
  if not volume then volume = vol end
  return { filename = modname .. "/sounds/" .. sound .. ".ogg", volume = volume / 10 }
end

local function makeCustomSound(sound, volume)
  if not volume then volume = vol end
  return { filename = modname .. "/sounds/customsounds/" .. sound .. ".ogg", volume = volume / 10 }
end

local function replaceProtoSound(type, name, property, sound, var_num, volume)
  if data.raw[type] and data.raw[type][name] then
    data.raw[type][name][property] = {variations = {}}
    if var_num == 1 then
      data.raw[type][name][property].variations = makeSound(sound, volume)
    else
      for i=1, var_num do
        table.insert(data.raw[type][name][property].variations, {filename = modname.."/sounds/" .. sound .. i .. ".ogg", volume = volume / 10})
      end
    end
  end
end

local function replaceAllBaseSounds(type, name, sound)
  if data.raw[type][name] then
    if sound then
      replaceProtoSound(type, name, "build_sound", sound, 1, vol)
      replaceProtoSound(type, name, "open_sound", sound, 1, vol)
    end
    replaceProtoSound(type, name, "mined_sound", "missile_impact", 4, vol)
    replaceProtoSound(type, name, "close_sound", "empty", 1, 15)
  end
end

local typeCorrespondences = {
  {"assembling-machine", "town_center"},
  {"lab", "university"},
  {"furnace", "blacksmith"},
  {"rocket-silo", "wonder"},
  {"offshore-pump", "dock"},
  {"pump", "dock"},
  {"container", "house"},
  {"linked-container", "house"},
  {"infinity-container", "house"},
  {"logistic-container", "house"},
  {"storage-tank", "house"},
  {"gate", "gate"},
  {"wall", "wall"},
  {"curved-rail-a", "wall"},
  {"elevated-curved-rail-a", "wall"},
  {"curved-rail-b", "wall"},
  {"elevated-curved-rail-b", "wall"},
  {"half-diagonal-rail", "wall"},
  {"elevated-half-diagonal-rail", "wall"},
  {"straight-rail", "wall"},
  {"elevated-straight-rail", "wall"},
  {"rail-ramp", "wall"},
  {"rail-support", "wall"},
  {"radar", "tower"},
  {"ammo-turret", "tower"},
  {"electric-turret", "tower"},
  {"fluid-turret", "tower"},
  {"turret", "tower"},
  {"land-mine", "tower"},
  {"generator", "mill"},
  {"fusion-generator", "mill"},
  {"reactor", "mill"},
  {"accumulator", "mill"},
  {"solar-panel", "mill"},
  {"mining-drill", "mining_camp"},
  {"roboport", "castle"},
  {"beacon", "monastery"},
  {"lamp", "monastery"},
  {"electric-pole", "woodchop1"},
  {"transport-belt", "build1"},
  {"underground-belt", "build2"},
  {"splitter", "build2"},
  {"pipe", "fishing"},
  {"pipe-to-ground", "fish_trap"},
  {"heat-pipe", "fireball5"},
  {"boiler", "fireball4"},
  {"combat-robot", "military_spawn"},
  {"car", "trebuchet_select"},
  {"artillery-wagon", "siege_workshop"},
  {"artillery-turret", "siege_workshop"},
  {"spider-vehicle", "horse_select1"},
  {"inserter", "mine2"},
  {"locomotive", "mangonel_select"},
  {"fluid-wagon", "mangonel_select"},
  {"cargo-wagon", "mangonel_select"},
  {"train-stop", "herdables_found"},
  {"rail-signal", "herdables_found"},
  {"rail-chain-signal", "herdables_found"},
  {"space-platform-hub", "ship_spawn"},
  {"cargo-wagon", "house"},
  {"fluid-wagon", "house"},
  {"artillery-wagon", "tower"},
  {"asteroid-collector", "siege_workshop"},
  {"agricultural-tower", "farm"},
}

for _, corr in pairs(typeCorrespondences) do
  for _, entity in pairs(data.raw[corr[1]]) do
    replaceAllBaseSounds(corr[1], entity.name, corr[2])
  end
end

for _, entity in pairs(data.raw["gate"]) do
  replaceProtoSound(type, entity.name, "closing_sound", "gate_lock", 1, 15)
  replaceProtoSound(type, entity.name, "opening_sound", "gate_unlock", 1, 15)
end

replaceAllBaseSounds("mining-drill", "pumpjack", "ship_move3")
replaceAllBaseSounds("car", "tank", "scorpion_select")
replaceAllBaseSounds("furnace", "recycler", "archery_range")
replaceAllBaseSounds("assembling-machine", "cryogenic-plant", "town_bell2")
replaceAllBaseSounds("assembling-machine", "biochamber", "farm")
replaceAllBaseSounds("assembling-machine", "captive-biter-spawner", "enemy_convert_success")

-- WORKING SOUNDS

local function replaceProtoWorkingSound(type, name, sound, volume, proba)
  if not volume then volume = 10 end
  if data.raw[type] and data.raw[type][name] then
    if not data.raw[type][name].working_sound then data.raw[type][name].working_sound = {} end
    data.raw[type][name].working_sound.sound = {filename = modname.."/sounds/" .. sound .. ".ogg", volume = volume / 10}
    if proba then
      data.raw[type][name].working_sound.probability = proba
    end
  end
end

replaceProtoWorkingSound("furnace", "stone-furnace", "ambiance_fire", vol)
replaceProtoWorkingSound("furnace", "electric-furnace", "ambiance_fire", vol)
replaceProtoWorkingSound("furnace", "steel-furnace", "ambiance_fire", vol)
replaceProtoWorkingSound("assembling-machine", "foundry", "ambiance_fire", vol)
replaceProtoWorkingSound("assembling-machine", "assembling-machine-1", "war_wagon", vol)
replaceProtoWorkingSound("assembling-machine", "assembling-machine-2", "war_wagon", vol)
replaceProtoWorkingSound("assembling-machine", "assembling-machine-3", "war_wagon", vol)
replaceProtoWorkingSound("mining-drill", "electric-mining-drill", "mine3", vol)
replaceProtoWorkingSound("mining-drill", "electric-mining-drill", "mine2", vol)
replaceProtoWorkingSound("mining-drill", "big-mining-drill", "mine1", vol)
replaceProtoWorkingSound("mining-drill", "pumpjack", "trebuchet_pullback3", vol)
replaceProtoWorkingSound("radar", "radar", "ambiance_cricket", vol-8)
replaceProtoWorkingSound("offshore-pump", "offshore-pump", "ambiance_wave1", vol-8)
replaceProtoWorkingSound("pump", "pump", "ambiance_wave2", vol-8)
replaceProtoWorkingSound("transport-belt", "transport-belt", "trebuchet_move", vol-8)
replaceProtoWorkingSound("transport-belt", "fast-transport-belt", "trebuchet_move", vol-8)
replaceProtoWorkingSound("transport-belt", "express-transport-belt", "trebuchet_move", vol-8)
replaceProtoWorkingSound("transport-belt", "turbo-transport-belt", "trebuchet_move", vol-8)
replaceProtoWorkingSound("underground-belt", "underground-belt", "trebuchet_move", vol-8)
replaceProtoWorkingSound("underground-belt", "fast-underground-belt", "trebuchet_move", vol-8)
replaceProtoWorkingSound("underground-belt", "express-underground-belt", "trebuchet_move", vol-8)
replaceProtoWorkingSound("underground-belt", "turbo-underground-belt", "trebuchet_move", vol-8)
replaceProtoWorkingSound("splitter", "splitter", "war_wagon", vol)
replaceProtoWorkingSound("splitter", "fast-splitter", "war_wagon", vol)
replaceProtoWorkingSound("splitter", "express-splitter", "war_wagon", vol)
replaceProtoWorkingSound("splitter", "turbo-splitter", "war_wagon", vol)
replaceProtoWorkingSound("electric-pole", "small-electric-pole", "ambiance_wind3", vol-8)
replaceProtoWorkingSound("electric-pole", "big-electric-pole", "ambiance_wind3", vol-8)
replaceProtoWorkingSound("electric-pole", "medium-electric-pole", "ambiance_wind3", vol-8)
replaceProtoWorkingSound("electric-pole", "substation", "ambiance_wind3", vol-8)
replaceProtoWorkingSound("beam", "laser-beam", "ambiance_fire", vol+5)
replaceProtoWorkingSound("beam", "chain-tesla-turret-beam-start", "siege_weapon_move", vol+5)
replaceProtoWorkingSound("beam", "chain-tesla-gun-beam-start", "siege_weapon_move", vol+5)
replaceProtoWorkingSound("beam", "chain-tesla-turret-beam-bounce", "siege_weapon_move", vol+5)
replaceProtoWorkingSound("beam", "chain-tesla-gun-beam-bounce", "siege_weapon_move", vol+5)
replaceProtoWorkingSound("inserter", "inserter", "whoosh", vol-7)
replaceProtoWorkingSound("inserter", "fast-inserter", "whoosh", vol-7)
replaceProtoWorkingSound("inserter", "long-handed-inserter", "whoosh", vol-7)
replaceProtoWorkingSound("inserter", "burner-inserter", "whoosh", vol-7)
replaceProtoWorkingSound("inserter", "bulk-inserter", "whoosh", vol-7)
replaceProtoWorkingSound("inserter", "stack-inserter", "whoosh", vol-7)
replaceProtoWorkingSound("electric-turret", "tesla-turret", "ambiance_cricket", vol-7)
replaceProtoWorkingSound("beacon", "beacon", "monk_spawn", 3)
replaceProtoWorkingSound("generator", "steam-engine", "ambiance_mill_turn", vol-7)
replaceProtoWorkingSound("generator", "steam-turbine", "mill", vol-7)
replaceProtoWorkingSound("fusion-generator", "fusion-generator", "mill", vol-7)
replaceProtoWorkingSound("reactor", "nuclear-reactor", "ambiance_fire", vol)
replaceProtoWorkingSound("fusion-reactor", "fusion-reactor", "ambiance_fire", vol)
replaceProtoWorkingSound("reactor", "heating-tower", "ambiance_fire", vol)
replaceProtoWorkingSound("storage-tank", "storage-tank", "empty", vol)
replaceProtoWorkingSound("assembling-machine", "chemical-plant", "empty", vol)
replaceProtoWorkingSound("capture-robot", "capture-robot", "priest_convert1", vol+15)
replaceProtoWorkingSound("assembling-machine", "crusher", "battering_ram_hit2", vol)
replaceProtoWorkingSound("assembling-machine", "cryogenic-plant", "ambiance_wave5", vol)
replaceProtoWorkingSound("rocket-silo", "rocket-silo", "empty", vol)
replaceProtoWorkingSound("assembling-machine", "biochamber", "ambiance_tf2", vol)
replaceProtoWorkingSound("agricultural-tower", "agricultural-tower", "ambiance_tf2_asia", vol)
replaceProtoWorkingSound("unit-spawner", "biter-spawner", "camel_select1", vol, 1/600)
replaceProtoWorkingSound("unit-spawner", "spitter-spawner", "camel_select2", vol, 1/600)
replaceProtoWorkingSound("unit-spawner", "gleba-spawner", "injury3", vol, 1/600)
replaceProtoWorkingSound("unit-spawner", "gleba-spawner-small", "injury4", vol, 1/600)

if data.raw["roboport"]["roboport"] and data.raw["roboport"]["roboport"].working_sound then
  data.raw["roboport"]["roboport"].working_sound.sound = {variations = {}}
  table.insert(data.raw["roboport"]["roboport"].working_sound.sound.variations, makeSound("ambiance_tf1", 3))
  table.insert(data.raw["roboport"]["roboport"].working_sound.sound.variations, makeSound("ambiance_tf2", 3))
  table.insert(data.raw["roboport"]["roboport"].working_sound.sound.variations, makeSound("ambiance_tf3", 3))
  table.insert(data.raw["roboport"]["roboport"].working_sound.sound.variations, makeSound("ambiance_tf4", 3))
  table.insert(data.raw["roboport"]["roboport"].working_sound.sound.variations, makeSound("ambiance_tf5", 3))
  table.insert(data.raw["roboport"]["roboport"].working_sound.sound.variations, makeSound("ambiance_tf6", 3))
  table.insert(data.raw["roboport"]["roboport"].working_sound.sound.variations, makeSound("ambiance_tf7", 3))
  table.insert(data.raw["roboport"]["roboport"].working_sound.sound.variations, makeSound("ambiance_tf8", 3))
  data.raw["roboport"]["roboport"].open_door_trigger_effect = nil
  data.raw["roboport"]["roboport"].close_door_trigger_effect = nil
end

local voices1 = {}
for i = 1, 400 do
  table.insert(voices1, makeSound("voices/" .. tostring(i), vol-5))
end
local voices2 = {}
for i = 401, 800 do
  table.insert(voices2, makeSound("voices/" .. tostring(i), vol-5))
end
local voices3 = {}
for i = 801, 1250 do
  table.insert(voices3, makeSound("voices/" .. tostring(i), vol-5))
end
local voices4 = {}
for i = 1251, 1695 do
  table.insert(voices4, makeSound("voices/" .. tostring(i), vol-5))
end
local deathsmale = {}
for i = 1, 6 do
  table.insert(deathsmale, makeSound("male_death" .. tostring(i), vol))
end


for _, entity in pairs(data.raw["logistic-container"]) do
  if entity.animation_sound then
    entity.animation_sound.variations = makeSound("animal_hunt", 10)
  end
end



if data.raw["logistic-robot"]["logistic-robot"] then
  local bot = data.raw["logistic-robot"]["logistic-robot"]
  --[[data.raw["logistic-robot"]["logistic-robot"].working_sound.sound = {variations = voices, aggregation = {max_count = 1, remove = true, count_already_playing = true}}
  data.raw["logistic-robot"]["logistic-robot"].working_sound.fade_in_ticks = nil
  data.raw["logistic-robot"]["logistic-robot"].working_sound.fade_out_ticks = nil
  data.raw["logistic-robot"]["logistic-robot"].working_sound.max_sounds_per_prototype = 1
  data.raw["logistic-robot"]["logistic-robot"].charging_sound.sound = {variations = voices, aggregation = {max_count = 1, remove = true, count_already_playing = true}}
  data.raw["logistic-robot"]["logistic-robot"].charging_sound.fade_in_ticks = nil
  data.raw["logistic-robot"]["logistic-robot"].charging_sound.fade_out_ticks = nil
  data.raw["logistic-robot"]["logistic-robot"].charging_sound.max_sounds_per_prototype = 1]]
  bot.working_sound = {
    sound = voices1,
    probability = 1 / 1000,
    max_sounds_per_prototype = 20,
  }
  bot.charging_sound = {
    sound = voices2,
    probability = 1 / 1000,
    max_sounds_per_prototype = 20,
  }

  if bot.dying_trigger_effect and bot.dying_trigger_effect[3]  then
    bot.dying_trigger_effect[2].sound = {variations = deathsmale}
    bot.dying_trigger_effect[3] = nil
  end
  --data.raw["logistic-robot"]["logistic-robot"].charging_sound = nil
  bot.build_sound = {
    filename = modname .. "/sounds/villager_spawn.ogg", volume = 0.5,
    aggregation = {max_count = 1, remove = true, count_already_playing = true}
  }

end


if data.raw["construction-robot"]["construction-robot"] then
  local bot = data.raw["construction-robot"]["construction-robot"]
  --[[data.raw["construction-robot"]["construction-robot"].working_sound.sound = {variations = voices, aggregation = {max_count = 1, remove = true, count_already_playing = true}}
  data.raw["construction-robot"]["construction-robot"].working_sound.fade_in_ticks = nil
  data.raw["construction-robot"]["construction-robot"].working_sound.fade_out_ticks = nil
  data.raw["construction-robot"]["construction-robot"].working_sound.max_sounds_per_prototype = 1
  data.raw["construction-robot"]["construction-robot"].charging_sound.sound = {variations = voices, aggregation = {max_count = 1, remove = true, count_already_playing = true}}
  data.raw["construction-robot"]["construction-robot"].charging_sound.fade_in_ticks = nil
  data.raw["construction-robot"]["construction-robot"].charging_sound.fade_out_ticks = nil
  data.raw["construction-robot"]["construction-robot"].charging_sound.max_sounds_per_prototype = 1]]
  bot.working_sound = {
    sound = voices3,
    probability = 1 / 1000,
    max_sounds_per_prototype = 20,
  }
  bot.charging_sound = {
    sound = voices4,
    probability = 1 / 1000,
    max_sounds_per_prototype = 20,
  }

  if bot.dying_trigger_effect and bot.dying_trigger_effect[3]  then
    bot.dying_trigger_effect[2].sound = {variations = deathsmale}
    bot.dying_trigger_effect[3] = nil
  end

  bot.build_sound = {
    filename = modname .. "/sounds/villager_spawn.ogg", volume = 0.5,
    aggregation = {max_count = 1, remove = true, count_already_playing = true}
  }

  bot.repairing_sound = {variations = {}}
  table.insert(data.raw["construction-robot"]["construction-robot"].repairing_sound.variations, makeSound("monk_heal", vol))

end

local replaceUtilitySounds = {
  {"axe_mining_ore", "mine", vol, 3},
  {"axe_mining_stone", "mine", vol, 3},
  {"mining_wood", "woodchop", vol, 3},
  {"axe_fighting", "sword", vol, 8},
  {"deconstruct_medium", "missile_impact", vol, 4},
  {"deconstruct_large", "missile_impact", vol, 4},
  {"deconstruct_huge", "missile_impact", vol, 4},
  {"inventory_click", "menu_select", vol},
  {"inventory_move", "select1", vol},
  {"gui_click", "select1", vol},
  {"list_box_click", "select1", vol},
  {"confirm", "select1", vol},
  {"alert_destroyed", "attack_warning_general", vol},
  {"console_message", "chat", vol},
  {"scenario_message", "chat", vol},
  {"game_lost", "playerdefeated", vol},
  {"game_won", "victory", vol},
  {"research_completed", "research", vol},
  {"crafting_finished", "farm_build2", vol},
  {"armor_insert", "garrison", vol},
  {"armor_remove", "ungarrison", vol},
  {"switch_gun", "sword_throw", vol, 3},
  {"undo", "error", vol-5},
  {"rotated_small", "arrow", vol, 4},
  {"rotated_medium", "arrow", vol, 4},
  {"rotated_large", "arrow", vol, 4},
  {"rotated_huge", "arrow", vol, 4},
  {"cannot_build", "population_limit", vol},
  {"wire_connect_pole", "stab1", vol},
  {"wire_disconnect", "stab3", vol},
  {"achievement_unlocked", "age_advance", vol},
  {"default_manual_repair", "monk_heal", vol},
}

for _, utili in pairs(replaceUtilitySounds) do
  data.raw["utility-sounds"]["default"][utili[1]] = {variations = {}}
  if not utili[4] then
    data.raw["utility-sounds"]["default"][utili[1]] = makeSound(utili[2], utili[3])
  else
    for i=1, utili[4] do
      table.insert(data.raw["utility-sounds"]["default"][utili[1]].variations, {filename = modname .. "/sounds/" .. utili[2] .. i .. ".ogg", volume = utili[3] / 10})
    end
  end
end

local function replaceDyingSounds(type, name, replacement, var_num)
  if data.raw[type] and data.raw[type][name] and data.raw[type][name].dying_sound and data.raw[type][name].dying_sound.variations then
    data.raw[type][name].dying_sound.variations = {}

    for i=1, var_num do
      table.insert(data.raw[type][name].dying_sound.variations, {filename = modname .. "/sounds/" .. replacement .. i .. ".ogg", volume = vol / 10})
    end
  end
end

replaceDyingSounds("unit-spawner", "biter-spawner", "camel_death", 2)
replaceDyingSounds("unit-spawner", "spitter-spawner", "camel_death", 2)
replaceDyingSounds("unit-spawner", "gleba-spawner", "male_death", 3)
replaceDyingSounds("unit-spawner", "gleba-spawner-small", "injury", 3)
replaceDyingSounds("assembling-machine", "captive-biter-spawner", "camel_death", 2)
replaceDyingSounds("unit", "small-biter", "cavalry_death", 3)
replaceDyingSounds("unit", "medium-biter", "cavalry_death", 3)
replaceDyingSounds("unit", "big-biter", "cavalry_death", 3)
replaceDyingSounds("unit", "behemoth-biter", "cavalry_death", 3)
replaceDyingSounds("unit", "small-spitter", "male_death", 6)
replaceDyingSounds("unit", "medium-spitter", "male_death", 6)
replaceDyingSounds("unit", "big-spitter", "male_death", 6)
replaceDyingSounds("unit", "behemoth-spitter", "male_death", 6)
replaceDyingSounds("turret", "small-worm-turret", "cavalry_death", 3)
replaceDyingSounds("turret", "medium-worm-turret", "cavalry_death", 3)
replaceDyingSounds("turret", "big-worm-turret", "cavalry_death", 3)
replaceDyingSounds("turret", "behemoth-worm-turret", "cavalry_death", 3)

local biters = {
  "small-biter",
  "medium-biter",
  "big-biter",
  "behemoth-biter",
}

local spitters = {
  "small-spitter",
  "medium-spitter",
  "big-spitter",
  "behemoth-spitter",
}

local worms = {
  "small-worm-turret",
  "medium-worm-turret",
  "big-worm-turret",
  "behemoth-worm-turret",
}

for _, biter in pairs(biters) do
  if data.raw.unit[biter] and data.raw.unit[biter].attack_parameters and data.raw.unit[biter].attack_parameters.sound and data.raw.unit[biter].attack_parameters.sound.variations then
    data.raw.unit[biter].attack_parameters.sound.variations = {}
    for i=1, 8 do
      table.insert(data.raw.unit[biter].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "sword" .. i .. ".ogg", volume = vol / 10})
    end
    if data.raw.unit[biter].working_sound and data.raw.unit[biter].walking_sound then
      data.raw.unit[biter].working_sound.variations = {}
      data.raw.unit[biter].walking_sound.variations = {}
      for i=1, 8 do
        table.insert(data.raw.unit[biter].working_sound.variations, {filename = modname.."/sounds/" .. "horse_ambient" .. i .. ".ogg", volume = vol / 10})
      end
      table.insert(data.raw.unit[biter].walking_sound.variations, {filename = modname.."/sounds/" .. "empty" .. ".ogg", volume = vol / 30})
    end
  end
end

for _, spitter in pairs(spitters) do
  if data.raw.unit[spitter] and data.raw.unit[spitter].attack_parameters and data.raw.unit[spitter].attack_parameters.cyclic_sound and data.raw.unit[spitter].attack_parameters.cyclic_sound.begin_sound and data.raw.unit[spitter].attack_parameters.cyclic_sound.begin_sound.variations then
    data.raw.unit[spitter].attack_parameters.cyclic_sound.begin_sound.variations = {}
    for i=1, 4 do
      table.insert(data.raw.unit[spitter].attack_parameters.cyclic_sound.begin_sound.variations, {filename = modname.."/sounds/" .. "arrow" .. i .. ".ogg", volume = vol / 10})
    end
    if data.raw.unit[spitter].working_sound and data.raw.unit[spitter].walking_sound then
      data.raw.unit[spitter].working_sound.variations = {}
      data.raw.unit[spitter].walking_sound.variations = {}
      for i=1, 8 do
        table.insert(data.raw.unit[spitter].working_sound.variations, {filename = modname.."/sounds/" .. "injury" .. i .. ".ogg", volume = vol / 10})
      end
      table.insert(data.raw.unit[spitter].walking_sound.variations, {filename = modname.."/sounds/" .. "empty" .. ".ogg", volume = vol / 30})
    end
  end
end

for _, worm in pairs(worms) do
  if data.raw.turret[worm] and data.raw.turret[worm].starting_attack_sound then
    data.raw.turret[worm].starting_attack_sound.variations = {}
    for i=1, 3 do
      table.insert(data.raw.turret[worm].starting_attack_sound.variations, {filename = modname.."/sounds/" .. "trebuchet_fire" .. i .. ".ogg", volume = vol / 10})
    end
    if data.raw.turret[worm].preparing_sound and data.raw.turret[worm].preparing_sound.variations then
      data.raw.turret[worm].preparing_sound.variations = {}
      for i=1, 3 do
        table.insert(data.raw.turret[worm].preparing_sound.variations, {filename = modname.."/sounds/" .. "horse_attack" .. i .. ".ogg", volume = vol / 10})
      end
    end
    if data.raw.turret[worm].prepared_sound and data.raw.turret[worm].prepared_sound.variations then
      data.raw.turret[worm].prepared_sound.variations = {}
      for i=1, 4 do
        table.insert(data.raw.turret[worm].prepared_sound.variations, {filename = modname.."/sounds/" .. "horse_ambient" .. i .. ".ogg", volume = vol / 10})
      end
    end
    if data.raw.turret[worm].prepared_alternative_sound and data.raw.turret[worm].prepared_alternative_sound.variations then
      data.raw.turret[worm].prepared_alternative_sound.variations = {}
      for i=1, 4 do
        table.insert(data.raw.turret[worm].prepared_alternative_sound.variations, {filename = modname.."/sounds/" .. "horse_ambient" .. i .. ".ogg", volume = vol / 10})
      end
    end
    if data.raw.turret[worm].folding_sound and data.raw.turret[worm].folding_sound.variations then
      data.raw.turret[worm].folding_sound.variations = {}
      for i=1, 2 do
        table.insert(data.raw.turret[worm].folding_sound.variations, {filename = modname.."/sounds/" .. "horse_flop" .. i .. ".ogg", volume = vol / 10})
      end
    end
  end
end

-- guns

if data.raw["ammo-turret"]["gun-turret"] and data.raw["ammo-turret"]["gun-turret"].attack_parameters then 
  data.raw["ammo-turret"]["gun-turret"].attack_parameters.sound = {variations = {}}
  for i=1, 4 do
    table.insert(data.raw["ammo-turret"]["gun-turret"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "arrow" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["gun"]["vehicle-machine-gun"] and data.raw["gun"]["vehicle-machine-gun"].attack_parameters then 
  data.raw["gun"]["vehicle-machine-gun"].attack_parameters.sound = {variations = {}}
  for i=1, 4 do
    table.insert(data.raw["gun"]["vehicle-machine-gun"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "arrow" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["gun"]["pistol"] and data.raw["gun"]["pistol"].attack_parameters then 
  data.raw["gun"]["pistol"].attack_parameters.sound = {variations = {}}
  for i=1, 4 do
    table.insert(data.raw["gun"]["pistol"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "arrow" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["gun"]["submachine-gun"] and data.raw["gun"]["submachine-gun"].attack_parameters then 
  data.raw["gun"]["submachine-gun"].attack_parameters.sound = {variations = {}}
  for i=1, 4 do
    table.insert(data.raw["gun"]["submachine-gun"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "arrow" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw.gun["flamethrower"] and data.raw.gun["flamethrower"].attack_parameters and data.raw.gun["flamethrower"].attack_parameters.cyclic_sound and data.raw.gun["flamethrower"].attack_parameters.cyclic_sound.middle_sound and data.raw.gun["flamethrower"].attack_parameters.cyclic_sound.middle_sound.variations then
  data.raw.gun["flamethrower"].attack_parameters.cyclic_sound.middle_sound.variations = {}
  for i=1, 4 do
    table.insert(data.raw.gun["flamethrower"].attack_parameters.cyclic_sound.middle_sound.variations, {filename = modname.."/sounds/" .. "fireship" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw.gun["flamethrower"] and data.raw.gun["flamethrower"].attack_parameters and data.raw.gun["flamethrower"].attack_parameters.cyclic_sound and data.raw.gun["flamethrower"].attack_parameters.cyclic_sound.middle_sound and data.raw.gun["flamethrower"].attack_parameters.cyclic_sound.middle_sound.variations then
  data.raw.gun["flamethrower"].attack_parameters.cyclic_sound.middle_sound.variations = {}
  for i=1, 4 do
    table.insert(data.raw.gun["flamethrower"].attack_parameters.cyclic_sound.middle_sound.variations, {filename = modname.."/sounds/" .. "fireship" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["gun"]["rocket-launcher"] and data.raw["gun"]["rocket-launcher"].attack_parameters then
  data.raw["gun"]["rocket-launcher"].attack_parameters.sound = {variations = {}}
  for i=1, 6 do
    table.insert(data.raw["gun"]["rocket-launcher"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "fireball" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["gun"]["spidertron-rocket-launcher-1"] and data.raw["gun"]["spidertron-rocket-launcher-1"].attack_parameters then
  data.raw["gun"]["spidertron-rocket-launcher-1"].attack_parameters.sound = {variations = {}}
  for i=1, 6 do
    table.insert(data.raw["gun"]["spidertron-rocket-launcher-1"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "fireball" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["gun"]["spidertron-rocket-launcher-2"] and data.raw["gun"]["spidertron-rocket-launcher-2"].attack_parameters then
  data.raw["gun"]["spidertron-rocket-launcher-2"].attack_parameters.sound = {variations = {}}
  for i=1, 6 do
    table.insert(data.raw["gun"]["spidertron-rocket-launcher-2"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "fireball" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["gun"]["spidertron-rocket-launcher-3"] and data.raw["gun"]["spidertron-rocket-launcher-3"].attack_parameters then
  data.raw["gun"]["spidertron-rocket-launcher-3"].attack_parameters.sound = {variations = {}}
  for i=1, 6 do
    table.insert(data.raw["gun"]["spidertron-rocket-launcher-3"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "fireball" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["gun"]["spidertron-rocket-launcher-4"] and data.raw["gun"]["spidertron-rocket-launcher-4"].attack_parameters then
  data.raw["gun"]["spidertron-rocket-launcher-4"].attack_parameters.sound = {variations = {}}
  for i=1, 6 do
    table.insert(data.raw["gun"]["spidertron-rocket-launcher-4"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "fireball" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["ammo-turret"]["rocket-turret"] and data.raw["ammo-turret"]["rocket-turret"].attack_parameters then 
  data.raw["ammo-turret"]["rocket-turret"].attack_parameters.sound = {variations = {}}
  for i=1, 6 do
    table.insert(data.raw["ammo-turret"]["rocket-turret"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "fireball" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["gun"]["shotgun"] and data.raw["gun"]["shotgun"].attack_parameters then 
  data.raw["gun"]["shotgun"].attack_parameters.sound = {variations = {}}
  for i=1, 3 do
    table.insert(data.raw["gun"]["shotgun"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "cannon_fire" .. i .. ".ogg", volume = 1})
  end
end

if data.raw["gun"]["combat-shotgun"] and data.raw["gun"]["combat-shotgun"].attack_parameters then 
  data.raw["gun"]["combat-shotgun"].attack_parameters.sound = {variations = {}}
  for i=1, 3 do
    table.insert(data.raw["gun"]["combat-shotgun"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "cannon_fire" .. i .. ".ogg", volume = 1})
  end
end

if data.raw["gun"]["tank-cannon"] and data.raw["gun"]["tank-cannon"].attack_parameters then 
  data.raw["gun"]["tank-cannon"].attack_parameters.sound = {variations = {}}
  table.insert(data.raw["gun"]["tank-cannon"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "gun_fire" .. ".ogg", volume = vol / 10})
end

if data.raw["gun"]["railgun"] and data.raw["gun"]["railgun"].attack_parameters then 
  data.raw["gun"]["railgun"].attack_parameters.sound = {variations = {}}
  table.insert(data.raw["gun"]["railgun"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "gun_fire" .. ".ogg", volume = vol / 10})
end

if data.raw["gun"]["artillery-wagon-cannon"] and data.raw["gun"]["artillery-wagon-cannon"].attack_parameters then 
  data.raw["gun"]["artillery-wagon-cannon"].attack_parameters.sound = {variations = {}}
  for i=1, 3 do
    table.insert(data.raw["gun"]["artillery-wagon-cannon"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "trebuchet_fire" .. i .. ".ogg", volume = 2})
  end
end

-- turrets

if data.raw["ammo-turret"]["railgun-turret"] and data.raw["ammo-turret"]["railgun-turret"].attack_parameters then 
  data.raw["ammo-turret"]["railgun-turret"].attack_parameters.sound = {variations = {}}
  table.insert(data.raw["ammo-turret"]["railgun-turret"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "gun_fire" .. ".ogg", volume = vol / 10})
  data.raw["ammo-turret"]["railgun-turret"].preparing_sound = makeSound("ram_pullback", vol)
  data.raw["ammo-turret"]["railgun-turret"].folding_sound = makeSound("scorpion_pullback", vol)
  if data.raw["ammo-turret"]["railgun-turret"].rotating_sound and data.raw["ammo-turret"]["railgun-turret"].rotating_sound.sound then
    data.raw["ammo-turret"]["railgun-turret"].rotating_sound.sound.filename = modname.."/sounds/trebuchet_pullback1.ogg"
    data.raw["ammo-turret"]["railgun-turret"].rotating_sound.sound.volume = vol
  end
end

if data.raw["ammo-turret"]["rocket-turret"] and data.raw["ammo-turret"]["rocket-turret"].attack_parameters then 
  data.raw["ammo-turret"]["rocket-turret"].attack_parameters.sound = {variations = {}}
  for i=1, 6 do
    table.insert(data.raw["ammo-turret"]["rocket-turret"].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "fireball" .. i .. ".ogg", volume = vol / 10})
  end
  data.raw["ammo-turret"]["rocket-turret"].preparing_sound = makeSound("ram_pullback", vol)
  data.raw["ammo-turret"]["rocket-turret"].folding_sound = makeSound("scorpion_pullback", vol)
  if data.raw["ammo-turret"]["rocket-turret"].rotating_sound and data.raw["ammo-turret"]["railgun-turret"].rotating_sound.sound then
    data.raw["ammo-turret"]["rocket-turret"].rotating_sound.sound.filename = modname.."/sounds/trebuchet_pullback1.ogg"
    data.raw["ammo-turret"]["rocket-turret"].rotating_sound.sound.volume = vol
  end
end


if data.raw["ammo-turret"]["gun-turret"] and data.raw["ammo-turret"]["gun-turret"].attack_parameters then
  data.raw["ammo-turret"]["gun-turret"].preparing_sound = makeSound("ram_pullback", vol)
  data.raw["ammo-turret"]["gun-turret"].folding_sound = makeSound("scorpion_pullback", vol)
  if data.raw["ammo-turret"]["gun-turret"].rotating_sound and data.raw["ammo-turret"]["railgun-turret"].rotating_sound.sound then
    data.raw["ammo-turret"]["gun-turret"].rotating_sound.sound.filename = modname.."/sounds/trebuchet_pullback1.ogg"
    data.raw["ammo-turret"]["gun-turret"].rotating_sound.sound.volume = vol
  end
end

if data.raw["artillery-turret"]["artillery-turret"] and data.raw["artillery-turret"]["artillery-turret"].rotating_sound and data.raw["artillery-turret"]["artillery-turret"].rotating_sound.sound then
  data.raw["artillery-turret"]["artillery-turret"].rotating_sound.sound.filename = modname.."/sounds/trebuchet_pullback1.ogg"
  data.raw["artillery-turret"]["artillery-turret"].rotating_sound.sound.volume = vol
end

--explosions

if data.raw["explosion"]["grenade-explosion"] and data.raw["explosion"]["grenade-explosion"].sound then
  data.raw["explosion"]["grenade-explosion"].sound.variations = {}
  for i=1, 4 do
    table.insert(data.raw["explosion"]["grenade-explosion"].sound.variations, {filename = modname.."/sounds/" .. "missile_impact" .. i .. ".ogg", volume = vol / 10})
  end
end
if data.raw["explosion"]["medium-explosion"] and data.raw["explosion"]["medium-explosion"].sound then
  data.raw["explosion"]["medium-explosion"].sound.variations = {}
  for i=1, 4 do
    table.insert(data.raw["explosion"]["medium-explosion"].sound.variations, {filename = modname.."/sounds/" .. "missile_impact" .. i .. ".ogg", volume = vol / 10})
  end
end
if data.raw["explosion"]["explosion"] and data.raw["explosion"]["explosion"].sound then
  data.raw["explosion"]["explosion"].sound.variations = {}
  for i=1, 4 do
    table.insert(data.raw["explosion"]["explosion"].sound.variations, {filename = modname.."/sounds/" .. "missile_impact" .. i .. ".ogg", volume = vol / 10})
  end
end
if data.raw["explosion"]["big-explosion"] and data.raw["explosion"]["big-explosion"].sound then
  data.raw["explosion"]["big-explosion"].sound.variations = {}
  for i=1, 4 do
    table.insert(data.raw["explosion"]["big-explosion"].sound.variations, {filename = modname.."/sounds/" .. "missile_impact" .. i .. ".ogg", volume = vol / 10})
  end
end
if data.raw["explosion"]["ground-explosion"] and data.raw["explosion"]["ground-explosion"].sound then
  data.raw["explosion"]["ground-explosion"].sound.variations = {}
  for i=1, 4 do
    table.insert(data.raw["explosion"]["ground-explosion"].sound.variations, {filename = modname.."/sounds/" .. "missile_impact" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["explosion"]["small-explosion"] and data.raw["explosion"]["small-explosion"].sound then
  data.raw["explosion"]["small-explosion"].sound.variations = {}
  for i=1, 4 do
    table.insert(data.raw["explosion"]["small-explosion"].sound.variations, {filename = modname.."/sounds/" .. "battering_ram_hit" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["explosion"]["foundation-tile-explosion"] and data.raw["explosion"]["foundation-tile-explosion"].sound then
  data.raw["explosion"]["foundation-tile-explosion"].sound.variations = {}
  for i=1, 4 do
    table.insert(data.raw["explosion"]["foundation-tile-explosion"].sound.variations, {filename = modname.."/sounds/" .. "missile_impact" .. i .. ".ogg", volume = vol / 10})
  end
end



if data.raw["deliver-impact-combination"]["vehicle-wood"] and data.raw["deliver-impact-combination"]["vehicle-wood"].trigger_effect_item and data.raw["deliver-impact-combination"]["vehicle-wood"].trigger_effect_item.sound then
  data.raw["deliver-impact-combination"]["vehicle-wood"].trigger_effect_item.variations = {}
  for i=1, 3 do
    table.insert(data.raw["deliver-impact-combination"]["vehicle-wood"].trigger_effect_item.variations, {filename = modname.."/sounds/" .. "woodchop" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["deliver-impact-combination"]["vehicle-tree"] and data.raw["deliver-impact-combination"]["vehicle-tree"].trigger_effect_item and data.raw["deliver-impact-combination"]["vehicle-tree"].trigger_effect_item.sound then
  data.raw["deliver-impact-combination"]["vehicle-tree"].trigger_effect_item.variations = {}
  for i=1, 3 do
    table.insert(data.raw["deliver-impact-combination"]["vehicle-tree"].trigger_effect_item.variations, {filename = modname.."/sounds/" .. "woodchop" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["deliver-impact-combination"]["vehicle-stone"] and data.raw["deliver-impact-combination"]["vehicle-stone"].trigger_effect_item and data.raw["deliver-impact-combination"]["vehicle-stone"].trigger_effect_item.sound then
  data.raw["deliver-impact-combination"]["vehicle-stone"].trigger_effect_item.variations = {}
  for i=1, 3 do
    table.insert(data.raw["deliver-impact-combination"]["vehicle-stone"].trigger_effect_item.variations, {filename = modname.."/sounds/" .. "mine" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["deliver-impact-combination"]["vehicle-glass"] and data.raw["deliver-impact-combination"]["vehicle-glass"].trigger_effect_item and data.raw["deliver-impact-combination"]["vehicle-glass"].trigger_effect_item.sound then
  data.raw["deliver-impact-combination"]["vehicle-glass"].trigger_effect_item.variations = {}
  for i=1, 3 do
    table.insert(data.raw["deliver-impact-combination"]["vehicle-glass"].trigger_effect_item.variations, {filename = modname.."/sounds/" .. "mine" .. i .. ".ogg", volume = vol / 10})
  end
end


if data.raw["deliver-impact-combination"]["vehicle-metal"] and data.raw["deliver-impact-combination"]["vehicle-metal"].trigger_effect_item and data.raw["deliver-impact-combination"]["vehicle-metal"].trigger_effect_item.sound then
  data.raw["deliver-impact-combination"]["vehicle-metal"].trigger_effect_item.variations = {}
  for i=1, 1 do
    table.insert(data.raw["deliver-impact-combination"]["vehicle-metal"].trigger_effect_item.variations, {filename = modname.."/sounds/" .. "capped_ram_hit" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["deliver-impact-combination"]["vehicle-metal-large"] and data.raw["deliver-impact-combination"]["vehicle-metal-large"].trigger_effect_item and data.raw["deliver-impact-combination"]["vehicle-metal-large"].trigger_effect_item.sound then
  data.raw["deliver-impact-combination"]["vehicle-metal-large"].trigger_effect_item.variations = {}
  for i=1, 1 do
    table.insert(data.raw["deliver-impact-combination"]["vehicle-metal-large"].trigger_effect_item.variations, {filename = modname.."/sounds/" .. "capped_ram_hit" .. i .. ".ogg", volume = vol / 10})
  end
end

if data.raw["deliver-impact-combination"]["bullet-organic"] and data.raw["deliver-impact-combination"]["bullet-organic"].trigger_effect_item and data.raw["deliver-impact-combination"]["bullet-organic"].trigger_effect_item.sound then
  data.raw["deliver-impact-combination"]["bullet-organic"].trigger_effect_item.variations = {}
  for i=1, 5 do
    table.insert(data.raw["deliver-impact-combination"]["bullet-organic"].trigger_effect_item.variations, {filename = modname.."/sounds/" .. "injury" .. i .. ".ogg", volume = vol / 20})
  end
end

if data.raw["lightning"]["lightning"] and data.raw["lightning"]["lightning"].sound then
  data.raw["lightning"]["lightning"].sound.variations = {}
  table.insert(data.raw["lightning"]["lightning"].sound.variations, {filename = modname.."/sounds/" .. "wonder_destruction.ogg", volume = vol / 10})
end

if data.raw["thruster"]["thruster"] and data.raw["thruster"]["thruster"].working_sound and data.raw["thruster"]["thruster"].working_sound.main_sounds and data.raw["thruster"]["thruster"].working_sound.main_sounds[1] and data.raw["thruster"]["thruster"].working_sound.main_sounds[1].sound then
  data.raw["thruster"]["thruster"].working_sound.main_sounds[1].sound.filename = modname.."/sounds/aoe3/aoe3_fireloop.ogg"
  data.raw["thruster"]["thruster"].working_sound.main_sounds[1].sound.volume = vol
end

if data.raw["accumulator"]["accumulator"] and data.raw["accumulator"]["accumulator"].working_sound and data.raw["accumulator"]["accumulator"].working_sound.main_sounds and data.raw["accumulator"]["accumulator"].working_sound.main_sounds[2] and data.raw["accumulator"]["accumulator"].working_sound.main_sounds[2].sound and data.raw["accumulator"]["accumulator"].working_sound.main_sounds[1].sound then
  data.raw["accumulator"]["accumulator"].working_sound.main_sounds[2].sound.filename = modname.."/sounds/ambiance_cricket.ogg"
  data.raw["accumulator"]["accumulator"].working_sound.main_sounds[1].sound.filename = modname.."/sounds/aoe3/aoe3_CampFireLoop.ogg"
  data.raw["accumulator"]["accumulator"].working_sound.main_sounds[2].sound.volume = vol / 10
  data.raw["accumulator"]["accumulator"].working_sound.main_sounds[1].sound.volume = vol / 10
  data.raw["accumulator"]["accumulator"].working_sound.idle_sound = nil
end

if data.raw["lightning-attractor"]["lightning-rod"] and data.raw["lightning-attractor"]["lightning-rod"].working_sound and data.raw["lightning-attractor"]["lightning-rod"].working_sound.main_sounds and data.raw["lightning-attractor"]["lightning-rod"].working_sound.main_sounds[2] and data.raw["lightning-attractor"]["lightning-rod"].working_sound.main_sounds[2].sound and data.raw["lightning-attractor"]["lightning-rod"].working_sound.main_sounds[1].sound then
  data.raw["lightning-attractor"]["lightning-rod"].working_sound.main_sounds[2].sound.filename = modname.."/sounds/monk_spawn.ogg"
  data.raw["lightning-attractor"]["lightning-rod"].working_sound.main_sounds[1].sound.filename = modname.."/sounds/ambiance_cricket.ogg"
end

if data.raw["lightning-attractor"]["lightning-collector"] and data.raw["lightning-attractor"]["lightning-collector"].working_sound and data.raw["lightning-attractor"]["lightning-collector"].working_sound.main_sounds and data.raw["lightning-attractor"]["lightning-collector"].working_sound.main_sounds[2] and data.raw["lightning-attractor"]["lightning-collector"].working_sound.main_sounds[2].sound and data.raw["lightning-attractor"]["lightning-collector"].working_sound.main_sounds[1].sound then
  data.raw["lightning-attractor"]["lightning-collector"].working_sound.main_sounds[2].sound.filename = modname.."/sounds/monk_spawn.ogg"
  data.raw["lightning-attractor"]["lightning-collector"].working_sound.main_sounds[1].sound.filename = modname.."/sounds/ambiance_cricket.ogg"
end

if data.raw["asteroid-collector"]["asteroid-collector"] and data.raw["asteroid-collector"]["asteroid-collector"].arm_extend_sound and data.raw["asteroid-collector"]["asteroid-collector"].arm_retract_sound and data.raw["asteroid-collector"]["asteroid-collector"].munch_sound then
  data.raw["asteroid-collector"]["asteroid-collector"].arm_extend_sound.variations = {makeSound("trade_cart_move", vol)}
  data.raw["asteroid-collector"]["asteroid-collector"].arm_retract_sound.variations = {makeSound("trade_cart_move", vol)}
  data.raw["asteroid-collector"]["asteroid-collector"].munch_sound.variations = {makeSound("capped_ram_hit3", vol)}
end



if data.raw["locomotive"]["locomotive"] and data.raw["locomotive"]["locomotive"].working_sound then
  data.raw["locomotive"]["locomotive"].working_sound.activate_sound = makeSound("gather_point", vol+15)
  data.raw["locomotive"]["locomotive"].working_sound.deactivate_sound = makeSound("trade_cart_stop", vol+15)
  data.raw["locomotive"]["locomotive"].open_sound = makeSound("mangonel_select", vol+15)
  data.raw["locomotive"]["locomotive"].close_sound = makeSound("gather_point", vol)
  if data.raw["locomotive"]["locomotive"].stop_trigger and data.raw["locomotive"]["locomotive"].stop_trigger[3] and data.raw["locomotive"]["locomotive"].stop_trigger[3].sound then
    data.raw["locomotive"]["locomotive"].stop_trigger[3].sound.filename = modname .. "/sounds/customsounds/train-stop.ogg"
    data.raw["locomotive"]["locomotive"].stop_trigger[3].sound.volume = vol /10
  end

end

if data.raw["rocket-silo"]["rocket-silo"] then
  data.raw["rocket-silo"]["rocket-silo"].alarm_sound = modname .. "/sounds/customsounds/silo-alarm.ogg"
  data.raw["rocket-silo"]["rocket-silo"].quick_alarm_sound = makeCustomSound("silo-alarm-short", vol)
  data.raw["rocket-silo"]["rocket-silo"].raise_rocket_sound = makeCustomSound("silo-raise-rocket", vol)
  data.raw["rocket-silo"]["rocket-silo"].doors_sound = makeCustomSound("silo-doors", vol)
  data.raw["rocket-silo"]["rocket-silo"].clamps_on_sound = makeCustomSound("silo-clamps-on", vol)
  data.raw["rocket-silo"]["rocket-silo"].clamps_off_sound = makeCustomSound("silo-clamps-on", vol)
end

if data.raw["rocket-silo-rocket"]["rocket-silo-rocket"] and data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].flying_sound then
  data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].flying_sound.filename = modname .. "/sounds/customsounds/silo-rocket.ogg"
end

-- VEHICLE

if data.raw["car"]["tank"] and data.raw["car"]["tank"].working_sound and data.raw["car"]["tank"].working_sound.main_sounds then
  data.raw["car"]["tank"].working_sound.activate_sound = makeSound("horse_move", vol)
  data.raw["car"]["tank"].working_sound.deactivate_sound = makeSound("trade_cart_stop", vol)
  data.raw["car"]["tank"].working_sound.main_sounds = {
    sound = { filename = modname .. "/sounds/siege_weapon_move.ogg", volume = vol-5 },
    match_speed_to_activity = true,
    activity_to_speed_modifiers =
    {
      multiplier = 3.0,
      minimum = 1.0,
      maximum = 1.2,
      offset = 0.8
    },
    match_volume_to_activity = true,
    activity_to_volume_modifiers =
    {
      multiplier = 4.5,
      offset = 1.0,
    },
  }
end

if data.raw["car"]["car"] and data.raw["car"]["car"].working_sound and data.raw["car"]["car"].working_sound.main_sounds then
  data.raw["car"]["car"].working_sound.activate_sound = makeSound("horse_move", vol)
  data.raw["car"]["car"].working_sound.deactivate_sound = makeSound("trade_cart_stop", vol)
  data.raw["car"]["car"].working_sound.main_sounds = {
    sound = { filename = modname .. "/sounds/siege_weapon_move.ogg", volume = vol-5 },
    match_speed_to_activity = true,
    activity_to_speed_modifiers =
    {
      multiplier = 3.0,
      minimum = 1.0,
      maximum = 1.2,
      offset = 0.8
    },
    match_volume_to_activity = true,
    activity_to_volume_modifiers =
    {
      multiplier = 4.5,
      offset = 1.0,
    },
  }
end

-- GUI

if data.raw["gui-style"] and data.raw["gui-style"].default and data.raw["gui-style"].default.menu_button_continue and data.raw["gui-style"].default.menu_button_continue.left_click_sound then
  data.raw["gui-style"].default.menu_button_continue.left_click_sound = modname .. "/sounds/select2.ogg"
end
if data.raw["gui-style"] and data.raw["gui-style"].default and data.raw["gui-style"].default.menu_button and data.raw["gui-style"].default.menu_button.left_click_sound then
  data.raw["gui-style"].default.menu_button.left_click_sound = modname .. "/sounds/select2.ogg"
end


if data.raw["ambient-sound"]["main-menu"] then
  data.raw["ambient-sound"]["main-menu"].sound = modname .. "/sounds/customsounds/main-menu.ogg"
end