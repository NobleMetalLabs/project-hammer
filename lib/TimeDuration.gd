class_name TimeDuration
extends Resource

const YEAR : int = 0
const MONTH : int = 1
const DAY : int = 2
const HOUR : int = 3
const MINUTE : int = 4
const SECOND : int = 5

var years : int = 0
var months : int = 0
var days : int = 0
var hours : int = 0
var minutes : int = 0
var seconds : int = 0

@warning_ignore("integer_division")
func add(value : int, unit : int) -> void:
	if unit == SECOND:
		seconds += value
		if seconds >= 60:
			value = seconds / 60
			seconds = seconds % 60
			unit = MINUTE
	elif unit == MINUTE:
		minutes += value
		if minutes >= 60:
			value = minutes / 60
			minutes = minutes % 60
			unit = HOUR
	elif unit == HOUR:
		hours += value
		if hours >= 24:
			value = hours / 24
			hours = hours % 24
			unit = DAY
	elif unit == DAY:
		days += value
		if days >= 30:
			value = days / 30
			days = days % 30
			unit = MONTH
	elif unit == MONTH:
		months += value
		if months >= 12:
			value = months / 12
			months = months % 12
			unit = YEAR
	elif unit == YEAR:
		years += value

@warning_ignore("integer_division")
func subtract(value : int, unit : int) -> void:
	if unit == SECOND:
		seconds -= value
		if seconds < 0:
			value = -seconds / 60 + 1
			seconds = 60 - (-seconds % 60)
			unit = MINUTE
	elif unit == MINUTE:
		minutes -= value
		if minutes < 0:
			value = -minutes / 60 + 1
			minutes = 60 - (-minutes % 60)
			unit = HOUR
	elif unit == HOUR:
		hours -= value
		if hours < 0:
			value = -hours / 24 + 1
			hours = 24 - (-hours % 24)
			unit = DAY
	elif unit == DAY:
		days -= value
		if days < 0:
			value = -days / 30 + 1
			days = 30 - (-days % 30)
			unit = MONTH
	elif unit == MONTH:
		months -= value
		if months < 0:
			value = -months / 12 + 1
			months = 12 - (-months % 12)
			unit = YEAR
	elif unit == YEAR:
		years -= value
		if years < 0:
			years = 0

func as_float(unit : int) -> float:
	match unit:
		SECOND: return years * 365 * 24 * 60 * 60 + months * 30 * 24 * 60 * 60 + days * 24 * 60 * 60 + hours * 60 * 60 + minutes * 60 + seconds
		MINUTE: return years * 365 * 24 * 60 + months * 30 * 24 * 60 + days * 24 * 60 + hours * 60 + minutes + seconds / 60.0
		HOUR: return years * 365 * 24 + months * 30 * 24 + days * 24 + hours + minutes / 60.0 + seconds / (60*60.0)
		DAY: return years * 365 + months * 30 + days + hours / (24.0) + minutes / (24*60.0) + seconds / (24*3600.0)
		MONTH: return years * 12 + months + days / (30.0) + hours / (30*24.0) + minutes / (30*1440.0) + seconds / (30*86400.0)
		YEAR: return years + months / (12.0) + days / (365.0) + hours / (365*24.0) + minutes / (365*1440.0) + seconds / (365*86400.0)
		_: 
			push_error("Invalid unit for TimeDuration.as_float()")
			return NAN