/obj/effect/portal
	name = "portal"
	desc = "Looks unstable. Best to test it with the clown."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "portal"
	density = TRUE
	unacidable = TRUE
	var/obj/item/target = null
	var/creator = null
	anchored = TRUE
	var/dangerous = 0
	var/failchance = 0
	var/precision = 1

/obj/effect/portal/Bumped(mob/M as mob|obj)
	spawn(0)
		src.teleport(M)
		return
	return

/obj/effect/portal/Crossed(AM as mob|obj)
	spawn(0)
		src.teleport(AM)
		return
	return

/obj/effect/portal/attack_hand(mob/user as mob)
	spawn(0)
		src.teleport(user)
		return
	return

/obj/effect/portal/New(start, end, delete_after = 300, failure_rate, prec = 1)
	..()
	if(failure_rate)
		failchance = failure_rate
		if(prob(failchance))
			icon_state = "portal1"
			dangerous = 1
	playsound(src, 'sound/effects/phasein.ogg', 25, 1)
	target = end

	precision = prec

	if(delete_after)
		QDEL_IN(src, delete_after)

/obj/effect/portal/Destroy()
	target = null
	. = ..()

/obj/effect/portal/proc/teleport(atom/movable/M as mob|obj)
	if(istype(M, /obj/effect)) //sparks don't teleport
		return
	if (icon_state == "portal1")
		return
	if (!( target ))
		qdel(src)
		return
	if (istype(M, /atom/movable))
		if(dangerous && prob(failchance)) //oh dear a problem, put em in deep space
			var/destination_z = GLOB.using_map.get_transit_zlevel(z)
			do_teleport(M, locate(rand(TRANSITIONEDGE, world.maxx - TRANSITIONEDGE), rand(TRANSITIONEDGE, world.maxy -TRANSITIONEDGE), destination_z), 0)
		else
			do_teleport(M, target, precision)
