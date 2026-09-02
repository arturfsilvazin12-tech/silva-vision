-- SILVA VISION V0.5 MEGA BLOCK 21
-- Solar Cycle — CLIENT ONLY / STATE ONLY.
-- Curva suave de amanhecer, dia, golden hour, pôr do sol e noite.
-- NÃO escreve VisualSettings e NÃO altera o clima.

local Sun={enabled=true,interval=200,state={hour=12,minute=0,phase='day',sunrise=0.0,day=1.0,golden=0.0,sunset=0.0,night=0.0,solar=1.0,contrast=0.0,street=0.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function bell(x,c,w)return clamp(1.0-math.abs(x-c)/w,0,1)end
local function tick()
 if not Sun.enabled then return end
 local s=Sun.state;local h=GetClockHours();local m=GetClockMinutes();local t=h+m/60.0
 local sunrise=bell(t,6.0,1.5);local golden1=bell(t,7.0,1.8);local golden2=bell(t,18.0,1.8);local sunset=bell(t,18.8,1.5)
 local day=clamp((t-6.2)/1.0,0,1)*clamp((20.0-t)/1.5,0,1)
 local night=clamp(1.0-day-sunrise*0.75-sunset*0.75,0,1)
 local golden=math.max(golden1,golden2)
 local phase=(t>=5.0 and t<7.0) and 'sunrise' or (t>=7.0 and t<17.0) and 'day' or (t>=17.0 and t<20.0) and 'sunset' or 'night'
 s.hour=h;s.minute=m;s.phase=phase
 s.sunrise=smooth(s.sunrise,sunrise,0.12);s.day=smooth(s.day,day,0.12);s.golden=smooth(s.golden,golden,0.12);s.sunset=smooth(s.sunset,sunset,0.12);s.night=smooth(s.night,night,0.12)
 s.solar=clamp(0.72+s.day*0.28+s.sunrise*0.08+s.sunset*0.06-s.night*0.22,0.50,1.08)
 s.contrast=clamp(s.golden*0.10+s.sunset*0.08+s.night*0.04,0,0.18)
 s.street=clamp(s.night*0.92+s.sunset*0.38+s.sunrise*0.18,0,1)
end
CreateThread(function()Wait(5000);while true do tick();Wait(Sun.interval)end end)
RegisterCommand('svsun',function(_,a)if a[1]=='on'then Sun.enabled=true elseif a[1]=='off'then Sun.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=Sun.state;print(('[SilvaVision] sun %s %02d:%02d sunrise=%.2f day=%.2f golden=%.2f sunset=%.2f night=%.2f solar=%.2f'):format(s.phase,s.hour,s.minute,s.sunrise,s.day,s.golden,s.sunset,s.night,s.solar));return else print('[SilvaVision] svsun on | off | reapply | show');return end;print('[SilvaVision] Sun Cycle '..(Sun.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualSunCycleState',function()return Sun.state end)
