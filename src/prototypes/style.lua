-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GUI STYLES

local util = require("prototypes.util")

local styles = data.raw["gui-style"].default

-- -----------------------------------------------------------------------------
-- BUTTON STYLES

local slot_buttons_tileset = "__LtnManager__/graphics/gui/slot-buttons.png"

local function slot_button(y, glow_color, default_x, size)
  return {
    type = "button_style",
    parent = "CGUI_filter_slot_button",
    size = size or 40,
    default_graphical_set = {
      base = {border=4, position={(default_x or 0),y}, size=80, filename=slot_buttons_tileset},
      shadow = offset_by_2_rounded_corners_glow(default_dirt_color),
    },
    hovered_graphical_set = {
      base = {border=4, position={80,y}, size=80, filename=slot_buttons_tileset},
      shadow = offset_by_2_rounded_corners_glow(default_dirt_color),
      glow = offset_by_2_rounded_corners_glow(glow_color)
    },
    clicked_graphical_set = {
      base = {border=4, position={160,y}, size=80, filename=slot_buttons_tileset},
      shadow = offset_by_2_rounded_corners_glow(default_dirt_color),
    },
    disabled_graphical_set = { -- identical to default graphical set
      base = {border=4, position={(default_x or 0),y}, size=80, filename=slot_buttons_tileset},
      shadow = offset_by_2_rounded_corners_glow(default_dirt_color),
    },
  }
end

local slot_button_data = {
  {name="dark_grey", y=0, glow=default_glow_color},
  {name="light_grey", y=80, glow=default_glow_color},
  {name="red", y=160, glow={255,166,123,128}},
  {name="green", y=240, glow={34,255,75,128}},
  {name="blue", y=320, glow={34,181,255,128}},
}

for _, data in ipairs(slot_button_data) do
  styles["ltnm_slot_button_"..data.name] = slot_button(data.y, data.glow)
  styles["ltnm_small_slot_button_"..data.name] = slot_button(data.y, data.glow, nil, 36)
  styles["ltnm_active_slot_button_"..data.name] = slot_button(data.y, data.glow, 80)
  styles["ltnm_active_small_slot_button_"..data.name] = slot_button(data.y, data.glow, 80, 36)
end

local function ltnm_tab_base(pos)
  return {
    position = pos,
    corner_size = 8,
    bottom = {},
    left_bottom = {},
    right_bottom = {}
  }
end

local mock_frame_shadow = {
  layers = {
    {
      position = {208,128},
      size = {1, 8},
      tint = hard_shadow_color,
      scale = 0.5
    },
    {
      position = {8, 0},
      size = {1, 8},
      shift = {0, 4}
    }
  }
}

styles.ltnm_mock_frame_tab = {
  type = "button_style",
  font = "default-bold",
  height = 32,
  top_padding = 0,
  bottom_padding = 0,
  minimal_width = 84,
  default_graphical_set = {
    base = ltnm_tab_base{102, 0},
    shadow = tab_glow(default_shadow_color, 0.5),
    glow = {bottom=mock_frame_shadow}
  },
  hovered_graphical_set = {
    base = ltnm_tab_base{153, 0},
    glow = {
      left_top = {position = {216, 0}, size = 16, tint = default_glow_color, scale = 0.5},
      top = {position = {208, 128}, size = {1, 8}, tint = default_glow_color, scale = 0.5},
      right_top = {position = {232, 0}, size = 16, tint = default_glow_color, scale = 0.5},
      left = {position = {200, 136}, size = {8, 1}, tint = default_glow_color, scale = 0.5},
      right = {position = {209, 136}, size = {8, 1}, tint = default_glow_color, scale = 0.5},
      left_bottom = mock_frame_shadow,
      bottom = mock_frame_shadow,
      right_bottom = mock_frame_shadow,
      top_outer_border_shift = 4,
      left_outer_border_shift = 4,
      right_outer_border_shift = -4,
      bottom_outer_border_shift = -4,
      draw_type = "outer"
    }
  },
  clicked_vertical_offset = 0,
  clicked_graphical_set = {
    base = ltnm_tab_base{153, 0},
    glow = {bottom=mock_frame_shadow}
  },
  disabled_font_color = heading_font_color,
  disabled_graphical_set = {
    base = ltnm_tab_base{448, 103},
    shadow = tab_glow(default_shadow_color, 0.5)
  }
}

