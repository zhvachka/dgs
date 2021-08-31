GlobalScreenSource = false
GlobalScreenSourceWidthFactor = 1
GlobalScreenSourceHeightFactor = 1
function dgsCreateScreenSource(uPos,vPos,uSize,vSize,relative)
	local ss = createElement("dgs-dxscreensource")
	dgsSetData(ss,"asPlugin","dgs-dxscreensource")
	dgsSetData(ss,"customUV",true)
	if not uPos or not vPos or not uSize or not vSize then
		dgsSetData(ss,"uvPos",{0,0,true})
		dgsSetData(ss,"uvSize",{1,1,true})
		dgsSetData(ss,"customUV",false)
	else
		dgsSetData(ss,"uvPos",{uPos,vPos,relative or false})
		dgsSetData(ss,"uvSize",{uSize,vSize,relative or false})
		dgsSetData(ss,"customUV",true)
	end
	triggerEvent("onDgsPluginCreate",ss,sourceResource)
	if not isElement(GlobalScreenSource) then
		GlobalScreenSource = dxCreateScreenSource(sW*GlobalScreenSourceWidthFactor,sH*GlobalScreenSourceHeightFactor)
	end
	return ss
end

function dgsScreenSourceSetUVPosition(ss,uPos,vPos,relative)
	if not(dgsGetPluginType(ss) == "dgs-dxscreensource") then error(dgsGenAsrt(ss,"dgsScreenSourceSetUVPosition",1,"dgs-dxscreensource")) end
	if not(type(uPos) == "number") then error(dgsGenAsrt(uPos,"dgsScreenSourceSetUVPosition",1,"number")) end
	if not(type(vPos) == "number") then error(dgsGenAsrt(vPos,"dgsScreenSourceSetUVPosition",2,"number")) end
	dgsSetData(ss,"uvPos",{uPos,vPos,relative or false})
	return true
end

function dgsScreenSourceGetUVPosition(ss,relative)
	if not(dgsGetPluginType(ss) == "dgs-dxscreensource") then error(dgsGenAsrt(ss,"dgsScreenSourceSetUVPosition",1,"dgs-dxscreensource")) end
	local relative = relative or false
	local uvPos = dgsElementData[ss].uvPos
	if relative then
		if uvPos[3] == relative then
			return uvPos[1],uvPos[2]
		else
			return uvPos[1]/(sW*GlobalScreenSourceWidthFactor),uvPos[2]/(sH*GlobalScreenSourceHeightFactor)
		end
	else
		if uvPos[3] == relative then
			return uvPos[1],uvPos[2]
		else
			return uvPos[1]*sW*GlobalScreenSourceWidthFactor,uvPos[2]*sH*GlobalScreenSourceHeightFactor
		end
	end
end

function dgsScreenSourceSetUVSize(ss,uSize,vSize,relative)
	if not(dgsGetPluginType(ss) == "dgs-dxblurbox") then error(dgsGenAsrt(ss,"dgsScreenSourceSetUVSize",1,"dgs-dxblurbox")) end
	if not(type(w) == "number") then error(dgsGenAsrt(w,"dgsScreenSourceSetUVSize",2,"number")) end
	if not(type(h) == "number") then error(dgsGenAsrt(h,"dgsScreenSourceSetUVSize",3,"number")) end
	dgsSetData(ss,"uvSize",{uSize,vSize,relative or false})
	return true
end

function dgsScreenSourceGetUVSize(ss,relative)
	if not(dgsGetPluginType(ss) == "dgs-dxscreensource") then error(dgsGenAsrt(ss,"dgsScreenSourceGetUVSize",1,"dgs-dxscreensource")) end
	local relative = relative or false
	local uvSize = dgsElementData[ss].uvSize
	if relative then
		if uvSize[3] == relative then
			return uvSize[1],uvSize[2]
		else
			return uvSize[1]/(sW*GlobalScreenSourceWidthFactor),uvSize[2]/(sH*GlobalScreenSourceHeightFactor)
		end
	else
		if uvSize[3] == relative then
			return uvSize[1],uvSize[2]
		else
			return uvSize[1]*sW*GlobalScreenSourceWidthFactor,uvSize[2]*sH*GlobalScreenSourceHeightFactor
		end
	end
end

dgsCustomTexture["dgs-dxscreensource"] = function(posX,posY,width,height,u,v,usize,vsize,image,rotation,rotationX,rotationY,color,postGUI)
print(postGUI)
	if dgsElementData[image].customUV then
		local uvPos = dgsElementData[image].uvPos
		local uvSize = dgsElementData[image].uvSize
		local uPos,vPos = uvPos[3] and uvPos[1]*GlobalScreenSourceWidthFactor or uvPos[1], uvPos[3] and uvPos[2]*GlobalScreenSourceHeightFactor or uvPos[2]
		local uSize,vSize = uvSize[3] and uvSize[1]*GlobalScreenSourceWidthFactor or uvSize[1], uvSize[3] and uvSize[2]*GlobalScreenSourceHeightFactor or uvSize[2]
		__dxDrawImageSection(posX,posY,width,height,uPos,vPos,uSize,vSize,GlobalScreenSource,rotation,rotationX,rotationY,color,postGUI)
	else
		__dxDrawImageSection(posX,posY,width,height,posX*GlobalScreenSourceWidthFactor,posY*GlobalScreenSourceHeightFactor,width*GlobalScreenSourceWidthFactor,height*GlobalScreenSourceHeightFactor,GlobalScreenSource,rotation,rotationX,rotationY,color,postGUI)
	end
end