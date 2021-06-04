//hsp = 0;
//vsp = 0;
//grv = 0.3;
//walksp = 4;
controller = 0;
hascontrol = true;
//canjump = 0;

gunkickx = 0;
gunkicky = 0;

audio_sound_pitch(snShot, 0.8);

//Acc
hSpeed = 0;
vSpeed = 0;
walkSpeed = 5;
walkAcceleration = 1.1;
hFrictionGround = 0.7;
hFrictionAir = 0.2;
grappleDistanceMax=200;
ropeLength=0;
jumpSpeed = 10;
gravity_ = 0.5;
hSpeedFraction = 0.0;
vSpeedFraction = 0.0;

state = pState.normal;

enum pState
{
	normal,
	swing
}