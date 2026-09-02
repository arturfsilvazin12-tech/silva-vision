-- SILVA VISION V0.5 MEGA BLOCK 23
-- Light Governor — CLIENT ONLY / STATE ONLY.
-- Controla o peso das demandas luminosas sem escrever VisualSettings.

local G={enabled=true,interval=500,state={night=0.0,wet=0.0,emergency=0.0,street=0.0,boost=1.0,quality=1.0}}
local function clamp(v,a,b)return math.max(a,math.min(b,v))end
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function smooth(o,t,k)return o+(t-o)*k end
local function tick()
 if not G.enabled then return end
 local s=call('GetVisualComposerState') or {};local b=call('GetVisualBudget') or {};local q=clamp(tonumber(b.multiplier) or 1,0.72,1)
 local night=clamp(tonumber(s.night) or 0,0,1);local wet=clamp(tonumber(s.wet) or 0,0,1);local em=clamp(tonumber(s.emergency) or 0,0,1);local street=clamp(tonumber(s.street) or 0,0,1)
 local demand=clamp(1.0+night*0.08+wet*0.04+em*0.05+street*0.04,1.0,1.18)
 G.state.night=smooth(G.state.night,night,0.15);G.state.wet=smooth(G.state.wet,wet,0.15);G.state.emergency=smooth(G.state.emergency,em,0.18);G.state.street=smooth(G.state.street,street,0.15);G.state.quality=q;G.state.boost=clamp(demand*q,0.72,1.18)
end
CreateThread(function()Wait(10500);while true do tick();Wait(G.interval)end end)
RegisterCommand('svlightgov',function(_,a)if a[1]=='on'then G.enabled=true elseif a[1]=='off'then G.enabled=false elseif a[1]=='reapply'then tick() elseif a[1]=='show'or not a[1]then local s=G.state;print(('[SilvaVision] lightgov boost=%.2f quality=%.2f night=%.2f wet=%.2f emergency=%.2f'):format(s.boost,s.quality,s.night,s.wet,s.emergency));return else print('[SilvaVision] svlightgov on | off | reapply | show');return end;print('[Silva Vision] Light Governor '..(G.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualLightGovernorState',function()return G.state end)
