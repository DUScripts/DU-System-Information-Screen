local planets = 
{
    {    
        n="Alioth",
        b="Our new home",
        t="Discovered by The UEF. Alioth is a rocky planet with continental plates. Common ores are plentiful. Sitting in the Circumstellar Habitable Zone(CHZ) the atmosphere is stable and has an active hydrosphere maintaining multicellular lifeforms.",
        data={
            {"Class","Mesoplanet"},
            {"Territories","259472"},
            {"Size","199718.78 km2"},
            {"Satellites","4"},
            {"Atmosphere","Present"},
            {"Gravity","1.01 g"},
            {"Biosphere","Forest"},        
        }
    },
    {    
        n="Madis",
        b="Sun dried rock",
        t="Madis is a barren wasteland of a rock; it sits closest to the sun and temperatures reach extreme highs during the day. The arkship geological survey reports long rocky valleys intermittently separated by small ravines.",
        data={
            {"Class","hyperthermoplanet"},
            {"Territories","30722"},
            {"Size","24661.38 km2"},
            {"Satellites","3"}, 
            {"Atmosphere","Present"},
            {"Gravity","0.36 g"},
            {"Biosphere","Barren"},        
        }
    },
    {    
        n="Thades",
        b="Scarred Planet",
        t="Thades is a scorched desert planet. Perhaps it was once teaming with life but now all that remains is ash and dust. The arkship geological survey reports a rocky mountainous planet bisected by a massive unnatural ravine; something happened to this planet.",
        data={
            {"Class","Thermoplanet"},
            {"Territories","38882"},
            {"Size","30171.86 km2"},
            {"Satellites","2"}, 
            {"Atmosphere","Present"},
            {"Gravity","0.50 g"},
            {"Biosphere","Desert"},        
        }
    },
    {    
        n="Teoma",
        b="---",
        t="[REDACTED] The arkship geological survey [REDACTED]. This planet should not be here.",
        data={
            {"Class","Mesoplanet"},
            {"Territories","60752"},
            {"Size","48305.13 km2"},
            {"Satellites","2"}, 
            {"Atmosphere","Present"},
            {"Gravity","0.49 g"},
            {"Biosphere","Forest"},        
        }
    },
    {    
        n="Jago",
        b="A sea world",
        t="Jago is a water planet. The large majority of the planet's surface is covered by large oceans dotted by small areas of landmass across the planet. The arkship geological survey reports deep seas across the majority of the planet with sub 15 percent coverage of solid ground.",
        data={
            {"Class","Mesoplanet"},
            {"Territories","60752"},
            {"Size","47668.37 km2"},
            {"Satellites","0"},
            {"Atmosphere","Present"},
            {"Gravity","0.50 g"},
            {"Biosphere","Water"},        
        }
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
local bgImg = loadImage('gui/screen_unit/img/BG_propaganda_poster.png')
local bgImg2 = loadImage('gui/screen_unit/img/propaganda_poster_fog.png')
local planetImg = loadImage('gui/screen_unit/img/planets/'..string.lower(planets[selected+1].n)..".png")
local fontTitle = loadFont("Play-Bold",60)
local fontBox = loadFont("Play-Bold",ry/16)
local fontText = loadFont("Play-Bold",ry/32)
addImage(bg1,bgImg,0,0,rx,ry)
addImage(bg2,planetImg,ry/6,ry/3,ry/2.3,ry/2.3)
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
addBox(mg,boxX,boxY,boxW,boxH)
setNextTextAlign(fg, AlignH_Left, AlignV_Middle)
addText(fg,fontBox,string.upper(planets[selected+1].b),boxX+boxH/3,boxY+boxH/2)
local textLines = rslib.getTextWrapped(fontText, planets[selected+1].t, rx/2)
for k,v in ipairs(textLines) do
    addText(fg,fontText,v,boxX,ry/2+(k*ry/30))
end
    
for k,v in ipairs(planets[selected+1].data) do
    addText(fg, fontText, v[1]..":", (ry/15) + (math.floor((k-1)/5) * 300), (ry-(ry/15*3)) + (ry/30*((k-1)%5)))
    setNextTextAlign(fg, AlignH_Right, AlignV_Baseline)
    setNextFillColor(fg,1,141/255,28/255,1)
    addText(fg, fontText, v[2], (ry/15) + (math.ceil((k-0.99)/5) * 250), (ry-(ry/15*3)) + (ry/30*((k-1)%5)))
end
requestAnimationFrame(3)
