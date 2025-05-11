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
	sa.push(&entities, entity_init(ray.Vector2{50, 20}))

	for !ray.WindowShouldClose() {
		game_update(sa.get_ptr(&entities, 0))

		if !state.paused {
			entity_update(&entities)
		}

		ray.BeginDrawing()
		ray.ClearBackground(ray.RAYWHITE)

		entity_draw(sa.get_ptr(&entities, 0))
		entity_draw(sa.get_ptr(&entities, 1))

		if state.paused {
			ray.DrawText("PAUSE", 350, 280, 50, ray.RED)
		}
		ray.EndDrawing()
	}
	ray.CloseWindow()
}
