/// @description 

if (state == pState.swing) draw_line_color(grappleX,grappleY,ropeX,ropeY, c_black, c_black);
if (!instance_exists(oWeb)) && (state == pState.swing)
{
	instance_create_layer(x,y-5,"Gun",oWeb);
	
}

draw_self();
