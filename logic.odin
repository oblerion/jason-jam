package main

import rl "vendor:raylib"

// Collide rect and mouse
cord_over_rect :: proc(pos: rl.Vector2, rect: rl.Rectangle) -> bool {
	return(
		rect.x < pos.x &&
		rect.x + rect.width > pos.x &&
		rect.y < pos.y &&
		pos.y < rect.y + rect.height \
	)
}

// Collide rect and rect
rects_overlap :: proc(a, b: rl.Rectangle) -> bool {
	return(
		a.x <= b.x + b.width &&
		a.x + a.width >= b.x &&
		a.y <= b.y + b.height &&
		a.y + a.height >= b.y \
	)
}

// distance btw 2 pts
dist :: proc(x, y, x2, y2: i32) -> i32 {
	return abs(y2 - y) + abs(x2 - x)
}
