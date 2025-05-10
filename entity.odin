package main

import ray "vendor:raylib"

Entity :: struct {
	pos:   ray.Vector2,
	speed: f32,
	size:  ray.Vector2,
	dir:   ray.Vector2,
}

entity_init :: proc() -> Entity {
	return Entity{ray.Vector2{400.0, 300.0}, 300.0, ray.Vector2{128, 128}, ray.Vector2{0, 0}}
}

entity_update :: proc(entity: ^Entity) {
	dt := ray.GetFrameTime()

	if ray.Vector2Length(entity.dir) > 0 {
		entity.dir = ray.Vector2Normalize(entity.dir)
		entity.pos += entity.dir * (entity.speed * dt)
	}
}

entity_draw :: proc(entity: ^Entity) {
	ray.DrawRectangleV(entity.pos, ray.Vector2{128, 128}, ray.BLUE)
}
