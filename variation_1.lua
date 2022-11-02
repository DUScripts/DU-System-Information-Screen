local planets = 
{
    {    
        n="DamageReport",
        b="Locura LUA Scripts",
        j="GitHub/LocuraDU",
        g="assets.prod.novaquark.com/130546/f0732f60-c7ad-4e14-b320-cb5a6ee7e112.png",
        t="A multi-screen capable, touch enabled, easy to install ship damage reporting script for Dual Universe. Includes a HUD mode to be mobile while repairing. Highlights damaged/broken elements in 3D space for easier finding.",
        
    },
    {    
        n="Simple Ore Info",
        b="Locura LUA Scripts",
        j="GitHub/LocuraDU",
        g="assets.prod.novaquark.com/130546/64af9efb-4eaf-4913-a7ac-98549b075874.png",
        t="Display for T1-T5 ores, minerals, general storage, and gasses. Will show the icon of selected element.",
      
    }    
}
if not selected then selected = 0 end
local rslib = require('rslib')
local rx,ry = getResolution()
local bg1 = createLayer()
local bg2 = createLayer()
local bg3 = createLayer()
local mg = createLayer()
local la = createLayer()
local ra = createLayer()
local fg = createLayer()
local bgImg = loadImage('assets.prod.novaquark.com/130546/92f70041-2f4f-4bf7-a5b7-73d2031a5406.jpg')
local bgImg2 = loadImage('gui/screen_unit/img/propaganda_poster_fog.png')
local planetImg = loadImage(string.lower(planets[selected+1].g))
local fontTitle = loadFont("Play-Bold",60)
local fontBox = loadFont("Play-Bold",ry/16)
local fontText = loadFont("Play-Bold",ry/32)
addImage(bg1,bgImg,0,0,rx,ry)
addImage(bg2,planetImg,15,150,1000,357)
addImage(bg3,bgImg2,0,0,rx,ry)
setNextTextAlign(fg, AlignH_Center, AlignV_Middle)
addText(fg,fontTitle,string.upper(planets[selected+1].n),rx/2,ry/6)
addLine(mg,rx/8,ry/6+40,rx/8*7,ry/6+40)
local cx,cy = getCursor()
function isCursorIn(x1,y1,x2,y2)
    local cx,cy = getCursor()
    if cx >= x1 and cx <= x2 and cy >= y1 and cy <= y2 then
        logMessage("true")
        return true 
    else 
        return false 
    end
end
if isCursorIn(0,0,rx/2,ry) then
    setDefaultStrokeColor(la,Shape_Line,1,141/255,28/255,1)
    if getCursorReleased() then
        selected = (selected - 1) % #planets
    end    
end
setDefaultStrokeWidth(la, Shape_Line, 5) 
setDefaultStrokeWidth(ra, Shape_Line, 5) 
addLine(la,rx/8,ry/6,rx/8+20,ry/6-20)
addLine(la,rx/8,ry/6,rx/8+20,ry/6+20)
if isCursorIn(rx/2,0,rx,ry) then
    setDefaultStrokeColor(ra,Shape_Line,1,141/255,28/255,1)
    if getCursorReleased() then
        selected = (selected + 1) % #planets
    end   
end
addLine(ra,rx/8*7,ry/6,rx/8*7-20,ry/6-20)
addLine(ra,rx/8*7,ry/6,rx/8*7-20,ry/6+20)
setNextFillColor(mg,59/255,113/255,181/255,0.7)
local boxX,boxY,boxW,boxH = rx/16*7,ry/3,rx/2,ry/7
local fontBox = loadFont("Play-Bold",boxH/2)
addBox(mg,boxX+100,boxY+boxH+200,boxW,boxH)
setNextTextAlign(fg, AlignH_Left, AlignV_Middle)
addText(fg,fontBox,string.upper(planets[selected+1].b),boxX+110,boxY+boxH+230)
addText(fg,fontText,string.upper(planets[selected+1].j),boxX+110,boxY+boxH+270)
local textLines = rslib.getTextWrapped(fontText, planets[selected+1].t, rx/2)
for k,v in ipairs(textLines) do
    addText(fg,fontText,v,20,500+(k*ry/30))
end
    
requestAnimationFrame(3)
