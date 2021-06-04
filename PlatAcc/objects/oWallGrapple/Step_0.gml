///

with (oPlayer)
{
	if (distance_to_object(other.id) < grappleDistanceMax)
	{
		other.sprite_index = sWallGrappleTHIS;
	}
	else other.sprite_index = sWallGrapple;
}