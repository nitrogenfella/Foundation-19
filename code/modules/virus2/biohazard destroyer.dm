/obj/machinery/disease2/biodestroyer
	name = "Biohazard destroyer"
	icon = 'icons/obj/pipes/disposal.dmi'
	icon_state = "disposalbio"
	var/list/accepts = list(/obj/item/clothing,/obj/item/weapon/virusdish/,/obj/item/weapon/cureimplanter,/obj/item/weapon/diseasedisk,/obj/item/weapon/reagent_containers)
	density = TRUE
	anchored = TRUE

/obj/machinery/disease2/biodestroyer/attackby(obj/I as obj, mob/user as mob)
	for(var/path in accepts)
		if(I.type in typesof(path))
			user.drop_item()
			qdel(I)
			add_overlay(image('icons/obj/pipes/disposal.dmi', "dispover-handle"))
			return
	user.drop_item()
	I.loc = src.loc

	for(var/mob/O in hearers(src, null))
		O.show_message("\icon[src] <span class='notice'>\The [src] beeps</span>", 2)
