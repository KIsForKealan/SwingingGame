/// @description Insert description here
// You can write your code in this editor
if (_webStartLength == 0)
{
	show_debug_message("WebStartLength is still 0 at draw step");
}

_webCurrentLength = oPlayer.ropeLength;


draw_sprite_ext(sWeb,0,oPlayer.grappleX,oPlayer.grappleY,1,(1),oPlayer.ropeAngle-180,c_white,1);	
	