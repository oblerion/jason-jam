package main

import sa "core:container/small_array"
import "core:fmt"
import rl "vendor:raylib"

main :: proc() {
	rl.InitWindow(800, 600, "Jason-Jam (JJ)")
	rl.SetTargetFPS(60)
	rl.SetExitKey(.KEY_NULL)

	game_init()
	es: EntitySystem
	player_id := add_entity(
		&es,
		Entity{pos = rl.Vector2{300, 400}, size = rl.Vector2{32, 32}, color = rl.BLUE},
	)
	add_entity(&es, Entity{pos = rl.Vector2{400, 400}, size = rl.Vector2{64, 64}, color = rl.RED})

	buttons: Buttons
	// TODO : Créer une fonction qui gère l'ajout de bouton
	sa.push_back(
		&buttons,
		button_init(rl.Vector2{10, 10}, rl.Vector2{200, 200}, "Click me !!", rl.BLUE, rl.RED, foo),
	)

	for !rl.WindowShouldClose() {
		game_update(&es, player_id)

		if !state.paused {
			entity_update(&es)
			buttons_update(&buttons)
		}

		rl.BeginDrawing()
		rl.ClearBackground(rl.RAYWHITE)

		entity_draw(&es)
		buttons_draw(&buttons)
		if state.paused {
			rl.DrawText("PAUSE", 350, 280, 50, rl.RED)
		}
		rl.EndDrawing()
	}
	rl.CloseWindow()
}