styles.ltnm_depot_button = {
  type = "button_style",
  parent = "button",
  height = 85,
  padding = 4,
  width = 206,
  clicked_vertical_offset = 0,
  clicked_graphical_set = {
    base = {position = {34, 17}, corner_size = 8},
    shadow = default_dirt
  },
  disabled_graphical_set = {
    base = {position = {68, 0}, corner_size = 8},
    shadow = default_dirt
  }
}

-- hardcode a smaller button to avoid stretchable / squashable in-fighting
styles.ltnm_depot_button_for_scrollbar = {
  type = "button_style",
  parent = "ltnm_depot_button",
  width = 194
}

styles.ltnm_frame_action_button = {
  type = "button_style",
  parent = "close_button",
  size = 20
}

styles.ltnm_active_frame_action_button = {
  type = "button_style",
  parent = "ltnm_frame_action_button",
  default_graphical_set = {
    base = {position = {272, 169}, corner_size = 8},
    shadow = {position = {440, 24}, corner_size = 8, draw_type = "outer"}
  },
  hovered_graphical_set = {
    base = {position = {369, 17}, corner_size = 8},
    shadow = default_dirt
  },
  clicked_graphical_set = {
    base = {position = {352, 17}, corner_size = 8},
    shadow = default_dirt
  }
}

styles.ltnm_inset_tool_button = {
  type = "button_style",
  parent = "tool_button",
  hovered_graphical_set = {
    base = {position = {34, 17}, corner_size = 8},
    shadow = default_dirt,
    -- no glow, since it is inset
    -- glow = default_glow(default_glow_color, 0.5)
  },
}

styles.ltnm_inset_red_icon_button = {
  type = "button_style",
  parent = "red_icon_button",
  hovered_graphical_set = {
    base = {position = {170, 17}, corner_size = 8},
    shadow = default_dirt,
    -- no glow, since it is inset
    -- glow = default_glow(red_button_glow_color, 0.5)
  },
}

-- -----------------------------------------------------------------------------
-- CHECKBOX STYLES

-- inactive is grey until hovered
-- checked = descending, unchecked = ascending
styles.ltnm_sort_checkbox_inactive = {
  type = "checkbox_style",
  font = "default-bold",
  font_color = bold_font_color,
  padding = 0,
  default_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-white.png",
    size = {16, 16},
    scale = 0.5
  },
  hovered_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-hover.png",
    size = {16, 16},
    scale = 0.5
  },
  clicked_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-white.png",
    size = {16, 16},
    scale = 0.5
  },
  disabled_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-white.png",
    size = {16, 16},
    scale = 0.5
  },
  selected_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-white.png",
    size = {16, 16},
    scale = 0.5
  },
  selected_hovered_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-hover.png",
    size = {16, 16},
    scale = 0.5
  },
  selected_clicked_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-white.png",
    size = {16, 16},
    scale = 0.5
  },
  selected_disabled_graphical_set =
  {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-white.png",
    size = {16, 16},
    scale = 0.5
  },
  checkmark = util.empty_checkmark,
  disabled_checkmark = util.empty_checkmark,
  text_padding = 5
}

-- active is orange by default
styles.ltnm_sort_checkbox_active = {
  type = "checkbox_style",
  parent = "ltnm_sort_checkbox_inactive",
  -- font_color = bold_font_color,
  default_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-active.png",
    size = {16, 16},
    scale = 0.5
  },
  selected_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-active.png",
    size = {16, 16},
    scale = 0.5
  }
}

-- -----------------------------------------------------------------------------
-- EMPTY WIDGET STYLES

styles.ltnm_titlebar_drag_handle = {
  type = "empty_widget_style",
  parent = "draggable_space_header",
  horizontally_stretchable = "on",
  natural_height = 24,
  minimal_width = 24,
}

-- -----------------------------------------------------------------------------
-- FLOW STYLES

styles.ltnm_titlebar_flow = {
  type = "horizontal_flow_style",
  direction = "horizontal",
  horizontally_stretchable = "on",
  vertical_align = "center",
  top_margin = -3
}

styles.ltnm_station_labels_flow = {
  type = "horizontal_flow_style",
  horizontal_spacing = 12,
  vertical_align = "center"
}

-- -----------------------------------------------------------------------------
-- FRAME STYLES

styles.ltnm_alert_popup_frame = {
  type = "frame_style",
  parent = "dialog_frame",
  graphical_set = {
    base = {position={403,17}, corner_size=8},
    shadow = default_shadow
  }
}

styles.ltnm_empty_frame = {
  type = "frame_style",
  graphical_set = {},
  padding = 0,
  margin = 0,
  vertical_flow_style = {
    type = "vertical_flow_style",
    vertical_spacing = 0
  }
}

