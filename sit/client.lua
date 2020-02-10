function OnScriptError(message) --Standard copy&paste code from onset lua script examples for printing out lua errors    AddPlayerChat('<span color="#33DD33" style="bold" size="12">[PinColorpicker]</> - ' .. msgs[i])
  AddPlayerChat('<span color="#882233" style="bold" size="12">[ScriptTester Error] [CLIENT]</>: ' .. message)
end
AddEvent("OnScriptError", OnScriptError)

stream = nil

function OnKeyPress(key)
  if key == "E" then
    player = GetPlayerId()
    sit = GetPlayerPropertyValue(player, "sit")
    if sit == nil or not sit then
      CallEvent("GetClientObjects")

    elseif sit then
      CallRemoteEvent("Unsit")
    end
  end
end
AddEvent("OnKeyPress", OnKeyPress)


AddEvent("GetClientObjects", function()
  objects = GetStreamedObjects(false)
  CallRemoteEvent("ReturnedObjects", objects)
end)


AddRemoteEvent("siting", function(model, chair)
  local actorYAdjustment = 90
  local playerId = player
  local objectId = chair
  local modelid = GetObjectModel(objectId)
  local chairYAdjustment = 0
  local chairZAdjustment = 0
  local ZAdjustment = 0
  local magniAd = 0
  if (modelid == 952) then --Not all chairs are rotated properly by default, so you'll have to test for each chair model that you want to use and adjust y accordingly
    chairYAdjustment = 180
  elseif (modelid == 728 or modelid == 729) then
    chairYAdjustment = 90
  elseif (modelid == 1131 or modelid == 1132 or modelid == 1133 or modelid == 1134 or modelid == 1135 or modelid == 1136 or modelid == 1256) then
    chairYAdjustment = -90
  end
  if modelid == 1228 or modelid == 1223 or modelid == 1256 or modelid == 1127 or modelid == 1126 or modelid == 1095 then
    ZAdjustment = 30
  elseif modelid == 1181 then
    ZAdjustment = 60
  end
  if modelid == 769 then
    magniAd = 60
    ZAdjustment = 20
  elseif modelid == 519 or modelid == 520 or modelid == 728 or modelid == 729 then
    magniAd = 20
  end
  local x, y, z = GetObjectLocation(objectId)
  local rX, rY, rZ = GetObjectRotation(objectId)
  local locationVector = FVector(x, y, z)
  local forwardVector = FVector(0, 1, 0)
  local rotator = FRotator(rX, rY + chairYAdjustment, rZ)
  forwardVector = rotator:RotateVector(forwardVector)
  local magnitude = magniAd + 30 --Magnitude of vector for placing player (bigger = further away, smaller = closer)
  forwardVector = forwardVector * FVector(magnitude, magnitude, magnitude)
  locationVector = locationVector + forwardVector
  locationVector.Z = locationVector.Z + ZAdjustment + 100

  local actor = GetPlayerActor(GetPlayerId())
  --actor:SetActorEnableCollision(false) --Disable player collision so that the player will not be pushed off the chair
  GetObjectStaticMeshComponent(objectId):SetCollisionEnabled(ECollisionEnabled.NoCollision)

  actor:SetActorLocation(locationVector)
  SetIgnoreMoveInput(true)
  actor:SetActorRotation(FRotator(rX, rY + actorYAdjustment + chairYAdjustment, rZ))
  if IsFirstPersonCamera() then
    SetControlRotation(rX, rY + actorYAdjustment + chairYAdjustment, rZ)
    SetControllerOrientedMovement(false)
  end
  Pstream = GetStreamedPlayers()
  condi = false
  CallRemoteEvent("ablecol", Pstream, objectId, condi)
end)

AddRemoteEvent("disacol", function()
  SetIgnoreMoveInput(false)
  local actor = GetPlayerActor(GetPlayerId())
  --actor:SetActorEnableCollision(true)
  if IsFirstPersonCamera() then
    SetControllerOrientedMovement(true)
  end
  --[[if stream then
    CallEvent("collision")
  end]]
end)


--[[AddEvent("OnPlayerStreamIn", function(otherplayer)
  local actor = GetPlayerActor(otherplayer)
  if GetPlayerPropertyValue(otherplayer, "sit") then
    actor:SetActorEnableCollision(false)
    --actor:SetEnableGravity(false)
  end
  stream = true
  CallEvent("collision", otherplayer)
end)


AddEvent("collision", function(otherplayer)
  if otherplayer ~= nil then
    other = otherplayer
  else
    local actor = GetPlayerActor(other)
    actor:SetActorEnableCollision(true)
  end
end)]]


AddRemoteEvent("StockPos", function(x, y, z, chair)
  if x ~= nil then
		xL = x
		yL = y
    zL = z
    cH = chair
  else
    CallRemoteEvent("TP", xL, yL, zL, cH)
    GetObjectStaticMeshComponent(cH):SetCollisionEnabled(ECollisionEnabled.QueryAndPhysics)
    Pstream = GetStreamedPlayers()
    condi = true
    CallRemoteEvent("ablecol", Pstream, cH, condi)
    --CallEvent("colobj", cH)
	end
end)

--[[AddEvent("colobj", function(cH)
  GetObjectStaticMeshComponent(cH):SetCollisionEnabled(ECollisionEnabled.QueryAndPhysics)
  Pstream = GetStreamedPlayers()
  CallRemoteEvent("ablecol", Pstream, cH)
end)]]


AddEvent("OnObjectStreamIn", function(object)
	if IsValidObject(object) and GetObjectPropertyValue(object, "free") == false then
		GetObjectStaticMeshComponent(object):SetCollisionEnabled(ECollisionEnabled.NoCollision)
	end
end)

AddRemoteEvent("colforP", function(objet)
    GetObjectStaticMeshComponent(objet):SetCollisionEnabled(ECollisionEnabled.NoCollision)
    AddPlayerChat("Disabling Colision")
end)

AddRemoteEvent("DcolforP", function(objet)   
    GetObjectStaticMeshComponent(objet):SetCollisionEnabled(ECollisionEnabled.QueryAndPhysics)
    AddPlayerChat("Collision Enable")
end)