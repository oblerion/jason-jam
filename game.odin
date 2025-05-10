package main

import ray "vendor:raylib"

// Tu peux stocker ici l'état global du jeu
Game_State :: struct {
	paused:      bool,
	frame_count: i32,
}

state: Game_State

game_init :: proc() {
	state = Game_State{}
}

game_update :: proc() {
	state.frame_count += 1

	if ray.IsKeyPressed(.ESCAPE) {
		state.paused = !state.paused
	}

	// Autres événements ou logique de jeu à venir
}

is_paused :: proc() -> bool {
	return state.paused
}