styles.ltnm_main_frame_header = {
  type = "frame_style",
  height = 32,
  graphical_set = {
    base = {
      left_top = {position={0,0}, size={8,8}},
      top = {position={8,0}, size={1,8}},
      right_top = {position={9,0}, size={8,8}},
      right = {position={9,8}, size={8,1}},
      right_bottom = {position={9,8}, size={8,1}},
      bottom = {position={8,8}, size={1,1}},
      left_bottom = {position={26,9}, size={8,8}},
      left = {position={0,8}, size={8,1}},
      center = {position={8,8}, size={1,1}}
    },
    shadow = {
      top = {position={208,128}, size={1,8}},
      left_top = {position={200,128}, size={8,8}},
      left = {position={200,136}, size={1,8}}, -- empty area
      right_top = {position={209,128}, size={8,8}},
      right = {position={209,136}, size={8,1}},
      center = {position={208,136}, size={1,1}},
      tint = default_shadow_color,
      scale = 0.5,
      draw_type = "outer"
    }
  },
  horizontal_flow_style = {
    type = "horizontal_flow_style",
    top_padding = 4,
    vertical_align = "center"
  }
}

styles.ltnm_main_frame_content = {
  type = "frame_style",
  parent = "dialog_frame",
  width = 830,
  height = 615,
  graphical_set = {
    base = {
      position = {0,0},
      corner_size = 8,
      top = {},
      left_top = {},
      right_top = {}
    },
    shadow = {
      position = {200, 128},
      corner_size = 8,
      top = {},
      left_top = {},
      right_top = {},
      tint = default_shadow_color,
      scale = 0.5,
      draw_type = "outer"
    }
  },
  top_padding = 4,
  horizontal_flow_style = {
    type = "horizontal_flow_style",
    horizontal_spacing = 0
  }
}

styles.ltnm_dark_content_frame = {
  type = "frame_style",
  parent = "inside_deep_frame",
  graphical_set = {
    base = {
      position = {17,0}, corner_size = 8,
      center = {position={42,8}, size={1,1}},
      draw_type = "outer"
    },
    shadow = default_inner_shadow
  },
}

styles.ltnm_dark_content_frame_in_light_frame = {
  type = "frame_style",
  parent = "inside_deep_frame",
  graphical_set = {
    base = {
      position = {85,0},
      corner_size = 8,
      draw_type = "outer",
      center = {position={42,8}, size=1}
    },
    shadow = default_inner_shadow
  }
}

styles.ltnm_light_content_frame = {
  type = "frame_style",
  parent = "window_content_frame_packed"
}

styles.ltnm_light_content_frame_in_light_frame = {
  type = "frame_style",
  parent = "window_content_frame_packed",
  graphical_set = {
    base = {
      position = {85,0},
      corner_size = 8,
      draw_type = "outer",
      center = {position={76,8}, size=1}
    },
    shadow = default_inner_shadow
  }
}

-- remove the left border so it transitions seamlessly from a scrollbar over there
styles.ltnm_dark_content_frame_in_light_frame_no_left = {
  type = "frame_style",
  parent = "ltnm_dark_content_frame_in_light_frame",
  graphical_set = {
    base = {
      position = {85,0},
      corner_size = 8,
      draw_type = "outer",
      center = {position={42,8}, size=1},
      left = {},
      left_top = {},
      left_bottom = {}
    },
    shadow = default_inner_shadow
  }
}

styles.ltnm_toolbar_frame = {
  type = "frame_style",
  parent = "frame",
  graphical_set = {
    base = {
      center = {position = {256, 25}, size = {1, 1}},
      bottom = {position = {256, 26}, size = {1, 8}}
    },
    shadow = bottom_shadow
  },
  horizontal_flow_style = {
    type = "horizontal_flow_style",
    vertical_align = "center",
    height = 28,
    horizontal_spacing = 12
  },
  vertical_align = "center",
  top_padding = 3, -- optical correction - move one pixel up from perfect position
  right_padding = 4,
  left_padding = 4,
  bottom_padding = 1,
  vertically_stretchable = "off"
}

styles.ltnm_item_info_toolbar_frame = {
  type = "frame_style",
  parent = "ltnm_toolbar_frame",
  width = 370 -- hardcode width to prevent in-fighting between stretches
}

-- -----------------------------------------------------------------------------
-- IMAGE STYLES

styles.ltnm_material_icon = {
  type = "image_style",
  stretch_image_to_widget_size = true,
  size = 28,
  padding = 2,
  left_margin = 2
}

