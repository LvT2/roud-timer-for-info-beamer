local flap_display_file = "../flap_display_gpio/flap_text.txt"
local last_displayed = ""

function node.render()
    local file = io.open(flap_display_file, "r")
    if file then
        local new_text = file:read("*l")
        file:close()

        if new_text and new_text ~= last_displayed then
            print("Updating display:", new_text)
            gl.clear(0, 0, 0, 1) -- Clear screen (black background)
            font:write(100, 100, new_text, 50, 1, 1, 1, 1) -- White text
            last_displayed = new_text
        end
    end
end
