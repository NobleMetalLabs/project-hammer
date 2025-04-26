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
const ConceptCare : int = 8
const ConceptCaptivity : int = 9
const ConceptCargo : int = 10
const ConceptChemistry : int = 11
const ConceptCombat : int = 12
const ConceptComet : int = 13
const ConceptCommerce : int = 14
const ConceptCommunication : int = 15
const ConceptConsolation : int = 16
const ConceptConstruction : int = 17
const ConceptCulture : int = 18
const ConceptDanger : int = 19
const ConceptDeath : int = 20
const ConceptDefense : int = 21
const ConceptDiplomacy : int = 22
const ConceptDisability : int = 23
const ConceptEducation : int = 24
const ConceptEmotion : int = 25
const ConceptEngineering : int = 26
const ConceptEntertainment : int = 27
const ConceptEnvironment : int = 28
const ConceptEthics : int = 29
const ConceptExploration : int = 30
const ConceptFood : int = 31
const ConceptFreedom : int = 32
const ConceptGift : int = 33
const ConceptGrowth : int = 34
const ConceptHealth : int = 35
const ConceptHistory : int = 36
const ConceptIllness : int = 37
const ConceptInjury : int = 38
const ConceptIntelligence : int = 39
const ConceptInteraction : int = 40
const ConceptJudgement : int = 41
const ConceptKnowledge : int = 42
const ConceptLaw : int = 43
const ConceptManufacturing : int = 44
const ConceptMathematics : int = 45
const ConceptMedicine : int = 46
const ConceptMining : int = 47
const ConceptMortality : int = 48
const ConceptObservation : int = 49
const ConceptObstacle : int = 50
const ConceptPhilosophy : int = 51
const ConceptPhysics : int = 52
const ConceptPiloting : int = 53
const ConceptPlanet : int = 54
const ConceptPolitics : int = 55
const ConceptProfession : int = 56
const ConceptProduction : int = 57
const ConceptPsychics : int = 58
const ConceptPsychology : int = 59
const ConceptRecreation : int = 60
const ConceptRelationship : int = 61
const ConceptReligion : int = 62
const ConceptRemains : int = 63
const ConceptResearch : int = 64
const ConceptResidence : int = 65
const ConceptRest : int = 66
const ConceptRobotics : int = 67
const ConceptScience : int = 68
const ConceptSelf : int = 69
const ConceptService : int = 70
const ConceptShip : int = 71
const ConceptSkill : int = 72
const ConceptSleep : int = 73
const ConceptSocial : int = 74
const ConceptSociology : int = 75
const ConceptSpace : int = 76
const ConceptStar : int = 77
const ConceptStation : int = 78
const ConceptSuccess : int = 79
const ConceptSurvival : int = 80
const ConceptSuspension : int = 81
const ConceptThought : int = 82
const ConceptTime : int = 83
const ConceptTrade : int = 84
const ConceptTravel : int = 85
const ConceptTrash : int = 86
const ConceptValue : int = 87
#TODO: remember to update
#"Sort these items alphabetically, then reset their values to remain sequential"

# Relationship
const Relationship : int = 1000
const RelationshipFunction : int = 1001
const RelationshipInverse : int = 1002
const RelationshipExternalReference : int = 1003
const RelationshipFrom : int = 1004
const RelationshipStatus : int = 1005
const RelationshipResult : int = 1006

# RelationshipAlteration
const RelationshipAlteration : int = 1100
const RelationshipAlterationGain : int = 1101
const RelationshipAlterationLoss : int = 1102
const RelationshipAlterationSubjectTo : int = 1103
const RelationshipAlterationRelievedFrom : int = 1104
const RelationshipAlterationSeperation : int = 1105
const RelationshipAlterationCombination : int = 1106

# Experience
const Experience : int = 1200
const ExperienceInteraction : int = 1201
const ExperienceObservation : int = 1202
const ExperienceThought : int = 1203
const ExperienceAction : int = 1204
const ExperienceJudgement : int = 1205
const ExperiencePossession : int = 1206
const ExperienceSituation : int = 1207

# Feeling
const Feeling : int = 1300
const FeelingNone : int = 1301
const FeelingComfort : int = 1302
const FeelingSafety : int = 1303
const FeelingHappiness : int = 1304
const FeelingValued : int = 1305
const FeelingLove : int = 1306
const FeelingFear : int = 1307
const FeelingDesire : int = 1308
const FeelingAnxiety : int = 1309
const FeelingResponsibility : int = 1310

# Perception
const Perception : int = 1400
const PerceptionVeryBad : int = 1401
const PerceptionBad : int = 1402
const PerceptionNeutral : int = 1403
const PerceptionGood : int = 1404
const PerceptionVeryGood : int = 1405

# Trajectory
const Trajectory : int = 1500
const TrajectoryNone : int = 1501
const TrajectoryNegative : int = 1502
const TrajectoryPositive : int = 1503
const TrajectoryBackward : int = 1504
const TrajectoryForward : int = 1505

# Tense
const Tense : int = 1600
const TensePast : int = 1601
const TensePresent : int = 1602
const TenseFuture : int = 1603

# Willingness
const Willingness : int = 1700
const WillingnessUnderDuress : int = 1701
const WillingnessNotWilling : int = 1702
const WillingnessWilling : int = 1703
const WillingnessExtreme : int = 1704

# Thing (Object)
const Thing : int = 1800

# HiddenInformation
const HiddenInformation : int = 1900

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

#TODO: make this shit a static class lol

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
