package main

import sa "core:container/small_array"
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

entity_update :: proc(entities: ^sa.Small_Array(100, Entity)) {
	dt := ray.GetFrameTime()

	for i in 0 ..< sa.len(entities^) {
		e := sa.get_ptr(entities, i)

		// pas de déplacement
		if ray.Vector2Length(e.dir) == 0 {
			continue
		}

		// vecteur de déplacement total
		delta := ray.Vector2Normalize(e.dir) * (e.speed * dt)

		// 1) Mouvement X seul
		if delta.x != 0 {
			// bounds projetés sur X uniquement
			proposed_x := ray.Rectangle {
				x      = e.pos.x + delta.x,
				y      = e.pos.y,
				width  = e.size.x,
				height = e.size.y,
			}

			can_move_x := true
			for j in 0 ..< sa.len(entities^) {
				if i == j {
					continue
				}
				other := sa.get_ptr(entities, j)
				if rects_overlap(proposed_x, get_bounds(other)) {
					can_move_x = false
					break
				}
			}
			if can_move_x {
				e.pos.x += delta.x
			}
		}

		// 2) Mouvement Y seul
		if delta.y != 0 {
			proposed_y := ray.Rectangle {
				x      = e.pos.x,
				y      = e.pos.y + delta.y,
				width  = e.size.x,
				height = e.size.y,
			}

			can_move_y := true
			for j in 0 ..< sa.len(entities^) {
				if i == j {
					continue
				}
				other := sa.get_ptr(entities, j)
				if rects_overlap(proposed_y, get_bounds(other)) {
					can_move_y = false
					break
				}
			}
			if can_move_y {
				e.pos.y += delta.y
			}
		}
	}
}

// retourne le rectangle courant d'une entité
get_bounds :: proc(e: ^Entity) -> ray.Rectangle {
	return ray.Rectangle{x = e.pos.x, y = e.pos.y, width = e.size.x, height = e.size.y}
}

// collision AABB (touches comprises)
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
