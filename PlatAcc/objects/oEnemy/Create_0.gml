/// @description 

if (hasweapon) 
{
	mygun = instance_create_layer(x,y,"Gun",oEGun);
	with (mygun)
	{
		owner = other.id;	
	}
}
else mygun = noone;