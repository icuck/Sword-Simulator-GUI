local player = game.Players.LocalPlayer
local character = player.Character
local backpack = player.Backpack
local swords = {}
function look(dir)
    for i, v in pairs(dir:GetChildren()) do
        if(v:IsA("Tool"))then
            table.insert(swords,v)
        end
    end
end
look(backpack)
look(character)
    
for i, v in pairs(swords)do
    local sword = v
    sword.Parent = backpack
    sword.Handle.Massless = true
    sword.Handle.CanCollide = true
    sword.Grip = (sword.Grip*CFrame.Angles(1.57,0,0))*CFrame.new(0,0,5.5*(i-1))
    sword.Parent = character
    sword.Handle.Touched:Connect(function(t)
        if(t.Parent)and(t.Parent:FindFirstChild("Humanoid"))and(t.Parent.Name~=player.Name)then
            sword.Handle.dmg.RemoteEvent:FireServer(t.Parent.Humanoid, math.huge)
        end
    end)
end
