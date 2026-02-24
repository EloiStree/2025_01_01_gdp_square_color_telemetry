class_name ColometryTextToBrgbFont 
extends Node
## See https://github.com/EloiStree/2025_07_23_wow_addons_text_to_color_telemetry/blob/main/MAIN_CODE.lua
@export var byte_to_parse_as_color: Array[int] = [1,2,3,4,5,6,7,8,9,10]
@export var text_to_display_black:String = "abcdefghijklmnop"
@export var text_to_display_red:String = "abcdefghijklmnop"
@export var text_to_display_green:String = "abcdefghijklmnop"
@export var text_to_display_blue:String = "abcdefghijklmnop"
@export var label_black:Label = null
@export var label_red:Label = null
@export var label_green:Label = null
@export var label_blue:Label = null
@export var label_white_bar:Label = null
@export var set_text_to_display_on_ready: bool = true

@export var test_255:=true
func _ready() -> void:
	label_red.text = text_to_display_red
	label_green.text = text_to_display_green
	label_blue.text = text_to_display_blue
	label_black.text = text_to_display_black
	label_white_bar.text = text_to_display_black
	if test_255:
		byte_to_parse_as_color.resize(256)
		for i in range(0,255,1):
			byte_to_parse_as_color[i] = i
			

			
	if set_text_to_display_on_ready:
		set_text_to_display_brgb()

enum ColorIndex {
	BLACK = 0,
	RED = 1,
	GREEN = 2,
	BLUE = 3,
}
var brgb_color = [
	Color(0, 0, 0, 1), #-- black
	Color(1, 0, 0, 1), #-- red
	Color(0, 1, 0, 1), #-- green
	Color(0, 0, 1, 1), #-- blue
]

func get_brgb_from_index(hh: int) -> Array[int]:
	var size: int = brgb_color.size()
	var bit1Frequence: int = hh % size
	var bit2Frequence: int = int(hh / size) % size
	var bit3Frequence: int = int(hh / (size * size)) % size
	var bit4Frequence: int = int(hh / (size * size * size)) % size
	return [bit1Frequence, bit2Frequence, bit3Frequence, bit4Frequence]


func get_utf8_from_brgb_index(gg: int, colorid: int) -> String:
	var brgb = get_brgb_from_index(gg)
	var b1 = brgb[0]
	var b2 = brgb[1]
	var b3 = brgb[2]
	var b4 = brgb[3]

	if b1 != colorid and b2 != colorid and b3 != colorid and b4 != colorid:
		return "a"
	elif b1 == colorid and b2 != colorid and b3 != colorid and b4 != colorid:
		return "b"
	elif b1 != colorid and b2 == colorid and b3 != colorid and b4 != colorid:
		return "c"
	elif b1 == colorid and b2 == colorid and b3 != colorid and b4 != colorid:
		return "d"
	elif b1 != colorid and b2 != colorid and b3 == colorid and b4 != colorid:
		return "e"
	elif b1 == colorid and b2 != colorid and b3 == colorid and b4 != colorid:
		return "f"
	elif b1 != colorid and b2 == colorid and b3 == colorid and b4 != colorid:
		return "g"
	elif b1 == colorid and b2 == colorid and b3 == colorid and b4 != colorid:
		return "h"
	elif b1 != colorid and b2 != colorid and b3 != colorid and b4 == colorid:
		return "i"
	elif b1 == colorid and b2 != colorid and b3 != colorid and b4 == colorid:
		return "j"
	elif b1 != colorid and b2 == colorid and b3 != colorid and b4 == colorid:
		return "k"
	elif b1 == colorid and b2 == colorid and b3 != colorid and b4 == colorid:
		return "l"
	elif b1 != colorid and b2 != colorid and b3 == colorid and b4 == colorid:
		return "m"
	elif b1 == colorid and b2 != colorid and b3 == colorid and b4 == colorid:
		return "n"
	elif b1 != colorid and b2 == colorid and b3 == colorid and b4 == colorid:
		return "o"
	elif b1 == colorid and b2 == colorid and b3 == colorid and b4 == colorid:
		return "p"	

	
	return "a" # Default case, should not happen

# Assuming this enum exists in your script

func char_to_int_utf8(char: String) -> int:
	return char.unicode_at(0)

func set_text_to_display_brgb() -> void:
	# Using local variables to build strings
	var black_string: String = "p"
	var red_string: String = "p"
	var green_string: String = "p"
	var blue_string: String = "p"
	var white_bar_string: String = "p"

	for char_code in byte_to_parse_as_color:
		black_string += get_utf8_from_brgb_index(char_code, ColorIndex.BLACK)
		red_string += get_utf8_from_brgb_index(char_code, ColorIndex.RED)
		green_string += get_utf8_from_brgb_index(char_code, ColorIndex.GREEN)
		blue_string += get_utf8_from_brgb_index(char_code, ColorIndex.BLUE)
		white_bar_string += "a"


	# Assigning to the Label nodes (assuming they are defined as @onready variables)
	label_black.text = black_string+"p"
	label_red.text = red_string+"p"
	label_green.text = green_string+"p"
	label_blue.text = blue_string+"p"
	label_white_bar.text = white_bar_string+"p"
