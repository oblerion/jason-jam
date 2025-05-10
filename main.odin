package main

import "core:fmt"
import ray "vendor:raylib"

main :: proc() {
	ray.InitWindow(800, 600, "Jason-Jam (JJ)")
	ray.SetTargetFPS(60)
    ray.SetExitKey(.KEY_NULL)

	game_init()
	player_init()

	for !ray.WindowShouldClose() {
		game_update()

		if !is_paused() {
			player_update()
		}

		ray.BeginDrawing()
		ray.ClearBackground(ray.RAYWHITE)

		player_draw()

		if is_paused() {
			ray.DrawText("PAUSE", 350, 280, 50, ray.RED)
		}

		ray.EndDrawing()
	}

	ray.CloseWindow()
}
