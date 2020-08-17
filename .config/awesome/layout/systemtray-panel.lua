local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TaskList = require('widget.task-list')
local TagList = require('widget.tag-list')
local gears = require('gears')
local clickable_container = require('widget.material.clickable-container')
local mat_icon_button = require('widget.material.icon-button')
local mat_icon = require('widget.material.icon')

local dpi = require('beautiful').xresources.apply_dpi

local icons = require('theme.icons')

-- Clock / Calendar 24h format
local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 9">%d.%m.%Y\n     %H:%M</span>')

-- Clock / Calendar 12AM/PM fornat
-- local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 9">%d.%m.%Y\n  %I:%M %p</span>\n<span font="Roboto Mono bold 9">%p</span>')
-- textclock.forced_height = 56

-- Add a calendar (credits to kylekewley for the original code)
local month_calendar = awful.widget.calendar_popup.month({
  screen = s,
  start_sunday = false,
  week_numbers = true
})
month_calendar:attach(textclock)

local clock_widget = wibox.container.margin(textclock, dpi(13), dpi(13), dpi(8), dpi(8))

local systray = wibox.widget.systray()
systray:set_horizontal(true)
systray:set_base_size(32)

local add_button = mat_icon_button(mat_icon(icons.plus, dpi(24)))
add_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn(
          awful.screen.focused().selected_tag.defaultApp,
          {
            tag = _G.mouse.screen.selected_tag,
            placement = awful.placement.bottom_right
          }
        )
      end
    )
  )
)

local TopPanel = function(s, offset)
  local offsetx = 0
  if offset == true then
    offsetx = dpi(128)
    offsety = dpi(12)
  end
  local panel =
    wibox(
    {
      ontop = false,
      screen = s,
      height = dpi(32),
      width = dpi(128),
      x = s.geometry.width - dpi(316),
      y = s.geometry.y  + offsety,
      stretch = false,
      bg = beautiful.background.hue_800,
      fg = beautiful.fg_normal,
      struts = {
        top = dpi(32)
      }
    }
  )

  panel:struts(
    {
      top = dpi(44)
    }
  )

  panel:setup {
      layout = wibox.layout.align.horizontal,
	  wibox.container.margin(systray, dpi(4), dpi(4), dpi(4), dpi(4)),
	  nil,
	  require('widget.battery'),
  }

  return panel
end

return TopPanel
