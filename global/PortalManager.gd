extends Node

signal new_portal

var blue_portal = null
var blue_portal_fixed = false
var orange_portal = null
var orange_portal_fixed = false

func _ready():
    Game.connect("goto_scene", self, "reset_pointers")

func register_portal(new_portal, fixed = false):
    match new_portal.type:
        0:
            if blue_portal != null and blue_portal.get_ref(): blue_portal.get_ref().close_portal()
            blue_portal = weakref(new_portal)
            blue_portal_fixed = fixed
        1:
            if orange_portal != null and orange_portal.get_ref(): orange_portal.get_ref().close_portal()
            orange_portal = weakref(new_portal)
            orange_portal_fixed = fixed
    
    if blue_portal != null and blue_portal.get_ref(): blue_portal.get_ref().link_portal(orange_portal)
    if orange_portal != null and orange_portal.get_ref(): orange_portal.get_ref().link_portal(blue_portal)
    
    emit_signal("new_portal")
    

func close_portals():
    if (!blue_portal_fixed and blue_portal != null and blue_portal.get_ref()):
        blue_portal.get_ref().close_portal()
        blue_portal = null
    if (!orange_portal_fixed and orange_portal != null and orange_portal.get_ref()):
        orange_portal.get_ref().close_portal()
        orange_portal = null

func force_close_portals():
    if (blue_portal != null and blue_portal.get_ref()):
        blue_portal.get_ref().close_portal()
        blue_portal = null
    if (orange_portal != null and orange_portal.get_ref()):
        orange_portal.get_ref().close_portal()
        orange_portal = null

func reset_pointers():
    blue_portal = null
    blue_portal_fixed = false
    orange_portal = null
    orange_portal_fixed = false
