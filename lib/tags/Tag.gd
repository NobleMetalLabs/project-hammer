#class_name Tag
extends Node

# Sort tag type by following categories:
# 	0 - 1000: ConceptTag
# 	1000 - 2000: Critically important/integral types
# 	2000 +: All other types
# Within each category, sort types alphabetically. Assign IDs sequentially in type, each type begining in an ID increment of 100.
# Eventually, very niche tags will probably get more compact increments.

#Concept
const Concept : int = 0
const ConceptAdaptation : int = 1
const ConceptAgriculture : int = 2
const ConceptAnomaly : int = 3
const ConceptArt : int = 4
const ConceptAsteroid : int = 5
const ConceptBiology : int = 6
const ConceptCaptain : int = 7
const ConceptChemistry : int = 8
const ConceptCargo : int = 9
const ConceptCombat : int = 20
const ConceptComet : int = 21
const ConceptCommerce : int = 22
const ConceptCommunication : int = 23
const ConceptConstruction : int = 24
const ConceptCulture : int = 25
const ConceptDefense : int = 26
const ConceptDiplomacy : int = 27
const ConceptEducation : int = 28
const ConceptEngineering : int = 29
const ConceptEntertainment : int = 20
const ConceptEthics : int = 21
const ConceptExploration : int = 22
const ConceptHealth : int = 23
const ConceptHistory : int = 24
const ConceptLaw : int = 25
const ConceptManufacturing : int = 26
const ConceptMathematics : int = 27
const ConceptMedicine : int = 28
const ConceptMining : int = 29
const ConceptPhilosophy : int = 30
const ConceptPhysics : int = 31
const ConceptPiloting : int = 32
const ConceptPlanet : int = 33
const ConceptPolitics : int = 34
const ConceptProduction : int = 35
const ConceptPsychics : int = 36
const ConceptPsychology : int = 37
const ConceptRecreation : int = 38
const ConceptReligion : int = 39
const ConceptResidence : int = 40
const ConceptResearch : int = 41
const ConceptRobotics : int = 42
const ConceptScience : int = 43
const ConceptShip : int = 44
const ConceptSocial : int = 45
const ConceptSociology : int = 46
const ConceptSpace : int = 47
const ConceptStar : int = 48
const ConceptStation : int = 49
const ConceptTrade : int = 50
const ConceptTravel : int = 51

# Relationship
const Relationship : int = 1000
const RelationshipFunction : int = 1001

# Perception
const Perception : int = 1100
const PerceptionVeryBad : int = 1101
const PerceptionBad : int = 1102
const PerceptionNeutral : int = 1103
const PerceptionGood : int = 1104
const PerceptionVeryGood : int = 1105

# HiddenInformation
const HiddenInformation : int = 1200

# AltitudeZone
const AltitudeZone : int = 2100
const AltitudeZoneBelowGround : int = 2101
const AltitudeZoneBelowSea : int = 2102
const AltitudeZoneSea : int = 2103
const AltitudeZoneLow : int = 2104
const AltitudeZoneAverage : int = 2105
const AltitudeZoneMid : int = 2106
const AltitudeZoneHigh : int = 2107
const AltitudeZoneBodyOrbit : int = 2108
const AltitudeZoneStellarOrbit : int = 2109
const AltitudeZoneInterstellarSpace : int = 2110

# CelestialObjectSize
const CelestialObjectSize : int = 2200
const CelestialObjectSizeTiny : int = 2201
const CelestialObjectSizeSmall : int = 2202
const CelestialObjectSizeRegular : int = 2203
const CelestialObjectSizeMedium : int = 2204
const CelestialObjectSizeLarge : int = 2205
const CelestialObjectSizeHuge : int = 2206

# CelestialObjectType
const CelestialObjectType : int = 2300
const CelestialObjectTypePlanet : int = 2301
const CelestialObjectTypeMoon : int = 2302
const CelestialObjectTypeShip : int = 2303
const CelestialObjectTypeSpaceStation : int = 2304
const CelestialObjectTypeAsteroid : int = 2305
const CelestialObjectTypeComet : int = 2306
const CelestialObjectTypeAnomaly : int = 2307
const CelestialObjectTypeStar : int = 2308

# ClimateBaseline
const ClimateBaseline : int = 2400
const ClimateBaselineNone : int = 2401
const ClimateBaselineVolcanic : int = 2402
const ClimateBaselineArid : int = 2403
const ClimateBaselineHot : int = 2404
const ClimateBaselineRegular : int = 2405
const ClimateBaselineCold : int = 2406
const ClimateBaselineArctic : int = 2407
const ClimateBaselineTropic : int = 2408
const ClimateBaselineOcean : int = 2409

# ClimateDiversity
const ClimateDiversity : int = 2500
const ClimateDiversityNone : int = 2501
const ClimateDiversityUnusual : int = 2502
const ClimateDiversityExtreme : int = 2503
const ClimateDiversityMild : int = 2504
const ClimateDiversityRegular : int = 2505
const ClimateDiversityLow : int = 2506
const ClimateDiversityMinimal : int = 2507

# SkillFamiliarity
const SkillFamiliarity : int = 2600
const SkillFamiliarityNone : int = 2601
const SkillFamiliarityBeginner : int = 2602
const SkillFamiliarityNovice : int = 2603
const SkillFamiliarityIntermediate : int = 2604
const SkillFamiliarityExpert : int = 2605

# SkillRelationship
const SkillRelationship : int = 2700
const SkillRelationshipSocial : int = 2701
const SkillRelationshipHobby : int = 2702
const SkillRelationshipProfession : int = 2703

# StarColor
const StarColor : int = 2800
const StarColorRed : int = 2801
const StarColorOrange : int = 2802
const StarColorYellow : int = 2803
const StarColorGreen : int = 2804
const StarColorBlue : int = 2805
const StarColorWhite : int = 2806
const StarColorBlack : int = 2807

func get_tag_name(id : int) -> StringName:
	return self.get_script().get_script_constant_map().find_key(id)

func get_tag_type_num_values(type_id : int) -> int:
	if type_id % 100 != 0:
		push_error("type_id must be type tag (multiple of 100)")
	var const_dict : Dictionary = self.get_script().get_script_constant_map()
	var cnt : int = 0
	while const_dict.values().has(type_id + cnt):
		cnt += 1
	return cnt

func is_tag_of_type(id : int, type_id : int) -> bool:
	if type_id % 100 != 0:
		push_error("type_id must be type tag (multiple of 100)")
	if id < 1000:
		return type_id == Concept
	else:
		@warning_ignore("integer_division")
		return (id / 100) * 100 == type_id

# TODO:
# tag brainstorm --- 03/24/2025
#
# "hidden information tag"
# has a callable(?) and array of tags, callable returns if the information is visible or not
# we figure that out later when gameevent is matured
# what could be hidden?
# function for locations, status/skills for characters, faction for events?, 
# 
# + related idea, narrativechunks should and will have hidden choices (e.g. skillcheck / other)
#
# ethics tags somehow
# may be used for places / events / characters
#
# luh mental illness that affects ethics or something
# status - fame or perhaps even infamy - could be good or bad
