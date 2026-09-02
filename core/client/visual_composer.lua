-- SILVA VISION V0.5 MEGA BLOCK 20
-- Visual Composer — CLIENT ONLY / STATE ONLY.
-- Converte Scene + Weather + Water + Budget em um único pacote de acabamento.
-- Não escreve VisualSettings e não controla o clima do servidor.

local Composer={enabled=true,interval=300,state={quality=1.0,night=0.0,wet=0.0,storm=0.0,fog=0.0,street=0.0,reflection=0.0,atmosphere=0.0,cinematic=0.0,lightWeight=1.0,rainWeight=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function smooth(o,t,k)return o+(t-o)*k end
local function update()
 if not Composer.enabled then return end
 local s=call('GetVisualSceneState') or {};local w=call('GetWeatherFinishState') or {};local b=call('GetVisualBudget') or {};local water=call('GetWaterReflectionState') or {}
 local q=clamp(tonumber(b.multiplier) or 1,0.72,1);local night=clamp(tonumber(s.night) or 0,0,1);local wet=clamp(tonumber(s.wet) or tonumber(w.wet) or 0,0,1);local storm=clamp(tonumber(s.storm) or tonumber(w.storm) or 0,0,1)
 local fog=clamp(tonumber(s.fog) or tonumber(w.fog) or 0,0,1);local street=clamp(tonumber(s.streetDemand) or 0,0,1);local reflection=clamp(math.max(tonumber(s.reflectionDemand) or 0,tonumber(water.reflection) or 0,tonumber(w.reflection) or 0),0,1);local atmosphere=clamp(tonumber(s.atmosphereDemand) or 0,0,1);local cinematic=clamp(tonumber(s.cinematic) or 0,0,1)
 Composer.state.night=smooth(Composer.state.night,night,0.14);Composer.state.wet=smooth(Composer.state.wet,wet,0.14);Composer.state.storm=smooth(Composer.state.storm,storm,0.16);Composer.state.fog=smooth(Composer.state.fog,fog,0.12);Composer.state.street=smooth(Composer.state.street,street,0.14);Composer.state.reflection=smooth(Composer.state.reflection,reflection,0.14);Composer.state.atmosphere=smooth(Composer.state.atmosphere,atmosphere,0.12);Composer.state.cinematic=smooth(Composer.state.cinematic,cinematic,0.10)
 Composer.state.quality=q;Composer.state.lightWeight=clamp(q*(1.0+Composer.state.street*0.10+Composer.state.night*0.08),0.72,1.0);Composer.state.rainWeight=clamp(q*(1.0+Composer.state.wet*0.08+Composer.state.storm*0.06),0.72,1.0)
end
CreateThread(function()Wait(8000);while true do update();Wait(Composer.interval)end end)
RegisterCommand('svcomposer',function(_,a)if a[1]=='on'then Composer.enabled=true elseif a[1]=='off'then Composer.enabled=false elseif a[1]=='reapply'then update() elseif a[1]=='show'or not a[1]then local s=Composer.state;print(('[SilvaVision] composer quality=%.2f night=%.2f wet=%.2f storm=%.2f fog=%.2f street=%.2f reflection=%.2f atmosphere=%.2f cinematic=%.2f light=%.2f rain=%.2f'):format(s.quality,s.night,s.wet,s.storm,s.fog,s.street,s.reflection,s.atmosphere,s.cinematic,s.lightWeight,s.rainWeight));return else print('[SilvaVision] svcomposer on | off | reapply | show');return end;print('[SilvaVision] Composer '..(Composer.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualComposerState',function()return Composer.state end)
