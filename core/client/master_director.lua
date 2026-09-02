-- SILVA VISION V0.5 MEGA BLOCK 13
-- Master Director — CLIENT ONLY
-- Orquestra estado visual. Não força clima nem escreve VisualSettings.

local Master={enabled=true,interval=1000,state={phase='day',weather='CLEAR',wet=false,interior=false,emergency=false,profile='Balanced',night=0.0,wetFactor=0.0,storm=0.0,finish=0.0,weatherFinish=0.0,quality=1.0,reflection=0.0}}
local function call(name,...)
 local ok,r=pcall(function()return exports['silva-vision-core'][name](...)end);return ok and r or nil
end
local function update()
 if not Master.enabled then return end
 local p=call('GetVisualPolicy') or {}
 local c=call('GetVisualContextBridge') or {}
 local t=call('GetVisualTransitionState') or {}
 local f=call('GetVisualFinishState') or {}
 local wf=call('GetWeatherFinishState') or {}
 local q=call('GetVisualQualityContext') or {}
 local prof=call('GetActiveProfile')
 Master.state.phase=p.phase or c.phase or t.phase or 'day'
 Master.state.weather=p.weather or c.weather or t.weather or 'CLEAR'
 Master.state.wet=p.wet==true or c.wet==true or (tonumber(t.wet) or 0)>0.5
 Master.state.interior=p.interior==true or c.interior==true
 Master.state.emergency=p.emergency==true or c.emergency==true
 Master.state.night=tonumber(f.night) or tonumber(t.night) or tonumber(c.night) or 0.0
 Master.state.wetFactor=tonumber(f.wet) or tonumber(t.wet) or 0.0
 Master.state.storm=tonumber(f.storm) or tonumber(t.storm) or 0.0
 Master.state.finish=tonumber(f.finish) or 0.0
 Master.state.weatherFinish=tonumber(wf.finish) or 0.0
 Master.state.reflection=tonumber(wf.reflection) or 0.0
 Master.state.quality=tonumber(q.qualityFactor) or 0.0
 if type(prof)=='string' and prof~='' then Master.state.profile=prof
 elseif Master.state.interior then Master.state.profile='Balanced'
 elseif Master.state.night>0.5 or Master.state.emergency then Master.state.profile='Quality'
 else Master.state.profile='Balanced' end
end
CreateThread(function()Wait(5500);while true do update();Wait(Master.interval)end end)
RegisterCommand('svmaster',function(_,a)
 if a[1]=='on' then Master.enabled=true elseif a[1]=='off' then Master.enabled=false elseif a[1]=='reapply' then update() elseif a[1]=='show' or not a[1] then local s=Master.state;print(('[SilvaVision] master=%s phase=%s weather=%s wet=%s interior=%s emergency=%s profile=%s night=%.2f wet=%.2f storm=%.2f finish=%.2f weatherFinish=%.2f reflection=%.2f quality=%.2f'):format(tostring(Master.enabled),s.phase,s.weather,tostring(s.wet),tostring(s.interior),tostring(s.emergency),s.profile,s.night,s.wetFactor,s.storm,s.finish,s.weatherFinish,s.reflection,s.quality));return else print('[SilvaVision] svmaster on | off | reapply | show');return end
 print('[SilvaVision] Master Director '..(Master.enabled and 'ON' or 'OFF'))
end,false)
exports('GetMasterDirectorState',function()return Master.state end)
