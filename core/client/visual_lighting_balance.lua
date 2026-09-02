-- SILVA VISION V0.5 MEGA BLOCK 22
-- Lighting Balance — CLIENT ONLY / STATE ONLY.
-- Calcula equilíbrio entre luz ambiente, distante, faróis e emergência.
-- Não toca streetlight/corona/emissive pendentes.

local L={enabled=true,interval=300,state={ambient=1.0,street=0.0,headlight=1.0,emergency=0.0,balance=1.0,night=0.0,wet=0.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function smooth(o,t,k)return o+(t-o)*k end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function tick()
 if not L.enabled then return end
 local s=call('GetVisualSceneState') or {};local sun=call('GetVisualSunCycleState') or {};local e=call('GetVisualEmergencySceneState') or {};local wb=call('GetVisualWeatherBlendState') or {};local ex=call('GetVisualExposureGuardState') or {}
 local night=clamp(tonumber(sun.night) or 0,0,1);local wet=clamp(tonumber(wb.wet) or 0,0,1);local emergency=clamp(tonumber(e.active) or 0,0,1);local exposure=clamp(tonumber(ex.factor) or 1,0.88,1.04)
 local ambient=clamp(1.0-night*0.10-wet*0.03,0.78,1.02);local street=clamp(night*0.90+wet*0.08+emergency*0.06,0,1);local head=clamp(1.0+night*0.10+wet*0.04+emergency*0.08,1.0,1.22);local balance=clamp(exposure*(0.96+ambient*0.04),0.90,1.04)
 L.state.ambient=smooth(L.state.ambient,ambient,0.14);L.state.street=smooth(L.state.street,street,0.14);L.state.headlight=smooth(L.state.headlight,head,0.14);L.state.emergency=smooth(L.state.emergency,emergency,0.16);L.state.balance=smooth(L.state.balance,balance,0.14);L.state.night=night;L.state.wet=wet
end
CreateThread(function()Wait(9500);while true do tick();Wait(L.interval)end end)
RegisterCommand('svlightbalance',function(_,a)if a[1]=='on'then L.enabled=true elseif a[1]=='off'then L.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=L.state;print(('[SilvaVision] lightbalance ambient=%.2f street=%.2f headlight=%.2f emergency=%.2f balance=%.2f'):format(s.ambient,s.street,s.headlight,s.emergency,s.balance));return else print('[SilvaVision] svlightbalance on | off | reapply | show');return end;print('[SilvaVision] Lighting Balance '..(L.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualLightingBalanceState',function()return L.state end)