#
#local brgb_color ={
	#{0, 0, 0, 1}, -- black
	#{1, 0, 0, 1}, -- red
	#{0, 1, 0, 1}, -- green
	#{0, 0, 1, 1}, -- blue
	#-- IF YOU WANT MORE BITS 
	#-- {0, 1, 1, 1}, -- cyan
	#-- {1, 1, 0, 1}, -- yellow
	#-- {1, 0, 1, 1}, -- magenta
	#-- {1, 1, 1, 1}  -- white
#}
#
#-- create enum back  red green blue
#local black = 0
#local red = 1
#local green = 2
#local blue = 3
#local cyan = 4
#local yellow = 5
#local magenta = 6
#local white = 7
	#
#function get_brgb_from_index(hh)
	#local bit1Frequence = hh % #brgb_color
	#local bit2Frequence = math.floor(hh / #brgb_color) % #brgb_color
	#local bit3Frequence = (math.floor(hh / (#brgb_color * #brgb_color)) % #brgb_color)
	#local bit4Frequence = (math.floor(hh / (#brgb_color * #brgb_color * #brgb_color)) % #brgb_color)
	#return bit1Frequence, bit2Frequence, bit3Frequence, bit4Frequence
#end
#
#function get_utf8_from_brgb_index(gg, colorid)
	#local b1, b2, b3, b4 = get_brgb_from_index(gg)
#
		#if b1 ~= colorid and b2 ~= colorid and b3 ~= colorid and b4 ~= colorid then
		#return "a"
	#elseif b1 == colorid and b2 ~= colorid and b3 ~= colorid and b4 ~= colorid then
		#return "b"
	#elseif b1 ~= colorid and b2 == colorid and b3 ~= colorid and b4 ~= colorid then
		#return "c"
	#elseif b1 == colorid and b2 == colorid and b3 ~= colorid and b4 ~= colorid then
		#return "d"
	#elseif b1 ~= colorid and b2 ~= colorid and b3 == colorid and b4 ~= colorid then
		#return "e"
	#elseif b1 == colorid and b2 ~= colorid and b3 == colorid and b4 ~= colorid then
		#return "f"
	#elseif b1 ~= colorid and b2 == colorid and b3 == colorid and b4 ~= colorid then
		#return "g"
	#elseif b1 == colorid and b2 == colorid and b3 == colorid and b4 ~= colorid then
		#return "h"
	#elseif b1 ~= colorid and b2 ~= colorid and b3 ~= colorid and b4 == colorid then
		#return "i"
	#elseif b1 == colorid and b2 ~= colorid and b3 ~= colorid and b4 == colorid then
		#return "j"
	#elseif b1 ~= colorid and b2 == colorid and b3 ~= colorid and b4 == colorid then
		#return "k"
	#elseif b1 == colorid and b2 == colorid and b3 ~= colorid and b4 == colorid then
		#return "l"
	#elseif b1 ~= colorid and b2 ~= colorid and b3 == colorid and b4 == colorid then
		#return "m"
	#elseif b1 == colorid and b2 ~= colorid and b3 == colorid and b4 == colorid then
		#return "n"
	#elseif b1 ~= colorid and b2 == colorid and b3 == colorid and b4 == colorid then
		#return "o"
	#elseif b1 == colorid and b2 == colorid and b3 == colorid and b4 == colorid then
		#return "p"
	#end
#
	#return "a" -- Default case, should not happen
#end
#
#function set_text_to_display_brgb(text)
	#local black_string = "p"
	#local red_string = "p"
	#local green_string = "p"
	#local blue_string = "p"
	#local cyan_string = "p"
	#local yellow_string = "p"
	#local magenta_string = "p"
	#local white_string = "p"
	#local hide_zero = "p"
	#for i = 1, #text do
		#local char = text:sub(i, i)
		#local jj = string.byte(char)
			#local black_char = get_utf8_from_brgb_index(jj, black)
			#local red_char = get_utf8_from_brgb_index(jj, red)
			#local green_char = get_utf8_from_brgb_index(jj, green)
			#local blue_char = get_utf8_from_brgb_index(jj, blue)
		#black_string   = black_string   .. black_char
		#red_string     = red_string     .. red_char
		#green_string   = green_string   .. green_char
		#blue_string    = blue_string    .. blue_char
		#cyan_string    = cyan_string    .. get_utf8_from_brgb_index(jj, cyan)
		#-- yellow_string  = yellow_string  .. get_utf8_from_brgb_index(jj, yellow)
		#-- magenta_string = magenta_string .. get_utf8_from_brgb_index(jj, magenta)
		#white_string   = white_string   .. get_utf8_from_brgb_index(jj, white)
		#hide_zero      = hide_zero      .. "0"
	#end
#
	#cyan_string = cyan_string .. "p"
	#frameCode.text_black:SetText(black_string)
	#frameCode.text_red:SetText(red_string)
	#frameCode.text_green:SetText(green_string)
	#frameCode.text_blue:SetText(blue_string)
	#frameCode.text_cyan:SetText(cyan_string)
	#-- frameCode.text_yellow:SetText(yellow_string)
	#-- frameCode.text_magenta:SetText(magenta_string)
	#--frameCode.text_white:SetText(white_string)
	#-- frameCode.text_hide_zero:SetText(hide_zero)
#end
