package main

import "core:fmt"
import ray "vendor:raylib"

Game_State :: struct {
	paused:      bool,
	frame_count: i32,
}

state: Game_State

game_init :: proc() {
	state = Game_State{}
}

game_update :: proc(player: ^Entity) {
	state.frame_count += 1
	p1 := player.dir.x
	if ray.IsKeyPressed(.ESCAPE) do state.paused = !state.paused

	dir := ray.Vector2{0, 0}
	if ray.IsKeyDown(.D) do dir.x += 1
	if ray.IsKeyDown(.A) do dir.x -= 1
	if ray.IsKeyDown(.S) do dir.y += 1
	if ray.IsKeyDown(.W) do dir.y -= 1
	player.dir = dir
	if player.dir.x != p1 do fmt.printfln("New : %.f", player.dir[0])
}
