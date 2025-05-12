package main

import "core:fmt"
import rl "vendor:raylib"

MAX_ENTITIES :: 100

Entity_Pos :: [MAX_ENTITIES]rl.Vector2
Entity_Speed :: [MAX_ENTITIES]f32
Entity_Size :: [MAX_ENTITIES]rl.Vector2
Entity_Dir :: [MAX_ENTITIES]rl.Vector2
Entity_Color :: [MAX_ENTITIES]rl.Color

// ? Est-ce que je dois garder une entité si elle n'est plus affiché ?
// * Entity_Active :: [MAX_ENTITIES]bool 

Entity :: struct {
	pos:   rl.Vector2,
	size:  rl.Vector2,
	color: rl.Color,
}

EntitySystem :: struct {
	pos:   Entity_Pos,
	speed: Entity_Speed,
	size:  Entity_Size,
	dir:   Entity_Dir,
	color: Entity_Color,
	count: int,
}

add_entity :: proc(es: ^EntitySystem, e: Entity) -> i32 {
	es.pos[es.count] = e.pos
	es.size[es.count] = e.size
	es.speed[es.count] = 300.0
	es.color[es.count] = e.color

	es.count += 1

	return i32(es.count - 1)
}

entity_update :: proc(es: ^EntitySystem) {
	dt := rl.GetFrameTime()

	for i in 0 ..< es.count {
		delta := rl.Vector2Normalize(es.dir[i]) * (es.speed[i] * dt)

		delta = manage_colide(es, delta, i)

		es.pos[i].x += delta.x
		es.pos[i].y += delta.y
	}
}

manage_colide :: proc(es: ^EntitySystem, delta: rl.Vector2, index: int) -> rl.Vector2 {
	delta := delta
	if delta.x != 0 {
		for j in 0 ..< es.count {
			if index == j do continue

			if !overlap_y(es, index, j) do continue

			if delta.x > 0 {
				dist := es.pos[j].x - (es.pos[index].x + es.size[index].x)
				if dist >= 0 {
					delta.x = min(delta.x, dist)
				}
			} else {
				dist := (es.pos[j].x + es.size[j].x) - es.pos[index].x
				if dist <= 0 {
					delta.x = max(delta.x, dist)
				}
			}
		}
	}


	if delta.y != 0 {
		for j in 0 ..< es.count {
			if index == j do continue

			if !overlap_x(es, index, j) do continue

			if delta.y > 0 {
				dist := es.pos[j].y - (es.pos[index].y + es.size[index].y)
				if dist >= 0 {
					delta.y = min(delta.y, dist)
				}
			} else {
				dist := (es.pos[j].y + es.size[j].y) - es.pos[index].y
				if dist <= 0 {
					delta.y = max(delta.y, dist)
				}
			}
		}
	}
	return delta
}

overlap_x :: proc(es: ^EntitySystem, i, j: int) -> bool {
	return es.pos[i].x + es.size[i].x > es.pos[j].x && es.pos[i].x < es.pos[j].x + es.size[j].x
}

overlap_y :: proc(es: ^EntitySystem, i, j: int) -> bool {
	return es.pos[i].y + es.size[i].y > es.pos[j].y && es.pos[i].y < es.pos[j].y + es.size[j].y
}

entity_draw :: proc(es: ^EntitySystem) {
	for i in 0 ..< es.count {
		rl.DrawRectangleV(es.pos[i], es.size[i], es.color[i])
	}
}
