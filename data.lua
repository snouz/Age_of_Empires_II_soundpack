local sounds = {}
local modname = "__Age_of_Empires_II_soundpack__"
local vol = 15

local function makeSound(sound, volume)
  return {
    filename = modname .. "/sounds/" .. sound .. ".wav",
    volume = volume / 10
  }
end

local function replaceProtoSound(type, name, property, sound, var_num, volume)
  if data.raw[type] and data.raw[type][name] then
    data.raw[type][name][property] = {variations = {}}
    if var_num == 1 then
      data.raw[type][name][property].variations = makeSound(sound, volume)
    else
      for i=1, var_num do
        table.insert(data.raw[type][name][property].variations, {filename = modname.."/sounds/" .. sound .. i .. ".wav", volume = volume / 10})
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
  {"rocket-silo", "siege_workshop"},
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
  {"logistic-robot", "villager_spawn"},
  {"construction-robot", "villager_spawn"},
  {"combat-robot", "military_spawn"},
  {"car", "trebuchet_select"},
  {"artillery-wagon", "trebuchet_select"},
  {"artillery-turret", "trebuchet_select"},
  {"spider-vehicle", "horse_select1"},
  {"inserter", "mine2"},
  {"locomotive", "mangonel_select"},
  {"fluid-wagon", "mangonel_select"},
  {"cargo-wagon", "mangonel_select"},


  {"train-stop", "herdables_found"},
  {"rail-signal", "herdables_found"},
  {"rail-chain-signal", "herdables_found"},
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
  {"alert_destroyed", "attack_warning_base", vol},
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
      table.insert(data.raw["utility-sounds"]["default"][utili[1]].variations, {filename = modname .. "/sounds/" .. utili[2] .. i .. ".wav", volume = utili[3] / 10})
    end
  end
end


local function replaceDyingSounds(type, name, replacement, var_num)
  if data.raw[type] and data.raw[type][name] and data.raw[type][name].dying_sound and data.raw[type][name].dying_sound.variations then
    data.raw[type][name].dying_sound.variations = {}

    for i=1, var_num do
      table.insert(data.raw[type][name].dying_sound.variations, {filename = modname .. "/sounds/" .. replacement .. i .. ".wav", volume = vol / 10})
    end
  end
end


replaceDyingSounds("unit-spawner", "biter-spawner", "camel_death", 2)
replaceDyingSounds("unit-spawner", "spitter-spawner", "camel_death", 2)
replaceDyingSounds("unit", "small-biter", "cavalry_death", 3)
replaceDyingSounds("unit", "medium-biter", "cavalry_death", 3)
replaceDyingSounds("unit", "big-biter", "cavalry_death", 3)
replaceDyingSounds("unit", "behemoth-biter", "cavalry_death", 3)
replaceDyingSounds("unit", "small-spitter", "male_death", 6)
replaceDyingSounds("unit", "medium-spitter", "male_death", 6)
replaceDyingSounds("unit", "big-spitter", "male_death", 6)
replaceDyingSounds("unit", "behemoth-spitter", "male_death", 6)


replaceDyingSounds("unit", "small-worm", "elephant_death", 1)
replaceDyingSounds("unit", "medium-worm", "elephant_death", 1)
replaceDyingSounds("unit", "big-worm", "elephant_death", 1)
replaceDyingSounds("unit", "behemoth-worm", "elephant_death", 1)

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
  "small-worm",
  "medium-worm",
  "big-worm",
  "behemoth-worm",
}

for _, biter in pairs(biters) do
  if data.raw.unit[biter] and data.raw.unit[biter].attack_parameters and data.raw.unit[biter].attack_parameters.sound and data.raw.unit[biter].attack_parameters.sound.variations then
    data.raw.unit[biter].attack_parameters.sound.variations = {}
    for i=1, 8 do
      table.insert(data.raw.unit[biter].attack_parameters.sound.variations, {filename = modname.."/sounds/" .. "sword" .. i .. ".wav", volume = vol / 10})
    end
  end
end

for _, spitter in pairs(spitters) do
  if data.raw.unit[spitter] and data.raw.unit[spitter].attack_parameters and data.raw.unit[spitter].attack_parameters.cyclic_sound and data.raw.unit[spitter].attack_parameters.cyclic_sound.begin_sound and data.raw.unit[spitter].attack_parameters.cyclic_sound.begin_sound.variations then
    data.raw.unit[spitter].attack_parameters.cyclic_sound.begin_sound.variations = {}
    for i=1, 4 do
      table.insert(data.raw.unit[spitter].attack_parameters.cyclic_sound.begin_sound.variations, {filename = modname.."/sounds/" .. "arrow" .. i .. ".wav", volume = vol / 10})
    end
  end
