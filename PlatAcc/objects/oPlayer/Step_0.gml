if (hascontrol)
{
	grounded = (place_meeting(x,y+1,oWall));

	// Get player input
	var _keyLeft = keyboard_check(vk_left);
	var _keyRight = keyboard_check(vk_right);
	var _keyUp = keyboard_check(vk_up);
	var _keyDown = keyboard_check(vk_down);
	var _keyJump = keyboard_check_pressed(vk_space);
	var _keyGrapple = keyboard_check(vk_shift);
	
	switch (state)
	{
		case pState.normal:
		{
			//hSpeed = (keyRight - keyLeft) * walkSpeed;
			var _dir = _keyRight - _keyLeft;
			hSpeed += _dir * walkAcceleration;
			
			if (_dir==0)
			{
				var _hFriction = hFrictionGround;
				if (!grounded) _hFriction = hFrictionAir;
				hSpeed = Approach(hSpeed,0,_hFriction);
			}
			hSpeed = clamp(hSpeed,-walkSpeed,walkSpeed);
			vSpeed += gravity_;
			
			if (_keyJump) && (grounded)
			{
				grounded = false;
				vSpeedFraction = 0;
				vSpeed = -jumpSpeed;
			}
			
			nearestGrapple = instance_nearest(x,y,oWallGrapple);
			
			if (_keyGrapple) && (distance_to_object(nearestGrapple)<grappleDistanceMax)
			{
				
				grappleX = nearestGrapple.x;
				grappleY = nearestGrapple.y;
				ropeX = x;
				ropeY = y;
				//Carry momentum here
				ropeAngleVelocity = 0;
				ropeAngle = point_direction(grappleX,grappleY,x,y);
				ropeLength = point_distance(grappleX,grappleY,x,y);
				
				state = pState.swing;
				
			}
			
		} break;
		
		case pState.swing:
		{
			//Store how quick player accelerates along the angle of the circle
			//dcos works in degrees instead of cos with radians
			//dcos(0) is 1, dcos(90) is 0, dcos(180) is -1, smooth curve
			//accelerate fastest when at right angles with the floor
			// -0.2 is ropeAccelerationRate
			var _ropeAngleAcceleration = -0.2*dcos(ropeAngle);
			_ropeAngleAcceleration += (_keyRight - _keyLeft) * 0.08;
			ropeLength += (_keyDown - _keyUp) * 2;
			ropeLength = max(ropeLength,0);
			
			
			ropeAngleVelocity += _ropeAngleAcceleration;
			ropeAngle += ropeAngleVelocity;
			ropeAngleVelocity *= 0.99;
			
			ropeX = grappleX + lengthdir_x(ropeLength,ropeAngle);
			ropeY = grappleY + lengthdir_y(ropeLength,ropeAngle);
			
			hSpeed = ropeX - x;
			vSpeed = ropeY - y;
			
			if (_keyJump)
			{
				state = pState.normal;
				vSpeedFraction = 0;
				vSpeed = -jumpSpeed+3;
			}
			
		} break;
	}
	
	hSpeed += hSpeedFraction;
	vSpeed += vSpeedFraction;
	hSpeedFraction = frac(hSpeed);
	vSpeedFraction = frac(vSpeed);
	hSpeed -= hSpeedFraction;
	vSpeed -= vSpeedFraction;
/*
	if (key_left) || (key_right) || (key_jump)
	{
		controller = 0;
	}

	if (abs(gamepad_axis_value(0,gp_axislh)) > 0.2)
	{
		key_left = abs(min(gamepad_axis_value(0,gp_axislh),0));
		key_right = max(gamepad_axis_value(0,gp_axislh),0);
		controller = 1;
	}

	if (gamepad_button_check_pressed(0,gp_face1))
	{
		key_jump = 1;
		controller = 1;	
	}
}
else 
{
	key_right = 0;
	key_left = 0;
	key_jump = 0;
}
*/
//Horizontal collision
if (place_meeting(x+hSpeed,y,oWall))
{
	var _hStep = sign(hSpeed);
	hSpeed = 0;
	hSpeedFraction = 0;
	while (!place_meeting(x+_hStep,y,oWall)) x += _hStep;
	if (state == pState.swing)
	{
		ropeAngle = point_direction(grappleX,grappleY,x,y);
		ropeAngleVelocity = 0;
		//Try negative above ***
	}
}
x += hSpeed;

//Vertical collision
if (place_meeting(x,y+vSpeed,oWall))
{
	var _vStep = sign(vSpeed);
	vSpeed = 0;
	vSpeedFraction = 0;
	while (!place_meeting(x,y+_vStep,oWall)) y += _vStep;
	if (state == pState.swing)
	{
		ropeAngle = point_direction(grappleX,grappleY,x,y);
		ropeAngleVelocity = 0;
		//Try negative above ***
	}
}
y += vSpeed;





/*
// Horizontal movement - running
var move = key_right - key_left;

hsp = (move * walksp) + gunkickx;
gunkickx = 0;

vsp = (vsp + grv) + gunkicky;
gunkicky = 0;

// Vertical movement - jumping
canjump -= 1;
if (canjump > 0) && (key_jump)
{
	vsp = -7;
	canjump = 0;
}


// Horizontal collision
if (place_meeting(x+hSpeed,y,oWall))
{
	while (!place_meeting(x+sign(hSpeed),y,oWall))
	{
		x = x + sign(hSpeed);	
	}
	hSpeed = 0;
}
x = x + hSpeed;

// Vertical collision
if (place_meeting(x,y+vSpeed,oWall))
{
	while (!place_meeting(x,y+sign(vSpeed),oWall))
	{
		y = y + sign(vSpeed);	
	}
	vSpeed = 0;
}
y = y + vSpeed;
/*
// Animation
var aimside = sign(mouse_x - x);
if (aimside != 0) image_xscale = aimside;

// Airborne
if (!place_meeting(x,y+1,oWall))
{
	sprite_index = sPlayerA;
	image_speed = 0;
	if (sign(vSpeed) > 0) image_index = 1; else image_index = 0;
}
// Grounded
else 
{
	canjump = 10;
	if (sprite_index == sPlayerA) 
	{
		audio_sound_pitch(snLanding,choose(0.8,1.0,1.2));
		audio_play_sound(snLanding,4,false);
		repeat (5)
		{
			with (instance_create_layer(x,bbox_bottom, "Bullets",oDust)	)
			{
				vSpeed = 0;	
			}
		}
	}
	image_speed = 1;
	if (hSpeed == 0)
	{
		sprite_index = sPlayer;	
	}
	else
	{
		sprite_index = sPlayerR;
		if (aimside != sign(hSpeed)) sprite_index = sPlayerRb;
	}
}
*/}