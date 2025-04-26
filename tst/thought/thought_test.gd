extends Node

func _ready():
	
	var pe := PersonalEvent.new(Actor.new())

	# "I saw a mining station."
	pe.tags.add_chain([Tag.ExperienceObservation, Tag.Thing]).deep().add_fan([Tag.ConceptStation, Tag.ConceptMining])

	# "I want my health to improve."
	pe.tags.add_chain([Tag.ExperienceThought, Tag.FeelingDesire, Tag.ConceptSelf, Tag.ConceptHealth, Tag.TrajectoryPositive])

	# "I saw a robot that scared me."
	pe.tags.add_chain([Tag.ExperienceObservation, Tag.Thing]).hold_deep().add_tag(Tag.ConceptRobotics).add_chain([Tag.RelationshipResult, Tag.FeelingFear])

	# "I should give this person a gift about planets."
	pe.tags.add_chain([Tag.ExperienceThought, Tag.FeelingResponsibility, Tag.RelationshipExternalReference])
	var gf := PersonalEvent.new(Actor.new()) 
	gf.tags.add_chain([Tag.ExperienceAction, Tag.ConceptGift]).deep().add_fan([Tag.RelationshipExternalReference, Tag.ConceptPlanet])
	pe.references.append(gf)
	pe.references.append(Actor.new())
	
	# "I thought about a location."
	pe.tags.add_chain([Tag.ExperienceThought, Tag.RelationshipExternalReference])
	pe.references.append(LocationSpot.new())
	
	# "I want to go to a location."
	pe.tags.add_chain([Tag.ExperienceThought, Tag.FeelingDesire, Tag.RelationshipExternalReference])
	var tv := PersonalEvent.new(Actor.new())
	tv.tags.add_chain([Tag.ExperienceAction, Tag.ConceptTravel, Tag.RelationshipExternalReference])
	pe.references.append(tv)
	pe.references.append(LocationSpot.new())

	# "I unwillingly thought of art about death."
	pe.tags.add_tag(Tag.ExperienceThought).hold_deep().add_tag(Tag.WillingnessNotWilling).add_chain([Tag.ConceptArt, Tag.ConceptDeath])
	
	print(pe)
