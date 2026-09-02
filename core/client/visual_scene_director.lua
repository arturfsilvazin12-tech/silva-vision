-- SILVA VISION V0.5 MEGA BLOCK 19
-- Scene Director — CLIENT ONLY / STATE ONLY.
-- Consolida hora, clima, interior, chuva, tempestade, emergência e superfície.
-- NÃO força clima. NÃO escreve VisualSettings. NÃO depende do servidor.

local Scene={
 enabled=true, interval=250,
 state={
  hour=12, phase='day', weather='CLEAR',
  sunrise=0.0,day=1.0,sunset=0.0,night=0.0,
  wet=0.0,storm=0.0,fog=0.0,overcast=0.0,
  interior=0.0,emergency=0.0,
  sunStrength=1.0,ambient=1.0,streetDemand=0.0,
  reflectionDemand=0.0,atmosphereDemand=0.0,
  cinematic=0.0,quality=1.0
 }
}

local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(old,target,k)return old+(target-old)*k end
local function phase(h)
 if h>=5 and h<7 then return 'sunrise' end
 if h>=7 and h<17 then return 'day' end
 if h>=17 and h<20 then return 'sunset' end
 return 'night'
end
local function weatherName()
 local h=GetPrevWeatherTypeHashName()
 local map={
  [GetHashKey('RAIN')]='RAIN',[GetHashKey('THUNDER')]='THUNDER',
  [GetHashKey('CLEARING')]='CLEARING',[GetHashKey('FOGGY')]='FOGGY',
  [GetHashKey('OVERCAST')]='OVERCAST',[GetHashKey('SMOG')]='SMOG',
  [GetHashKey('SNOW')]='SNOW',[GetHashKey('XMAS')]='XMAS'
 }
 return map[h] or 'CLEAR'
end
local function tick()
 if not Scene.enabled then return end
 local s=Scene.state;local h=GetClockHours();local p=phase(h);local w=weatherName()
 local ped=PlayerPedId();local inside=(GetInteriorFromEntity(ped) or 0)~=0
 local inVeh=IsPedInAnyVehicle(ped,false);local emergency=inVeh and GetVehicleClass(GetVehiclePedIsIn(ped,false))==18
 local wet=(w=='RAIN' or w=='THUNDER' or w=='CLEARING')
 local storm=w=='THUNDER';local fog=w=='FOGGY';local overcast=w=='OVERCAST'
 s.hour=h;s.phase=p;s.weather=w
 s.sunrise=smooth(s.sunrise,p=='sunrise' and 1 or 0,0.10)
 s.day=smooth(s.day,p=='day' and 1 or 0,0.10)
 s.sunset=smooth(s.sunset,p=='sunset' and 1 or 0,0.10)
 s.night=smooth(s.night,p=='night' and 1 or 0,0.10)
 s.wet=smooth(s.wet,wet and 1 or 0,0.14)
 s.storm=smooth(s.storm,storm and 1 or 0,0.16)
 s.fog=smooth(s.fog,fog and 1 or 0,0.12)
 s.overcast=smooth(s.overcast,overcast and 1 or 0,0.12)
 s.interior=smooth(s.interior,inside and 1 or 0,0.16)
 s.emergency=smooth(s.emergency,emergency and 1 or 0,0.18)
 local daylight=s.day+s.sunrise*0.72+s.sunset*0.62
 local darkness=clamp(s.night+(1-daylight)*0.18,0,1)
 s.sunStrength=clamp(0.92+daylight*0.18-s.overcast*0.18-s.fog*0.08,0.65,1.12)
 s.ambient=clamp(1.0-darkness*0.12-s.fog*0.08+s.overcast*0.04+s.interior*0.05,0.78,1.06)
 s.streetDemand=clamp(darkness*0.92+s.fog*0.10+s.storm*0.08,0,1)
 s.reflectionDemand=clamp(s.wet*0.72+s.storm*0.18,0,1)
 s.atmosphereDemand=clamp(s.fog*0.90+s.overcast*0.34+s.storm*0.18,0,1)
 s.cinematic=clamp(s.sunset*0.70+s.sunrise*0.55+s.night*0.22+s.storm*0.12,0,1)
 s.quality=clamp(1.0-s.interior*0.08+s.night*0.04+s.storm*0.02,0.88,1.06)
end

CreateThread(function()Wait(6000);while true do tick();Wait(Scene.interval)end end)
RegisterCommand('svscene',function(_,a)
 if a[1]=='on' then Scene.enabled=true elseif a[1]=='off' then Scene.enabled=false elseif a[1]=='reapply' then tick() elseif a[1]=='show' or not a[1] then local s=Scene.state;print(('[SilvaVision] scene %s %02d:00 weather=%s wet=%.2f storm=%.2f fog=%.2f night=%.2f street=%.2f reflection=%.2f atmosphere=%.2f cinematic=%.2f'):format(s.phase,s.hour,s.weather,s.wet,s.storm,s.fog,s.night,s.streetDemand,s.reflectionDemand,s.atmosphereDemand,s.cinematic));return else print('[SilvaVision] svscene on | off | reapply | show');return end
 print('[SilvaVision] Scene Director '..(Scene.enabled and 'ON' or 'OFF'))
end,false)
exports('GetVisualSceneState',function()return Scene.state end)
