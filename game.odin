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

game_update :: proc(es: ^EntitySystem, player_id: i32) {
	state.frame_count += 1

	if ray.IsKeyPressed(.ESCAPE) do state.paused = !state.paused

	// Player movements
	dir := ray.Vector2{0, 0}
	if ray.IsKeyDown(.D) do dir.x += 1
	if ray.IsKeyDown(.A) do dir.x -= 1
	if ray.IsKeyDown(.S) do dir.y += 1
	if ray.IsKeyDown(.W) do dir.y -= 1
	es.dir[player_id] = dir
}
