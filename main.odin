package main

import "core:fmt"
import ray "vendor:raylib"

main :: proc() {
	ray.InitWindow(800, 600, "Jason-Jam (JJ)")
	ray.SetTargetFPS(60)
    ray.SetExitKey(.KEY_NULL)

	game_init()
	player := entity_init()

	for !ray.WindowShouldClose() {
		game_update(&player)

		if !state.paused {
			entity_update(&player)
		}

		ray.BeginDrawing()
		ray.ClearBackground(ray.RAYWHITE)

		entity_draw(&player)

		if state.paused {
			ray.DrawText("PAUSE", 350, 280, 50, ray.RED)
		}
		ray.EndDrawing()
	}
	ray.CloseWindow()
}
