-- SILVA VISION V0.5 MEGA BLOCK
-- Contextual Quality Director — CLIENT ONLY

local State={enabled=true,phase='day',wet=false,emergency=false,interior=false,qualityFactor=0.0}

local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function update()
 local h=GetClockHours()
 State.phase=(h>=5 and h<7 and 'sunrise') or (h>=7 and h<17 and 'day') or (h>=17 and h<20 and 'sunset') or 'night'
 local w=GetPrevWeatherTypeHashName()
 State.wet=(w==GetHashKey('RAIN') or w==GetHashKey('THUNDER') or w==GetHashKey('CLEARING'))
 local ped=PlayerPedId()
 State.interior=(GetInteriorFromEntity(ped) or 0)~=0
 State.emergency=false
 if IsPedInAnyVehicle(ped,false) then State.emergency=GetVehicleClass(GetVehiclePedIsInAnyVehicle(ped,false))==18 end
 local target=(State.phase=='night' and 1.0 or 0.0)
 if State.wet then target=clamp(target+0.15,0,1) end
 if State.emergency then target=1.0 end
 State.qualityFactor=State.qualityFactor+(target-State.qualityFactor)*0.10
end

CreateThread(function()while true do if State.enabled then update()end Wait(750)end end)
RegisterCommand('svquality',function(_,a)
 if a[1]=='on' then State.enabled=true elseif a[1]=='off' then State.enabled=false elseif a[1]=='show' then print(('[SilvaVision] quality phase=%s wet=%s emergency=%s interior=%s factor=%.2f'):format(State.phase,tostring(State.wet),tostring(State.emergency),tostring(State.interior),State.qualityFactor)) else print('[SilvaVision] svquality on | off | show') end
end,false)
exports('GetVisualQualityContext',function()return State end)