styles.ltnm_status_icon = {
  type = "image_style",
  stretch_image_to_widget_size = true,
  size = 14
}

styles.ltnm_station_status_icon = {
  type = "image_style",
  parent = "ltnm_status_icon",
  left_margin = 2
}

-- -----------------------------------------------------------------------------
-- LABEL STYLES

styles.ltnm_material_locations_label = {
  type = "label_style",
  parent = "caption_label",
  left_margin = 2
}

styles.ltnm_paragraph_label = {
  type = "label_style",
  parent = "label",
  single_line = false
}

styles.ltnm_hoverable_bold_label = {
  type = "label_style",
  parent = "hoverable_bold_label",
  disabled_font_color = {
    r = 0.5 * (1 + default_orange_color.r),
    g = 0.5 * (1 + default_orange_color.g),
    b = 0.5 * (1 + default_orange_color.b)
  }
}

styles.ltnm_hoverable_label = {
  type = "label_style",
  parent = "ltnm_hoverable_bold_label",
  font = "default"
}

styles.ltnm_depot_button_caption_label = {
  type = "label_style",
  parent = "caption_label",
  disabled_font_color = button_default_bold_font_color
}

styles.ltnm_depot_button_bold_label = {
  type = "label_style",
  parent = "bold_label",
  disabled_font_color = button_default_bold_font_color
}

styles.ltnm_depot_button_label = {
  type = "label_style",
  parent = "label",
  disabled_font_color = button_default_font_color
}

-- -----------------------------------------------------------------------------
-- LINE STYLES

styles.ltnm_material_locations_line = {
  type = "line_style",
  top_padding = 2,
  bottom_padding = 4,
  left_padding = -4,
  right_padding = -4,
  horizontally_stretchable = "on"
}

-- -----------------------------------------------------------------------------
-- SCROLL PANE STYLES

styles.ltnm_blank_scroll_pane = {
  type = "scroll_pane_style",
  extra_padding_when_activated = 0,
  padding = 4,
  graphical_set = {
    shadow = default_inner_shadow
  }
}

styles.ltnm_depots_scroll_pane = {
  type = "scroll_pane_style",
  parent = "ltnm_blank_scroll_pane",
  padding = 0,
  vertically_stretchable = "on",
  width = 206,
  background_graphical_set = {
    position = {282, 17},
    corner_size = 8,
    overall_tiling_horizontal_padding = 4,
    overall_tiling_horizontal_size = 198,
    overall_tiling_horizontal_spacing = 8,
    overall_tiling_vertical_padding = 4,
    overall_tiling_vertical_size = 77,
    overall_tiling_vertical_spacing = 8
  },
  vertical_flow_style = {
    type = "vertical_flow_style",
    vertical_spacing = 0
  }
}

styles.ltnm_slot_table_scroll_pane = {
  type = "scroll_pane_style",
  parent = "ltnm_blank_scroll_pane",
  padding = 0,
  margin = 0,
  extra_padding_when_activated = 0,
  -- height = 160, -- height is adjusted at runtime
  horizontally_squashable = "off",
  background_graphical_set = {
    base = {
      position = {282, 17},
      corner_size = 8,
      overall_tiling_horizontal_padding = 4,
      overall_tiling_horizontal_size = 32,
      overall_tiling_horizontal_spacing = 8,
      overall_tiling_vertical_padding = 4,
      overall_tiling_vertical_size = 32,
      overall_tiling_vertical_spacing = 8
    }
  }
}

styles.ltnm_small_slot_table_scroll_pane = {
  type = "scroll_pane_style",
  parent = "ltnm_blank_scroll_pane",
  padding = 0,
  margin = 0,
  extra_padding_when_activated = 0,
  minimal_height = 36,
  horizontally_squashable = "off",
  background_graphical_set = {
    base = {
      position = {282, 17},
      corner_size = 8,
      overall_tiling_horizontal_padding = 4,
      overall_tiling_horizontal_size = 28,
      overall_tiling_horizontal_spacing = 8,
      overall_tiling_vertical_padding = 4,
      overall_tiling_vertical_size = 28,
      overall_tiling_vertical_spacing = 8
    }
  }
}

styles.ltnm_train_slot_table_scroll_pane = {
  type = "scroll_pane_style",
  parent = "ltnm_small_slot_table_scroll_pane",
  minimal_width = 144,
  maximal_height = 72
}

styles.ltnm_station_provided_requested_slot_table_scroll_pane = {
  type = "scroll_pane_style",
  parent = "ltnm_small_slot_table_scroll_pane",
  minimal_width = 180,
  maximal_height = 108
}

