package main

import sa "core:container/small_array"
import "core:fmt"
import ray "vendor:raylib"

Entity :: struct {
	pos:   ray.Vector2,
	speed: f32,
	size:  ray.Vector2,
	dir:   ray.Vector2,
}

entity_init :: proc(pos: ray.Vector2) -> Entity {
	return Entity{pos, 300.0, ray.Vector2{64, 64}, ray.Vector2{0, 0}}
}

// ça marche ne pas trop toucher :S
entity_update :: proc(entities: ^sa.Small_Array(100, Entity)) {
	dt := ray.GetFrameTime()

	for i in 0 ..< sa.len(entities^) {
		entity := sa.get_ptr(entities, i)

		if ray.Vector2Length(entity.dir) == 0 do continue

		delta := ray.Vector2Normalize(entity.dir) * (entity.speed * dt)
		resolve_movement(entity, &delta, entities, i)

		entity.pos.x += delta.x
		entity.pos.y += delta.y
	}
}


resolve_movement :: proc(
	entity: ^Entity,
	delta: ^ray.Vector2,
	entities: ^sa.Small_Array(100, Entity),
	i: int,
) {
	if delta.x != 0 {
		for j in 0 ..< sa.len(entities^) {
			if i == j do continue
			other := sa.get_ptr(entities, j)

			if entity.pos.y + entity.size.y <= other.pos.y ||
			   entity.pos.y >= other.pos.y + other.size.y {
				continue
			}

			if delta.x > 0 {
				dist := other.pos.x - (entity.pos.x + entity.size.x)
				if dist >= 0 {
					delta.x = min(delta.x, dist)
				}
			} else {
				dist := (other.pos.x + other.size.x) - entity.pos.x
				if dist <= 0 {
					delta.x = max(delta.x, dist)
				}
			}
		}
	}
	if delta.y != 0 {
		for j in 0 ..< sa.len(entities^) {
			if i == j do continue
			other := sa.get_ptr(entities, j)

			if entity.pos.x + entity.size.x <= other.pos.x ||
			   entity.pos.x >= other.pos.x + other.size.x {
				continue
			}

			if delta.y > 0 {
				dist := other.pos.y - (entity.pos.y + entity.size.y)
				if dist >= 0 {
					delta.y = min(delta.y, dist)
				}
			} else {
				dist := (other.pos.y + other.size.y) - entity.pos.y
				if dist <= 0 {
					delta.y = max(delta.y, dist)
				}
			}
		}
	}
}


get_bounds :: proc(entity: ^Entity) -> ray.Rectangle {
	return ray.Rectangle {
		x = entity.pos.x,
		y = entity.pos.y,
		width = entity.size.x,
		height = entity.size.y,
	}
}


entity_draw :: proc(entity: ^Entity) {
	ray.DrawRectangleV(entity.pos, entity.size, ray.BLUE)
}
