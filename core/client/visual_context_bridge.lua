-- SILVA VISION V0.5 MEGA BLOCK 05
-- Context Bridge — CLIENT ONLY / STATE ONLY
-- Central Apply continua sendo o único writer de VisualSettings.

local Bridge={enabled=true,interval=600,state={phase='day',weather='CLEAR',wet=false,storm=false,night=0.0,emergency=false,interior=false,intensity=0.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function tick()
 if not Bridge.enabled then return end
 local ped=PlayerPedId(); local h=GetPrevWeatherTypeHashName(); local w='CLEAR'
 local map={[GetHashKey('RAIN')]='RAIN',[GetHashKey('THUNDER')]='THUNDER',[GetHashKey('CLEARING')]='CLEARING',[GetHashKey('FOGGY')]='FOGGY',[GetHashKey('OVERCAST')]='OVERCAST',[GetHashKey('SMOG')]='SMOG',[GetHashKey('SNOW')]='SNOW',[GetHashKey('XMAS')]='XMAS'}
 w=map[h] or w
 local hour=GetClockHours(); local phase=(hour>=5 and hour<7 and 'sunrise') or (hour>=7 and hour<17 and 'day') or (hour>=17 and hour<20 and 'sunset') or 'night'
 local wet=(w=='RAIN' or w=='THUNDER' or w=='CLEARING'); local storm=w=='THUNDER'
 local emergency=IsPedInAnyVehicle(ped,false) and GetVehicleClass(GetVehiclePedIsIn(ped,false))==18
 local interior=GetInteriorFromEntity(ped)~=0
 local target=(phase=='night' and 1.0 or 0.0)+(wet and 0.18 or 0)+(storm and 0.12 or 0)+(emergency and 0.10 or 0)
 Bridge.state.phase=phase; Bridge.state.weather=w; Bridge.state.wet=wet; Bridge.state.storm=storm; Bridge.state.emergency=emergency; Bridge.state.interior=interior
 Bridge.state.night=Bridge.state.night+( (phase=='night' and 1 or 0)-Bridge.state.night)*0.12
 Bridge.state.intensity=Bridge.state.intensity+(clamp(target,0,1)-Bridge.state.intensity)*0.16
end
CreateThread(function()Wait(4000);while true do tick();Wait(Bridge.interval)end end)
RegisterCommand('svcontext',function(_,a)if a[1]=='on'then Bridge.enabled=true elseif a[1]=='off'then Bridge.enabled=false elseif a[1]=='show'or not a[1]then print(('[SilvaVision] context=%s weather=%s wet=%s storm=%s night=%.2f emergency=%s interior=%s'):format(Bridge.state.phase,Bridge.state.weather,tostring(Bridge.state.wet),tostring(Bridge.state.storm),Bridge.state.night,tostring(Bridge.state.emergency),tostring(Bridge.state.interior)));return else print('[SilvaVision] svcontext on | off | show');return end;print('[SilvaVision] Context Bridge '..(Bridge.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualContextBridge',function()return Bridge.state end)
