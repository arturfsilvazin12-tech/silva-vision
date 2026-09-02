-- SILVA VISION V0.5 MEGA BLOCK 09
-- Visual Transition Director - CLIENT ONLY / STATE ONLY.
-- Never writes VisualSettings. Never changes server weather.

local Transition={
 enabled=true,interval=250,
 state={phase='day',from='day',to='day',progress=1.0,blend=0.0,weather='CLEAR',wet=0.0,night=0.0,storm=0.0}
}

local function phase(h)
 if h>=5 and h<7 then return 'sunrise' end
 if h>=7 and h<17 then return 'day' end
 if h>=17 and h<20 then return 'sunset' end
 return 'night'
end
local function weather()
 local h=GetPrevWeatherTypeHashName()
 local map={[GetHashKey('RAIN')]='RAIN',[GetHashKey('THUNDER')]='THUNDER',[GetHashKey('CLEARING')]='CLEARING',[GetHashKey('FOGGY')]='FOGGY',[GetHashKey('OVERCAST')]='OVERCAST',[GetHashKey('SMOG')]='SMOG',[GetHashKey('SNOW')]='SNOW',[GetHashKey('XMAS')]='XMAS'}
 return map[h] or 'CLEAR'
end
local function smooth(old,target,k)return old+(target-old)*k end
local function update()
 if not Transition.enabled then return end
 local p=phase(GetClockHours()); local w=weather()
 if p~=Transition.state.phase then Transition.state.from=Transition.state.phase;Transition.state.to=p;Transition.state.progress=0;Transition.state.phase=p end
 Transition.state.progress=math.min(1.0,Transition.state.progress+0.025)
 Transition.state.blend=Transition.state.progress
 Transition.state.weather=w
 local wet=(w=='RAIN' or w=='THUNDER' or w=='CLEARING') and 1.0 or 0.0
 local storm=w=='THUNDER' and 1.0 or 0.0
 local night=(p=='night') and 1.0 or 0.0
 Transition.state.wet=smooth(Transition.state.wet,wet,0.10)
 Transition.state.storm=smooth(Transition.state.storm,storm,0.12)
 Transition.state.night=smooth(Transition.state.night,night,0.08)
end
CreateThread(function()Wait(5000);while true do update();Wait(Transition.interval)end end)
RegisterCommand('svtransition',function(_,a)
 if a[1]=='on' then Transition.enabled=true elseif a[1]=='off' then Transition.enabled=false elseif a[1]=='show' or not a[1] then print(('[SilvaVision] transition=%s phase=%s from=%s to=%s progress=%.2f weather=%s wet=%.2f night=%.2f storm=%.2f'):format(tostring(Transition.enabled),Transition.state.phase,Transition.state.from,Transition.state.to,Transition.state.progress,Transition.state.weather,Transition.state.wet,Transition.state.night,Transition.state.storm));return else print('[SilvaVision] svtransition on | off | show');return end
 print('[SilvaVision] Transition Director '..(Transition.enabled and 'ON' or 'OFF'))
end,false)
exports('GetVisualTransitionState',function()return Transition.state end)
