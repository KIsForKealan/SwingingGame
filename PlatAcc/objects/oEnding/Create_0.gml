/// @description 

gunsprite = layer_sprite_get_id("TitleAssets","gGun");
if (global.hasgun == true) && (global.kills > 0)
{
	endtext[0] = "And on this day our hero had slain " + string(global.kills) + " people.";	
	if (global.kills == 1) endtext[0] = "And on this day our hero killed a guy for no reason."
	endtext[1] = "But some of those people had guns too.";
	endtext[2] = "He was probably saving the world or something.";
	endtext[3] = "Regardless he was arrested two days later...";
	endtext[4] = "The defense team tried to argue that the recoil effects and hit flashes were to blame, \nbut to no avail.";
	endtext[5] = "The park ranger would later state \"Not angry,just disappointed.\" ";
	endtext[6] = "The end.";
}
else 
{
	layer_sprite_destroy(gunsprite);
	endtext[0] = "And on this day our hero took a walk through the park \nand didn't murder anyone.";
	endtext[1] = "They reported a discarded firearm to the local authorities \nand were thanked profusely for their assistance.";
	endtext[2] = "And all it took was behaviour that outside a video game context \none would hope is completely normal.";
	endtext[3] = "Who would have thought?";
	endtext[4] = "The end.";
}

spd = 0.5;
letters = 0;
currentline = 0;
length = string_length(endtext[currentline]);
text = "";