styles.ltnm_station_shipments_slot_table_scroll_pane = {
  type = "scroll_pane_style",
  parent = "ltnm_small_slot_table_scroll_pane",
  minimal_width = 144,
  maximal_height = 108
}

styles.ltnm_trains_scroll_pane = {
  type = "scroll_pane_style",
  parent = "ltnm_blank_scroll_pane",
  extra_right_padding_when_activated = -12
}

styles.ltnm_material_locations_scroll_pane = {
  type = "scroll_pane_style",
  parent = "ltnm_blank_scroll_pane",
  width = 370, -- hardcode width to prevent in-fighting between stretches
  vertical_flow_style = {
    type = "vertical_flow_style",
    padding = 5
  }
}

styles.ltnm_material_location_slot_table_scroll_pane = {
  type = "scroll_pane_style",
  parent = "ltnm_small_slot_table_scroll_pane",
  maximal_height = 216,
  horizontally_squashable = "off"
}

-- -----------------------------------------------------------------------------
-- SPRITE STYLES

styles.ltnm_inventory_selected_icon = {
  type = "image_style",
  width = 28,
  height = 28,
  stretch_image_to_widget_size = true
}

-- -----------------------------------------------------------------------------
-- TABLE STYLES

styles.ltnm_rows_table = {
  type = "table_style",
  border = {
    border_width = 8,
    horizontal_line = {position = {8, 40}, size = {1, 8}},
  },
  -- border = {
  --   border_width = 8,
  --   vertical_line = {position = {0, 40}, size = {8, 1}},
  --   horizontal_line = {position = {8, 40}, size = {1, 8}},
  --   top_right_corner = {position = {16, 40}, size = {8, 8}},
  --   bottom_right_corner = {position = {24, 40}, size = {8, 8}},
  --   bottom_left_corner = {position = {32, 40}, size = {8, 8}},
  --   top_left_coner = {position = {40, 40}, size = {8, 8}},
  --   top_t = {position = {64, 40}, size = {8, 8}},
  --   right_t = {position = {72, 40}, size = {8, 8}},
  --   bottom_t = {position = {48, 40}, size = {8, 8}},
  --   left_t = {position = {56, 40}, size = {8, 8}},
  --   cross = {position = {80, 40}, size = {8, 8}},
  --   top_end = {position = {88, 40}, size = {8, 8}},
  --   right_end = {position = {96, 40}, size = {8, 8}},
  --   bottom_end = {position = {104, 40}, size = {8, 8}},
  --   left_end = {position = {112, 40}, size = {8, 8}}
  -- },
  top_cell_padding = 6,
  bottom_cell_padding = 6,
  left_cell_padding = 4,
  right_cell_padding = 4
}

styles.ltnm_depot_trains_table = {
  type = "table_style",
  parent = "ltnm_rows_table",
  column_widths = {
    {column=1, width=120}
  }
}

styles.ltnm_stations_table = {
  type = "table_style",
  parent = "ltnm_rows_table",
  column_widths = {
    {column=2, width=24},
    {column=3, width=34},
    {column=4, width=180},
    {column=5, width=144},
    {column=6, width=144}
  },
  column_alignments = {
    {column=1, alignment="middle-left"},
    {column=2, alignment="middle-center"},
    {column=3, alignment="middle-center"},
    {column=4, alignment="middle-left"},
    {column=5, alignment="middle-left"},
    {column=6, alignment="middle-left"}
  }
}

styles.ltnm_slot_table = {
  type = "table_style",
  parent = "slot_table",
  horizontal_spacing = 0,
  vertical_spacing = 0
}

styles.ltnm_inventory_slot_table = {
  type = "table_style",
  parent = "ltnm_slot_table",
  width = 400
}

styles.ltnm_materials_in_location_slot_table = {
  type = "table_style",
  parent = "ltnm_small_slot_table",
  width = 324
}

styles.ltnm_small_slot_table = {
  type = "table_style",
  parent = "ltnm_slot_table",
  minimal_height = 36
}

styles.ltnm_depots_table = {
  type = "table_style",
  horizontal_spacing = 0,
  vertical_spacing = 0,
  padding = 0
}

styles.ltnm_material_locations_table = {
  type = "table_style",
  parent = "ltnm_rows_table",
  top_margin = 2,
  left_margin = -6,
  right_margin = -6,
  top_cell_padding = 4,
  bottom_cell_padding = 8,
  width = 352
}