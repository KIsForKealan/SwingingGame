/// @description Equip gun

global.hasgun = true;
audio_play_sound(snShot, 10, false);
instance_create_layer(oPlayer.x, oPlayer.y, "Gun", oGun);
instance_destroy();