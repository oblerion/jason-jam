package main
import rl "vendor:raylib"

GuiButtonText :: struct{
    x : i32,
    y : i32,
    w : i32,
    h : i32,
    text : cstring,
    color : rl.Color,
    active : bool
}

GuiButtonText_init :: proc(x:i32,y:i32,text:cstring,color:rl.Color,active:bool) -> GuiButtonText
{
    return GuiButtonText {x,y,text,color,active}
}
GuiButtonText_draw :: proc(btnt:GuiButtonText) -> bool 
{
    rb:bool = false
    w : i32 = rl.MeasureText(btnt.text,16)
    if(collide2d(btnt.x,btnt.y,w,16,
    rl.GetMouseX(),rl.GetMouseY(),10,10))
    {
        if rl.IsMouseButtonDown(.LEFT) {
            rb = true
        }
        rl.DrawText(btnt.text,btnt.x,btnt.y,16,rl.BLUE)
    }
    else 
    {
        rl.DrawText(btnt.text,btnt.x,btnt.y,16,btnt.color)
    }
    return rb
}


