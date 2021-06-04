// move bullet first
x += lengthdir_x(spd, direction);
y += lengthdir_y(spd, direction);

// check for collision with something shootable first, and destroy bullet if so
if (place_meeting(x, y, pShootable))
{
	with (instance_place(x, y, pShootable)) 
	{
		hp--;
		flash = 3;
		hitfrom = other.direction;
	}
	instance_destroy();
}

// check for collision with wall then after
if (place_meeting(x,y,oWall)) 
{
	while (place_meeting(x,y,oWall))
	{
		x -= lengthdir_x(1, direction);
		y -= lengthdir_y(1, direction);	
	}
	spd = 0;
	instance_change(oHitSpark, true);
	layer_add_instance("Tiles",id);
	depth+=1;
}