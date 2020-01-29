local doorstocheck = {}

table.insert(doorstocheck, { door = 29, vehid = 3 })
table.insert(doorstocheck, { door = 30, vehid = 3 })

table.insert(doorstocheck, { door = 555, vehid = 3 })
table.insert(doorstocheck, { door = 556, vehid = 3 })
table.insert(doorstocheck, { door = 557, vehid = 3 })
table.insert(doorstocheck, { door = 558, vehid = 3 })
table.insert(doorstocheck, { door = 559, vehid = 3 })

table.insert(doorstocheck, { door = 555, vehid = 3 })
table.insert(doorstocheck, { door = 556, vehid = 3 })
table.insert(doorstocheck, { door = 557, vehid = 3 })
table.insert(doorstocheck, { door = 558, vehid = 3 })
table.insert(doorstocheck, { door = 559, vehid = 3 })

table.insert(doorstocheck, { door = 580, vehid = 3 })
table.insert(doorstocheck, { door = 581, vehid = 3 })
table.insert(doorstocheck, { door = 582, vehid = 3 })
table.insert(doorstocheck, { door = 583, vehid = 3 })
table.insert(doorstocheck, { door = 584, vehid = 3 })

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