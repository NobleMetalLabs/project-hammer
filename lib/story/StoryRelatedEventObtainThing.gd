class_name StoryRelatedEventObtainThing 
extends StoryRelatedEvent
	
var thing : StringName = ""

#types:
# - Perform <action> multiple times
# 	- Travel to <place>
# 		- Escort <person> to <place>
# 		- Explore <area>
# 	- Speak to <person>
# 		- Rescue <person>
# 		- Deliver <thing> to <person/place>
# 	- Obtain <thing>
# 		- Build or craft <thing>
# 		- Gather <resources>
# 	- Something happen to <crew>
# 		- Recruit <person>
# 	- Complete <StoryEvent> with <outcome>
# 		- Hack/disable <device>
# 		- Defend <place/person>
# 		- Investigate <mystery/event>
# 		- Use <item> at <place>
# 		- Solve <puzzle>