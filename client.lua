local lastcoords = nil
local lasttype = nil
local elevatorNum = nil
local found = false
local visible = false

for i, v in pairs(Config.Elevators) do

    RMenu.Add(v.type, v.type, RageUI.CreateMenu("", "", 0, 100, v.image, v.image))

    RMenu:Get(v.type, v.type):SetSubtitle(v.label)

end

function showAsc(flag, type)
    RageUI.Visible(RMenu:Get(type, type), flag)
    visible = flag
    OpenUi()
end

local moreTime = false
local time = 0

function OpenUi()
    Citizen.CreateThread(function()
        while visible do
            Wait(0)
            if elevatorNum ~= nil then
                if RageUI.Visible(RMenu:Get(lasttype, lasttype)) then
                    RageUI.DrawContent({ header = true, glare = true, instructionalButton = true }, function()
                        for k2, v2 in pairs(Config.Elevators[elevatorNum].floors) do
                            RageUI.Button(v2.label, "",{ RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    DoScreenFadeOut(500)
                                    Citizen.Wait(500)
                                    SetEntityCoords(PlayerPedId(), v2.coords.x, v2.coords.y, v2.coords.z)
                                    SetEntityHeading(PlayerPedId(), v2.rotation)
                                    DoScreenFadeIn(500)
                                    Citizen.Wait(500)
                                end
                            end)
                        end
                    end, function()
                    end)
                else
                    Citizen.Wait(1000)
                    visible = false
                end
            end
                
        end
    
    end)
end


Citizen.CreateThread(function()
    
    local distance = 50

    while true do 

        local ped = PlayerPedId()
        
        moreTime = false
		time = 0
        
        if distance > 50 then
            moreTime = true
            time = 3000
            if distance > 200 then
                if distance > 500 then
                    time = 15000
                else
                    time = 7500
                end
            end
        end

        Wait(1000)

        local dd = 1000000

        for k, v in pairs(Config.Elevators) do
            
            if found == false then

                for k2, v2 in pairs(v.floors) do
                    
                    local playerCoords = GetEntityCoords(ped)
                    local dis = #(playerCoords-v2.coords)

                    if dis < dd then dd = dis end

                    if dis < 1.5 then
                        found = true
                        lasttype = v.type
                        lastcoords = v2.coords
                        elevatorNum = k
                        showAsc(true, v.type)
                        break
                    end
                end
            else
    
                local playerCoords = GetEntityCoords(ped)
                dd = #(playerCoords-lastcoords)
    
                if dd > 1.5 then
                    found = false
                    elevatorNum = nil
                    showAsc(false, lasttype)
                else
                    break
                end
            end
        end

        if moreTime then
            Wait(time)
        end

        distance = dd
    end
end)