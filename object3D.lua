  function OnPackageStart()
	local pakname = "pmediumfrontsign"
	local res = LoadPak(pakname, "/pmediumfrontsign/", "../../../OnsetModding/Plugins/pmediumfrontsign/Content")
	res = ReplaceObjectModelMesh(56, "/pmediumfrontsign/pmediumfrontsign")
	local pakname = "psign"
	local res = LoadPak(pakname, "/psign/", "../../../OnsetModding/Plugins/psign/Content")
	res = ReplaceObjectModelMesh(55, "/psign/policesign")
	local pakname = "psmallfrontsign"
	local res = LoadPak(pakname, "/psmallfrontsign/", "../../../OnsetModding/Plugins/psmallfrontsign/Content")
	res = ReplaceObjectModelMesh(54, "/psmallfrontsign/psmallfrontsign")
	local pakname = "pstaarrow"
	local res = LoadPak(pakname, "/pstaarrow/", "../../../OnsetModding/Plugins/pstaarrow/Content")
	res = ReplaceObjectModelMesh(53, "/pstaarrow/pstaarrow")
  	local pakname = "pvehonly"
	local res = LoadPak(pakname, "/pvehonly/", "../../../OnsetModding/Plugins/pvehonly/Content")
	res = ReplaceObjectModelMesh(52, "/pvehonly/pvehonly")
end
AddEvent("OnPackageStart", OnPackageStart)