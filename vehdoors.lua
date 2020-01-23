local doorstocheck = {}

doorstocheck[1] = {}
doorstocheck[1].door = 410
doorstocheck[1].vehid = 3
doorstocheck[2] = {}
doorstocheck[2].door = 411
doorstocheck[2].vehid = 3
doorstocheck[3] = {}
doorstocheck[3].door = 412
doorstocheck[3].vehid = 3
doorstocheck[4] = {}
doorstocheck[4].door = 413
doorstocheck[4].vehid = 3
doorstocheck[5] = {}
doorstocheck[5].door = 414
doorstocheck[5].vehid = 3
doorstocheck[6] = {}

--doorstocheck[nombred'avant+1] = {}
--doorstocheck[nombre de la ligne d'au dessus].door = nombre de lignes Createdoor avant celle la + 1
--doorstocheck[nombre de la ligne d'au dessus].vehid = modele de vehicule pouvant passer

function check_doors()
    local doorstoopen = {}
    local doorstoclose = {}
    for i, ply in pairs(GetAllPlayers()) do
        for i, v in ipairs(doorstocheck) do
            if v.door ~= nil then
                if GetVehicleModel(GetPlayerVehicle(ply)) == v.vehid then
                    local veh = GetPlayerVehicle(ply)
                    local x,y,z = GetDoorLocation(v.door)
                    local x2,y2,z2 = GetVehicleLocation(veh)
                    local dist = GetDistance3D(x, y, z, x2, y2, z2)

                    if dist < 700 then
                        if GetPlayerCount() > 1 then
                            doorstoopen[v.door] = true
                        else
                            SetDoorOpen(v.door, true)
                        end
                    else
                        if GetPlayerCount() > 1 then
                            doorstoclose[v.door] = true
                        else
                            SetDoorOpen(v.door, false)
                        end
                    end
                else
                    doorstoclose[v.door] = true
                end
            end
        end
    end

    for kc,vc in pairs(doorstoclose) do
        if doorstoopen[kc] then
            SetDoorOpen(kc, true)
        else
            SetDoorOpen(kc, false)
        end
    end

    for ko,vo in pairs(doorstoopen) do 
        SetDoorOpen(ko, true)
    end
end

AddEvent("OnPackageStart",function()
    CreateTimer(check_doors, 200)
end)