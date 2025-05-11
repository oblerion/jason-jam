package main

// collide rect
collide2d :: proc(x:i32,y:i32,w:i32,h:i32,x2:i32,y2: i32,w2: i32,h2:i32) -> bool 
{
    if x< x2+w2 && 
        y< y2+h2 && 
        x2< x+w && 
        y2< y+h 
    {
        return true
    }
    return false
}

// distance btw 2 pts
dist :: proc(x:i32,y:i32,x2:i32,y2:i32) -> i32
{
    return abs(y2-y) + abs(x2-x)
}