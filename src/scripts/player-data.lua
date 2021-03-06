local player_data = {}

local translation = require("__flib__.control.translation")

local string_gsub = string.gsub
local string_sub = string.sub

function player_data.init(player, index)
  local player_table = {
    dictionary = {},
    flags = {
      can_open_gui = false,
      gui_open = false,
      translate_on_join = false,
      translations_finished = false
    },
    gui = {},
    last_update = game.tick
  }
  player.set_shortcut_available("ltnm-toggle-gui", false)
  global.players[index] = player_table
end

function player_data.update_settings(player, player_table)
  local settings = {}
  for name, t in pairs(player.mod_settings) do
    if string_sub(name, 1,5) == "ltnm-" then
      name = string_gsub(name, "ltnm%-", "")
      settings[string_gsub(name, "%-", "_")] = t.value
    end
  end
  player_table.settings = settings
end

function player_data.refresh(player, player_table)
  -- set flags
  player_table.flags.can_open_gui = false
  player_table.flags.translations_finished = false

  -- set shortcut state
  player.set_shortcut_toggled("ltnm-toggle-gui", false)
  player.set_shortcut_available("ltnm-toggle-gui", false)

  -- update settings
  player_data.update_settings(player, player_table)

  -- run translations
  player_table.dictionary = {}
  if player.connected then
    player_data.start_translations(player.index)
  else
    player_table.flags.translate_on_join = true
  end
end

function player_data.start_translations(player_index)
  local translation_data = global.translation_data
  for _, name in ipairs{"materials", "gui"} do
    translation.start(player_index, name, translation_data[name], {include_failed_translations=true})
  end
end

function player_data.set_setting(player_index, setting_name, setting_value)
  local player = game.get_player(player_index)
  player.mod_settings["ltnm-"..setting_name] = {value=setting_value}
end

return player_data