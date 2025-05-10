package main

import ray "vendor:raylib"

@(private = "file")
Player :: struct {
	pos:   ray.Vector2,
	speed: f32,
	size:  ray.Vector2,
}
@(private = "file")
player: Player

player_init :: proc() {
	player = Player{ray.Vector2{400.0, 300.0}, 300.0, ray.Vector2{128, 128}}
}

player_update :: proc() {
	dt := ray.GetFrameTime()

	dir := ray.Vector2{0, 0}

	if ray.IsKeyDown(.D) do dir.x += 1
	if ray.IsKeyDown(.A) do dir.x -= 1
	if ray.IsKeyDown(.S) do dir.y += 1
	if ray.IsKeyDown(.W) do dir.y -= 1

	if ray.Vector2Length(dir) > 0 {
		dir = ray.Vector2Normalize(dir)
		player.pos += dir * (player.speed * dt)
	}
}

player_draw :: proc() {
	ray.DrawRectangleV(player.pos, ray.Vector2{128, 128}, ray.BLUE)
}
