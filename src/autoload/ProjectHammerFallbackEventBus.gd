#class_name ProjectHammerFallbackEventBus
extends Node

var subscriptions : Dictionary = {} #Dictionary[StringName, Array[Callable]]
var mediators : Dictionary = {} #Dictionary[StringName, Callable]

func subscribe(event_name : StringName, return_address : Callable) -> void:
	if !subscriptions.has(event_name): 
		var new : Array[Callable] = []
		subscriptions[event_name] = new

	var event_subscribers : Array[Callable] = subscriptions[event_name]
	event_subscribers.append(return_address)
	ProjectHammerLogger.log(["EVENT"], "Object %s subscribed to event %s" % [return_address.get_object(), event_name])
	return

func unsubscribe(event_name : StringName, return_address : Callable) -> void:
	if !subscriptions.has(event_name): 
		return
	
	var event_subscribers : Array[Callable] = subscriptions[event_name]
	event_subscribers.erase(return_address)
	ProjectHammerLogger.log(["EVENT"], "Object %s unsubscribed from event %s" % [return_address.get_object(), event_name])
	return

func mediate(event_name : StringName, return_address : Callable) -> void:
	if mediators.has(event_name):
		ProjectHammerLogger.error("ERROR: Recieved request to mediate event \"%s\", but it already has a mediator." % [event_name])
		return
		
	mediators[event_name] = return_address
	ProjectHammerLogger.log(["EVENT"], "Object %s now mediates event '%s'" % [return_address.get_object(), event_name])
	return

func push_events(data : Dictionary = {}) -> void:
	for event_name : StringName in data.keys():
		var single_event : Dictionary = data[event_name]
		push_event(event_name, single_event)

func push_event(event_name : StringName, data : Dictionary = {}) -> void:
	var event_subscribers : Array[Callable] = []
	if subscriptions.has(event_name):
		event_subscribers = subscriptions[event_name]
		for event_subscriber : Callable in event_subscribers:
			if mediators.has(event_name):
				var mediator : Callable = mediators[event_name]
				event_subscriber.call(mediator.call(data))
			else:
				event_subscriber.call(data)

	if subscriptions.has("*"):
		event_subscribers = subscriptions["*"]
		for event_subscriber : Callable in event_subscribers:
			if mediators.has(event_name):
				var mediator : Callable = mediators[event_name]
				event_subscriber.call(event_name, mediator.call(data))
			else:
				event_subscriber.call(event_name, data)
	if not event_name.contains("log_message") and not event_name.contains("error_message"):
		ProjectHammerLogger.log(["EVENT"], "Event '%s' pushed to %s subscribers" % [event_name, len(event_subscribers)])
	return
