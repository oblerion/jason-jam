package main

import sa "core:container/small_array"
import "core:fmt"
import ray "vendor:raylib"

main :: proc() {
	ray.InitWindow(800, 600, "Jason-Jam (JJ)")
	ray.SetTargetFPS(60)
	ray.SetExitKey(.KEY_NULL)

	game_init()
	entities: sa.Small_Array(100, Entity)
	sa.push(&entities, entity_init(ray.Vector2{400, 300}))
	player_id := sa.len(entities) - 1

	buttons: Buttons
	// TODO : Créer une fonction qui gère l'ajout de bouton
	sa.push_back(
		&buttons,
		button_init(
			ray.Vector2{10, 10},
			ray.Vector2{200, 200},
			"Click me !!",
			ray.BLUE,
			ray.RED,
			foo,
		),
	)

	for !ray.WindowShouldClose() {
		game_update(sa.get_ptr(&entities, player_id))
		buttons_update(&buttons)

		if !state.paused {
			entity_update(&entities)
		}

		ray.BeginDrawing()
		ray.ClearBackground(ray.RAYWHITE)

		entity_draw(sa.get_ptr(&entities, player_id))
		buttons_draw(&buttons)
		if state.paused {
			ray.DrawText("PAUSE", 350, 280, 50, ray.RED)
		}
		ray.EndDrawing()
	}
	ray.CloseWindow()
}
