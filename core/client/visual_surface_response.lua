-- SILVA VISION V0.5 MEGA BLOCK 26
-- Surface Response Director — CLIENT ONLY / STATE ONLY.
-- Converte chuva/umidade em resposta coerente de piso, água e reflexos.
-- Não escreve VisualSettings e não força clima do servidor.

local S={enabled=true,interval=300,state={wet=0.0,rain=0.0,storm=0.0,puddle=0.0,reflection=0.0,surface=0.0,visibility=1.0,quality=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not S.enabled then return end
 local fx=call('GetVisualWeatherFXState') or {};local r=call('GetVisualReflectionDirectorState') or {};local w=call('GetWaterReflectionState') or {};local b=call('GetVisualBudget') or {}
 local wet=clamp(math.max(tonumber(fx.wet) or 0,tonumber(r.wet) or 0),0,1);local rain=clamp(tonumber(fx.rain) or 0,0,1);local storm=clamp(tonumber(fx.storm) or 0,0,1);local puddle=clamp(math.max(tonumber(r.puddle) or 0,tonumber(w.puddleFactor) or 0),0,1);local refl=clamp(math.max(tonumber(r.reflection) or 0,tonumber(w.reflection) or 0),0,1);local vis=clamp(tonumber(fx.visibility) or tonumber(w.visibility) or 1,0.55,1);local q=clamp(tonumber(b.multiplier) or 1,0.72,1)
 S.state.wet=smooth(S.state.wet,wet,0.16);S.state.rain=smooth(S.state.rain,rain,0.14);S.state.storm=smooth(S.state.storm,storm,0.16);S.state.puddle=smooth(S.state.puddle,puddle,0.14);S.state.reflection=smooth(S.state.reflection,refl,0.14);S.state.visibility=smooth(S.state.visibility,vis,0.12);S.state.surface=smooth(S.state.surface,clamp(wet*0.55+puddle*0.30+rain*0.15,0,1),0.14);S.state.quality=q
end
CreateThread(function()Wait(9500);while true do tick();Wait(S.interval)end end)
RegisterCommand('svsurface',function(_,a)if a[1]=='on'then S.enabled=true elseif a[1]=='off'then S.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=S.state;print(('[SilvaVision] surface wet=%.2f rain=%.2f puddle=%.2f reflection=%.2f storm=%.2f'):format(s.wet,s.rain,s.puddle,s.reflection,s.storm));return else print('[SilvaVision] svsurface on | off | reapply | show');return end;print('[SilvaVision] Surface Response '..(S.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualSurfaceResponseState',function()return S.state end)
