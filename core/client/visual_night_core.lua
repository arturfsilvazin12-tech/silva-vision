-- SILVA VISION V0.5 MEGA BLOCK 24
-- Night Core — CLIENT ONLY / STATE ONLY.
-- Coordena demanda noturna urbana, faróis, luzes distantes e contraste.
-- NÃO força clima, NÃO cria entidades e NÃO escreve VisualSettings.

local Night={enabled=true,interval=250,state={night=0.0,urban=0.0,headlight=0.0,distant=0.0,contrast=0.0,emergencyContrast=0.0,wetNight=0.0,quality=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not Night.enabled then return end
 local s=Night.state
 local scene=call('GetVisualSceneState') or {};local sun=call('GetVisualSunCycleState') or {};local wb=call('GetVisualWeatherBlendState') or {};local ex=call('GetVisualExposureGuardState') or {};local gov=call('GetVisualLightGovernorState') or {}
 local night=clamp(tonumber(sun.night) or tonumber(scene.night) or 0,0,1)
 local wet=clamp(tonumber(wb.wet) or tonumber(scene.wet) or 0,0,1)
 local emergency=clamp(tonumber(scene.emergency) or 0,0,1)
 local street=clamp(math.max(tonumber(sun.street) or 0,tonumber(scene.streetDemand) or 0,tonumber(gov.street) or 0),0,1)
 local targetUrban=clamp(night*0.82+street*0.28,0,1)
 local targetHead=clamp(night*0.78+wet*0.12+emergency*0.10,0,1)
 local targetDistant=clamp(night*0.88+street*0.18+wet*0.08,0,1)
 s.night=smooth(s.night,night,0.16);s.urban=smooth(s.urban,targetUrban,0.14);s.headlight=smooth(s.headlight,targetHead,0.14);s.distant=smooth(s.distant,targetDistant,0.14)
 s.contrast=clamp(s.night*0.08+s.urban*0.05-(wet*0.02),0,0.12)
 s.emergencyContrast=smooth(s.emergencyContrast,clamp(emergency*0.85+night*0.10,0,1),0.18)
 s.wetNight=smooth(s.wetNight,night*wet,0.14)
 s.quality=clamp((tonumber(ex.factor) or 1.0)*(0.96+s.urban*0.04),0.88,1.04)
end
CreateThread(function()Wait(7000);while true do tick();Wait(Night.interval)end end)
RegisterCommand('svnightcore',function(_,a)
 if a[1]=='on'then Night.enabled=true elseif a[1]=='off'then Night.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=Night.state;print(('[SilvaVision] nightcore night=%.2f urban=%.2f headlight=%.2f distant=%.2f contrast=%.2f wetNight=%.2f'):format(s.night,s.urban,s.headlight,s.distant,s.contrast,s.wetNight));return else print('[SilvaVision] svnightcore on | off | reapply | show');return end
 print('[SilvaVision] Night Core '..(Night.enabled and 'ON' or 'OFF'))
end,false)
exports('GetVisualNightCoreState',function()return Night.state end)