end

for _, worm in pairs(worms) do
  if data.raw.turret[worm] and data.raw.turret[worm].starting_attack_sound and data.raw.turret[worm].starting_attack_sound.variations then
    data.raw.turret[worm].starting_attack_sound.variations = {}
    for i=1, 3 do
      table.insert(data.raw.unit[spitter].attack_parameters.cyclic_sound.begin_sound.variations, {filename = modname.."/sounds/" .. "trebuchet_fire" .. i .. ".wav", volume = vol / 10})
    end
  end
end

--[[
for _, entity in pairs(data.raw["assembling-machine"]) do
  replaceAllBaseSounds("assembling-machine", entity.name, "siege_workshop")
end

for _, entity in pairs(data.raw["lab"]) do
  replaceAllBaseSounds("lab", entity.name, "university")
end

for _, entity in pairs(data.raw["furnace"]) do
  replaceAllBaseSounds("furnace", entity.name, "blacksmith")
end

for _, entity in pairs(data.raw["offshore-pump"]) do
  replaceAllBaseSounds("offshore-pump", entity.name, "dock")
end

for _, entity in pairs(data.raw["gate"]) do
  replaceAllBaseSounds("gate", entity.name, "gate")
end

for _, entity in pairs(data.raw["wall"]) do
  replaceAllBaseSounds("wall", entity.name, "wall")
end

for _, entity in pairs(data.raw["container"]) do
  replaceAllBaseSounds("container", entity.name, "house")
end

]]

--replaceProtoSound("assembling-machine", "assembling-machine-2", "open_sound", "arrow", 4, 15)

