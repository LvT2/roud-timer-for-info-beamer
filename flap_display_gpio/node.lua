local gpio_pin = "23" -- GPIO pin number (BCM)
local gpio_path = "/sys/class/gpio/gpio" .. gpio_pin .. "/value"
local last_time = nil
local flap_display_file = "flap_text.txt"

-- Function to read GPIO value
local function read_gpio()
    local file = io.open(gpio_path, "r")
    if file then
        local value = file:read("*l")
        file:close()
        return tonumber(value)
    end
    return nil
end

-- Initialize GPIO (only needed for local Raspberry Pi OS, not hosted)
if os.execute("[ -d /sys/class/gpio/gpio" .. gpio_pin .. " ]") ~= 0 then
    os.execute("echo " .. gpio_pin .. " > /sys/class/gpio/export 2>/dev/null")
    os.execute("echo in > /sys/class/gpio/gpio" .. gpio_pin .. "/direction")
end

function node.render()
    local current_value = read_gpio()

    if current_value == 0 then  -- Button pressed (LOW)
        local current_time = os.time()

        if last_time then
            local interval = current_time - last_time
            print("Interval: " .. interval .. " sec")

            -- Write interval to flap display text file
            local file = io.open(flap_display_file, "w")
            if file then
                file:write(string.format("%.2f sec", interval))
                file:close()
            end
        end

        last_time = current_time

        -- Debounce delay
        sys.sleep(0.1)
    end
end
