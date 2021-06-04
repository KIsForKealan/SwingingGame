// move bullet first
x += lengthdir_x(spd, direction);
y += lengthdir_y(spd, direction);


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
	
}