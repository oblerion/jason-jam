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

		// ? Peut-être utiliser des variables dx et dy pour ne pas modifier 
		// ? directement la valeur de delta.  
		delta := ray.Vector2Normalize(entity.dir) * (entity.speed * dt)

		if delta.x != 0 {
			for j in 0 ..< sa.len(entities^) {
				if i == j do continue
				other_entity := sa.get_ptr(entities, j)

				if entity.pos.y + entity.size.y <= other_entity.pos.y ||
				   entity.pos.y >= other_entity.pos.y + other_entity.size.y {
					continue
				}

				if delta.x > 0 {
					dist := other_entity.pos.x - (entity.pos.x + entity.size.x)
					if dist >= 0 {
						delta.x = min(delta.x, dist)
					}
				} else {
					dist := (other_entity.pos.x + other_entity.size.x) - entity.pos.x
					if dist <= 0 {
						delta.x = max(delta.x, dist)
					}
				}
			}
			entity.pos.x += delta.x
		}

		dy := delta.y
		if dy != 0 {
			for j in 0 ..< sa.len(entities^) {
				if i == j do continue

				other_entity := sa.get_ptr(entities, j)

				if entity.pos.x + entity.size.x <= other_entity.pos.x ||
				   entity.pos.x >= other_entity.pos.x + other_entity.size.x {
					continue
				}

				if dy > 0 {
					dist := other_entity.pos.y - (entity.pos.y + entity.size.y)
					if dist >= 0 {
						dy = min(dy, dist)
					}
				} else {
					dist := (other_entity.pos.y + other_entity.size.y) - entity.pos.y
					if dist <= 0 {
						dy = max(dy, dist)
					}
				}
			}
			entity.pos.y += dy
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

rects_overlap :: proc(a: ray.Rectangle, b: ray.Rectangle) -> bool {
	return(
		a.x <= b.x + b.width &&
		a.x + a.width >= b.x &&
		a.y <= b.y + b.height &&
		a.y + a.height >= b.y \
	)
}


entity_draw :: proc(entity: ^Entity) {
	ray.DrawRectangleV(entity.pos, entity.size, ray.BLUE)
}
