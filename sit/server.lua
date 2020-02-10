function OnScriptError(message) --Standard copy&paste code from onset lua script examples for printing out lua errors    AddPlayerChat('<span color="#33DD33" style="bold" size="12">[PinColorpicker]</> - ' .. msgs[i])
	print(message)
end
AddEvent("OnScriptError", OnScriptError)

local _objects = nil
local _Pstream = nil
--weapons = {4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 1408}
chairs = {493, 519, 520, 532, 533, 534, 639, 728, 729, 730, 731, 769, 931, 952, 1086, 1095, 1126, 1127, 1128, 1129, 1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137, 1138, 1139, 1140, 1142, 1181, 1198, 1207, 1208, 1209, 1210, 1211, 1214, 1216, 1218, 1223, 1228, 1246, 1253, 1254, 1256, 1262, 1294, 1794}
--items = {551, 620, 794, 1010, 1011, 1047, 1063, 1075, 1111, 1435, 1439, 1575, 1616, 1631, 1648}

--Vitem = {4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 493, 519, 520, 532, 533, 534, 551, 620, 639, 728, 729, 730, 731, 769, 794, 931, 952, 1010, 1011, 1047, 1063, 1075, 1086, 1095, 1111, 1126, 1127, 1128, 1129, 1130, 1131, 1132, 1133, 1134, 1135, 1136, 1137, 1138, 1139, 1140, 1142, 1181, 1198, 1207, 1208, 1209, 1210, 1211, 1214, 1216, 1218, 1223, 1228, 1246, 1253, 1256, 1262, 1294, 1408, 1435, 1439, 1575, 1616, 1631, 1648}

AddRemoteEvent("ReturnedObjects", function(player, objects)
	_objects = objects
	closest = { id = nil, distance = nil }
	x, y, z = GetPlayerLocation(player)
    if _objects ~= nil then
		for k, v in pairs(_objects) do
			if (GetObjectPropertyValue(v, "free") == nil) or GetObjectPropertyValue(v, "free") then
				obj = Compare(v)
				if obj ~= nil then
            		x2, y2, z2 = GetObjectLocation(obj)
            		distance = GetDistance3D(x, y, z, x2, y2, z2)
					if closest.id == nil or closest.distance == nil then
                		closest.id = obj
                		closest.distance = distance
            		else
						if distance < closest.distance then
                    		closest.id = obj
							closest.distance = distance
						end
					end
				end
			end
		end
        
        if closest.id and closest.distance ~= nil then
			if closest.distance / 100 < 1.5 then
				chair = closest.id
				SetPlayerAnimation(player, "SIT04")
				CallRemoteEvent(player, "siting", model, chair)
				CallRemoteEvent(player, "StockPos", x, y, z, chair)
				SetPlayerPropertyValue(player, "sit", true, true)
				SetObjectPropertyValue(chair, "free", false, true)
			end
		end
	end
end)

function Compare(v)
	for i, p in pairs(chairs) do
		if p == GetObjectModel(v) then
			obj = v
			break
		end
	end
	return obj
end

AddRemoteEvent("Unsit", function(player)
	a = nil
	CallRemoteEvent(player, "StockPos", a)
	CallRemoteEvent(player, "disacol")
	SetPlayerAnimation(player, "STOP")
end)


AddRemoteEvent("TP", function(player, xL, yL, zL, cH)
	SetPlayerLocation(player, xL, yL, zL)
	SetPlayerPropertyValue(player, "sit", false, true)   --Le joueur n'est plus considéré comme assis
	--[[Delay(500, function()								 --j'ai rencontré un bug si il n'y a pas de delay
		SetObjectPropertyValue(cH, "free", true, true)   --La chaise n'est plus considéré comme occupée
	end)]]
	
end)


AddRemoteEvent("ablecol", function(player, Pstream, objectId, condi)
	_Pstream = Pstream
	local objet = objectId
	if condi then
		SetObjectPropertyValue(objet, "free", true, true)
		if _Pstream ~= nil then
			for k,v in pairs(_Pstream) do
				CallRemoteEvent(v, "DcolforP", objet)
			end
		end
	else
		if _Pstream ~= nil then
			for k,v in pairs(_Pstream) do
				CallRemoteEvent(v, "colforP", objet)
			end
		end
	end
end)
