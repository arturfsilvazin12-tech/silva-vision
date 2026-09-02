-- SILVA VISION V0.5 MEGA BLOCK 20
-- Profile Director — CLIENT ONLY / STATE ONLY.
-- Sugere intensidade contextual sem substituir seleção manual.

local Director={enabled=true,interval=1000,state={recommended='Balanced',reason='default',confidence=0.0}}
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function smooth(o,t,k)return o+(t-o)*k end
local function tick()
 if not Director.enabled then return end
 local s=call('GetVisualSceneState') or {};local q=call('GetVisualBudget') or {};local manual=call('IsProfileManual')==true
 local target='Balanced';local reason='day'
 if manual then target=call('GetActiveProfile') or 'Balanced';reason='manual'
 elseif (q.tier=='HEAVY') then target='Performance';reason='performance'
 elseif s.interior and s.interior>0.5 then target='Balanced';reason='interior'
 elseif s.emergency and s.emergency>0.5 then target='Quality';reason='emergency'
 elseif s.night and s.night>0.55 then target='Quality';reason='night'
 elseif s.cinematic and s.cinematic>0.60 then target='Cinematic';reason='cinematic'
 elseif s.wet and s.wet>0.55 then target='Quality';reason='wet'
 end
 Director.state.recommended=target;Director.state.reason=reason;Director.state.confidence=smooth(Director.state.confidence,target==Director.state.recommended and 1.0 or 0.0,0.15)
end
CreateThread(function()Wait(8500);while true do tick();Wait(Director.interval)end end)
RegisterCommand('svprofilerec',function(_,a)if a[1]=='on'then Director.enabled=true elseif a[1]=='off'then Director.enabled=false elseif a[1]=='show'or not a[1]then print(('[SilvaVision] recommended=%s reason=%s confidence=%.2f'):format(Director.state.recommended,Director.state.reason,Director.state.confidence));return else print('[SilvaVision] svprofilerec on | off | show');return end;print('[SilvaVision] Profile Director '..(Director.enabled and 'ON' or 'OFF'))end,false)
exports('GetVisualProfileDirectorState',function()return Director.state end)
