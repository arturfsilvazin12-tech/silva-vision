-- SILVA VISION V0.5 MEGA BLOCK 29
-- Rain + Wet Surface Director — CLIENT ONLY / STATE ONLY.
-- Consolida chuva, asfalto molhado, reflexos e interação de emergência.
-- Não força clima, não cria entidades e não escreve VisualSettings.

local R={enabled=true,interval=250,state={rain=0.0,storm=0.0,wet=0.0,puddle=0.0,reflection=0.0,visibility=1.0,fog=0.0,emergency=0.0,signal=0.0,night=0.0,surface=0.0,quality=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function n(v,d)return type(v)=='number' and v or (tonumber(v) or d)end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not R.enabled then return end
 local s=call('GetVisualSurfaceResponseState') or {};local a=call('GetVisualAtmosphereDirectorState') or {};local e=call('GetVisualEmergencyContrastState') or {};local c=call('GetVisualSceneState') or {};local b=call('GetVisualBudget') or {}
 local rain=clamp(math.max(n(s.rain,0),n(a.rain,0)),0,1)
 local storm=clamp(math.max(n(s.storm,0),n(a.storm,0)),0,1)
 local wet=clamp(math.max(n(s.wet,0),rain*0.58+storm*0.18),0,1)
 local puddle=clamp(n(s.puddle,0),0,1)
 local refl=clamp(math.max(n(s.reflection,0),wet*0.55+puddle*0.35),0,1)
 local fog=clamp(n(a.fog,0),0,1)
 local vis=clamp(n(a.visibility,n(s.visibility,1)),0.55,1)
 local em=clamp(math.max(n(e.active,0),n(c.emergency,0)),0,1)
 local signal=clamp(n(e.signal,0),0,1)
 local night=clamp(n(c.night,0),0,1)
 local surface=clamp(wet*0.50+puddle*0.30+refl*0.20,0,1)
 local q=clamp(n(b.multiplier,1),0.72,1)
 R.state.rain=smooth(R.state.rain,rain,0.16);R.state.storm=smooth(R.state.storm,storm,0.16);R.state.wet=smooth(R.state.wet,wet,0.16);R.state.puddle=smooth(R.state.puddle,puddle,0.13);R.state.reflection=smooth(R.state.reflection,refl,0.15);R.state.fog=smooth(R.state.fog,fog,0.12);R.state.visibility=smooth(R.state.visibility,vis,0.12);R.state.emergency=smooth(R.state.emergency,em,0.18);R.state.signal=smooth(R.state.signal,signal,0.18);R.state.night=smooth(R.state.night,night,0.14);R.state.surface=smooth(R.state.surface,surface,0.15);R.state.quality=q
end
CreateThread(function()Wait(12500);while true do tick();Wait(R.interval)end end)
RegisterCommand('svrain',function(_,a)if a[1]=='on'then R.enabled=true elseif a[1]=='off'then R.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=R.state;print(('[SilvaVision] rain=%.2f storm=%.2f wet=%.2f puddle=%.2f refl=%.2f fog=%.2f vis=%.2f night=%.2f emergency=%.2f signal=%.2f surface=%.2f quality=%.2f'):format(s.rain,s.storm,s.wet,s.puddle,s.reflection,s.fog,s.visibility,s.night,s.emergency,s.signal,s.surface,s.quality));return else print('[SilvaVision] svrain on | off | reapply | show');return end;print('[SilvaVision] Rain Surface Director '..(R.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualRainSurfaceDirectorState',function()return R.state end)
