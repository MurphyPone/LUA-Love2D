require("Class")
require("GUIElements/GUIMain")
require("score")



function giveTheme(element)
    element.backgroundColor = {200,100,100}
    element.borderColor = {100,100,100}
    element.toolTipVisible = true
    element.toolTipText = "Upgrade: "..element.name
 
end

function shop_load()
    firerate =16
    love.graphics.setFont(love.graphics.setNewFont(10))
    love.graphics.setBackgroundColor(0,0,0)

    back = {
        img = love.graphics.newImage("img/back.png"),
        width = 173,
        height = 48,
        x = screenWidth - 200,
        y = 50
    } 
    
    local pieceSize = 100
    local pieceDrawSize = pieceSize - 1
   

    CheckBox:new("One")

    One.position = { (1 - 1) * pieceSize,
                    (1 - 1) * pieceSize}
        firerate = (One.number-1)
        print(firerate)
    giveTheme(One)

    CheckBox:new("Two")
    Two.position = { (2 - 1) * pieceSize,
                    (1 - 1) * pieceSize}
                  --  firerate = (One.number-2)
    giveTheme(Two)

    CheckBox:new("Three")
    Three.position = { (3 - 1) * pieceSize,
                    (1 - 1) * pieceSize}
                    --firerate = (One.number-3)
    giveTheme(Three)
    
     CheckBox:new("Four")
    Four.position = { (1 - 1) * pieceSize,
                    (2 - 1) * pieceSize}
                    --firerate = (One.number-4)
    giveTheme(Four)

     CheckBox:new("Five")
    Five.position = { (2 - 1) * pieceSize,
                    (2 - 1) * pieceSize}
                    --firerate = (One.number-5)
    giveTheme(Five)

    CheckBox:new("Six")
    Six.position = { (3 - 1) * pieceSize,
                    (2 - 1) * pieceSize}
                    --firerate = (One.number-6)
    giveTheme(Six)

    CheckBox:new("Seven")
    Seven.position = { (1 - 1) * pieceSize,
                    (3 - 1) * pieceSize}
                   -- firerate = (One.number-7)
    giveTheme(Seven)

    CheckBox:new("Eight")
    Eight.position = { (2 - 1) * pieceSize,
                    (3 - 1) * pieceSize}
                  --  firerate = (One.number-8)
    giveTheme(Eight)
    
    CheckBox:new("Nine")
    Nine.position = { (3 - 1) * pieceSize,
                    (3- 1) * pieceSize}
                  --  firerate = (One.number-9)
    giveTheme(Nine)

   


end

function shop_update(Time)
    GUIUpdate(Time)
    if insideBox(love.mouse.getX(), love.mouse.getY(), back.x, back.y, back.width, back.height ) then
        gamestate = "title"
    end 
end

function shop_draw()
    
    GUIDraw()

    love.graphics.draw(back.img, back.x, back.y)
   
end

function insideBox( px, py, x, y, wx, wy )
    if px > x and px < x + wx then
        if py > y and py < y + wy then
            return true
        end
    end
    return false
end