--[[
for _,instrument in pairs(data.raw["programmable-speaker"]["programmable-speaker"].instruments) do
  if instrument.name == "alarms" then
    table.insert(instrument.notes, {name = "kj_klaxon_a",  sound = {filename = modname.."/sounds/klaxon_a.ogg"}})
    table.insert(instrument.notes, {name = "kj_klaxon_b",  sound = {filename = modname.."/sounds/klaxon_b.ogg"}})
  end
end

data:extend({
  {
    type = "sound",
    name = "kj_fallout_pipboy_on",
    filename = modname.."/sounds/ui/pipboy_on.ogg",
    volume = 1,
    category = "gui-effect",
    audible_distance_modifier = 1,
  },
  {
    type = "sound",
    name = "kj_fallout_pipboy_off",
    filename = modname.."/sounds/ui/pipboy_off.ogg",
    volume = 1,
    category = "gui-effect",
    audible_distance_modifier = 1,
  },
})

for i=1,5,1 do
  data:extend({
    {
      type = "sound",
      name = "kj_fallout_pipboy_static_a_"..i,
      filename = modname.."/sounds/ui/static_a_"..i..".ogg",
      volume = 1,
      category = "gui-effect",
      audible_distance_modifier = 1,
    },
    {
      type = "sound",
      name = "kj_fallout_pipboy_static_b_"..i,
      filename = modname.."/sounds/ui/static_b_"..i..".ogg",
      volume = 1,
      category = "gui-effect",
      audible_distance_modifier = 1,
    },
  })
end

-----------------G U N S-----------------
if settings.startup["kj_falloutSounds_bullet"].value == true then
  data.raw["gun"]["submachine-gun"].attack_parameters.sound.variations = {
    returnSound("weapons/assault1.ogg", 0.3),
    returnSound("weapons/assault2.ogg", 0.3),
    returnSound("weapons/assault3.ogg", 0.3),
  }

  local marksman = {
    returnSound("weapons/marksman1.ogg", 0.3),
    returnSound("weapons/marksman2.ogg", 0.3),
    returnSound("weapons/marksman3.ogg", 0.3),
  }
  data.raw["gun"]["vehicle-machine-gun"].attack_parameters.sound.variations = marksman
  data.raw["ammo-turret"]["gun-turret"].attack_parameters.sound.variations = marksman

  sounds = table.deepcopy(data.raw["gun"]["shotgun"].attack_parameters.sound)
  sounds.variations = {
    returnSound("weapons/shotgun1.ogg", 0.5),
    returnSound("weapons/shotgun2.ogg", 0.5),
  }
  data.raw["gun"]["shotgun"].attack_parameters.sound = sounds

  sounds = table.deepcopy(data.raw["gun"]["combat-shotgun"].attack_parameters.sound)
  sounds.variations = {
    returnSound("weapons/riotShotgun1.ogg", 0.3),
    returnSound("weapons/riotShotgun2.ogg", 0.3),
  }
  data.raw["gun"]["combat-shotgun"].attack_parameters.sound = sounds

  sounds = table.deepcopy(data.raw["gun"]["pistol"].attack_parameters.sound)
  sounds.variations = {
    returnSound("weapons/pistol1.ogg", 0.5),
    returnSound("weapons/pistol2.ogg", 0.5),
    returnSound("weapons/pistol3.ogg", 0.5),
    returnSound("weapons/pistol4.ogg", 0.5),
  }
  data.raw["gun"]["pistol"].attack_parameters.sound = sounds
end

if settings.startup["kj_falloutSounds_explosions"].value == true then
  sounds = table.deepcopy(data.raw["explosion"]["grenade-explosion"].sound)
  sounds.variations = {
    returnSound("weapons/grenade1.ogg", 0.5),
    returnSound("weapons/grenade2.ogg", 0.5),
    returnSound("weapons/grenade3.ogg", 0.5),
  }
  data.raw["explosion"]["grenade-explosion"].sound = sounds
  data.raw["explosion"]["medium-explosion"].sound = sounds
  data.raw["projectile"]["rocket"].action.action_delivery.target_effects[1].entity_name = "medium-explosion"

  explosionSound = table.deepcopy(data.raw["explosion"]["explosion"])
  explosionSound.name = "kj_explosion_fnv"
  explosionSound.sound.variations = sounds.variations
  data:extend({explosionSound})
  data.raw["land-mine"]["land-mine"].action.action_delivery.source_effects[2].entity_name = "kj_explosion_fnv"
  data.raw["projectile"]["explosive-cannon-projectile"].final_action.action_delivery.target_effects[2].action.action_delivery.target_effects[2].entity_name = "kj_explosion_fnv"
  data.raw["projectile"]["explosive-rocket"].action.action_delivery.target_effects[6].action.action_delivery.target_effects[2].entity_name = "kj_explosion_fnv"
  table.insert(data.raw["projectile"]["atomic-rocket"].action.action_delivery.target_effects, {
    type = "play-sound",
    sound = returnSound("nuke.ogg", 1),
    play_on_target_position = false,
    -- min_distance = 200,
    max_distance = 1000,
    -- volume_modifier = 1,
    audible_distance_modifier = 5
  })
end

if settings.startup["kj_falloutSounds_utility"].value == true then
  data.raw["utility-sounds"]["default"].achievement_unlocked.variations = {
    returnSound("achievement.ogg", 0.7)
  }
  data.raw["utility-sounds"]["default"].game_lost = {
    returnSound("death.ogg", 0.7)
  }
  data.raw["utility-sounds"]["default"].game_won = {
    returnSound("win.ogg", 0.7)
  }
  data.raw["utility-sounds"]["default"].research_completed = {
    returnSound("research.ogg", 0.7)
  }
  sounds = {
    variations = {
      returnSound("typing/typing_1.ogg", 0.5),
      returnSound("typing/typing_2.ogg", 0.5),
      returnSound("typing/typing_3.ogg", 0.5),
      returnSound("typing/typing_4.ogg", 0.5),
    }
  }
  data.raw["utility-sounds"]["default"].console_message = sounds
  for _,instrument in pairs(data.raw["programmable-speaker"]["programmable-speaker"].instruments) do
  if instrument.name == "miscellaneous" then
    for _,note in pairs(instrument.notes) do
      if note.name == "console-message" then
        note.sound = sounds
      end
    end
  end
end
end

if settings.startup["kj_falloutSounds_gui"].value == true then
  local click = returnSound("ui/click.ogg", 0.45)
  for _,instrument in pairs(data.raw["programmable-speaker"]["programmable-speaker"].instruments) do
    if instrument.name == "miscellaneous" then
      for _,note in pairs(instrument.notes) do
        if note.name == "gui-click" then
          note.sound = click
        end
      end
    end
  end
  data.raw["gui-style"]["default"].button.left_click_sound = click
  data.raw["gui-style"]["default"].dropdown_button.left_click_sound = click
  data.raw["gui-style"]["default"].slider_button.left_click_sound = click

  local tool = returnSound("ui/mode.ogg", 0.45)
  data.raw["gui-style"]["default"].tool_button_red.left_click_sound = tool
  data.raw["gui-style"]["default"].tool_button.left_click_sound = tool
  data.raw["gui-style"]["default"].mini_tool_button_red.left_click_sound = tool
  --data.raw["gui-style"]["default"].tracking_off_button.left_click_sound = tool
  data.raw["gui-style"]["default"].frame_action_button.left_click_sound = tool
  --data.raw["gui-style"]["default"].tip_notice_close_button.left_click_sound = tool
  data.raw["gui-style"]["default"].train_schedule_action_button.left_click_sound = tool
  data.raw["gui-style"]["default"].train_schedule_delete_button.left_click_sound = tool
  data.raw["gui-style"]["default"].side_menu_button.left_click_sound = tool
  data.raw["gui-style"]["default"].quick_bar_page_button.left_click_sound = tool
  data.raw["gui-style"]["default"].slot_button_in_shallow_frame.left_click_sound = tool
  data.raw["gui-style"]["default"].slot_sized_button.left_click_sound = tool

  local tab = returnSound("ui/tab.ogg", 0.5)
  data.raw["gui-style"]["default"].tab.left_click_sound = tab
  data.raw["gui-style"]["default"].technology_slot.left_click_sound = tab
  data.raw["gui-style"]["default"].filter_group_tab.left_click_sound = tab

  local select = returnSound("ui/select.ogg", 0.2)
  data.raw["gui-style"]["default"].green_button.left_click_sound = select
  data.raw["gui-style"]["default"].confirm_button.left_click_sound = select
  data.raw["gui-style"]["default"].menu_button_continue.left_click_sound = select
  data.raw["utility-sounds"]["default"].confirm = select

  local dropdown = returnSound("ui/next.ogg", 0.5)
  data.raw["gui-style"]["default"].dropdown.opened_sound = dropdown
  data.raw["gui-style"]["default"].checkbox.left_click_sound = dropdown

  local focus = returnSound("ui/focus.ogg", 0.5)
  data.raw["gui-style"]["default"].slot.left_click_sound = focus
  data.raw["gui-style"]["default"].slot_button.left_click_sound = focus
  data.raw["utility-sounds"]["default"].inventory_click = focus

  local cancel = returnSound("ui/cancel.ogg", 0.5)
  for _,instrument in pairs(data.raw["programmable-speaker"]["programmable-speaker"].instruments) do
    if instrument.name == "miscellaneous" then
      for _,note in pairs(instrument.notes) do
        if note.name == "inventory-move" then
          note.sound = cancel
        end
      end
    end
  end
  data.raw["utility-sounds"]["default"].inventory_move = cancel
end

if settings.startup["kj_falloutSounds_missile"].value == true then
  data.raw["gun"]["rocket-launcher"].attack_parameters.sound.filename = modname.."/sounds/weapons/missile.ogg"
  for i = 1,4,1 do
    data.raw["gun"]["spidertron-rocket-launcher-"..i].attack_parameters.sound.filename = modname.."/sounds/weapons/missile.ogg"
  end
  if mods["HelicopterRevival"] then
    data.raw["gun"]["heli-rocket-launcher-item"].attack_parameters.sound = returnSound("weapons/missile.ogg", 0.7)
  end
  if mods["IndustrialRevolution3"] then
    data.raw["ammo-turret"]["rocket-turret"].attack_parameters.sound = returnSound("weapons/missile.ogg", 0.7)
  end
end

if settings.startup["kj_falloutSounds_flamer"].value == true then
  data.raw["gun"]["flamethrower"].attack_parameters.cyclic_sound.begin_sound = {returnSound("weapons/flamer_start.ogg", 0.5)}
  data.raw["gun"]["flamethrower"].attack_parameters.cyclic_sound.middle_sound = {returnSound("weapons/flamer_mid.ogg", 0.5)}
  data.raw["gun"]["flamethrower"].attack_parameters.cyclic_sound.end_sound = {returnSound("weapons/flamer_end.ogg", 0.5)}
  
  data.raw["gun"]["tank-flamethrower"].attack_parameters.cyclic_sound.begin_sound = {returnSound("weapons/flamer_start.ogg", 0.8)}
  data.raw["gun"]["tank-flamethrower"].attack_parameters.cyclic_sound.middle_sound = {returnSound("weapons/flamer_mid.ogg", 0.8)}
  data.raw["gun"]["tank-flamethrower"].attack_parameters.cyclic_sound.end_sound = {returnSound("weapons/flamer_end.ogg", 0.8)}
end

--[programmable-speaker-note]
--alarm-1=Alarm 1

]]