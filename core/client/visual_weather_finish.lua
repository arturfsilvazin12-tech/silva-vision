-- SILVA VISION V0.5 MEGA BLOCK 11
-- Weather Finish Director — CLIENT ONLY / STATE ONLY
-- Consolida chuva, neblina, céu fechado, tempestade e transições.
-- Não força clima, não escreve VisualSettings e não depende do servidor.

local WeatherFinish={
 enabled=true,interval=500,
 state={rain=0.0,wet=0.0,storm=0.0,fog=0.0,overcast=0.0,smog=0.0,sky=0.0,contrast=0.0,reflection=0.0,finish=0.0}
}

local function smooth(old,target,k)return old+(target-old)*k end

local function update()
 if not WeatherFinish.enabled then return end
 local ok,c=pcall(function()return exports['silva-vision-core']:GetVisualContextBridge()end)
 if not ok or type(c)~='table' then return end
 local w=c.weather or 'CLEAR'
 local rain=(w=='RAIN' or w=='THUNDER') and 1.0 or 0.0
 local wet=c.wet and 1.0 or 0.0
 local storm=c.storm and 1.0 or 0.0
 local fog=(w=='FOGGY') and 1.0 or 0.0
 local overcast=(w=='OVERCAST') and 1.0 or 0.0
 local smog=(w=='SMOG') and 1.0 or 0.0
 local night=tonumber(c.night) or 0.0

 WeatherFinish.state.rain=smooth(WeatherFinish.state.rain,rain,0.18)
 WeatherFinish.state.wet=smooth(WeatherFinish.state.wet,wet,0.16)
 WeatherFinish.state.storm=smooth(WeatherFinish.state.storm,storm,0.20)
 WeatherFinish.state.fog=smooth(WeatherFinish.state.fog,fog,0.12)
 WeatherFinish.state.overcast=smooth(WeatherFinish.state.overcast,overcast,0.12)
 WeatherFinish.state.smog=smooth(WeatherFinish.state.smog,smog,0.12)
 WeatherFinish.state.sky=smooth(WeatherFinish.state.sky,math.max(overcast,fog*0.65,storm*0.75),0.12)
 WeatherFinish.state.contrast=smooth(WeatherFinish.state.contrast,night*0.45+storm*0.10-fog*0.08,0.10)
 WeatherFinish.state.reflection=smooth(WeatherFinish.state.reflection,wet*0.70+storm*0.18,0.14)
 local target=rain*0.20+wet*0.18+storm*0.18+fog*0.16+overcast*0.08+smog*0.06+night*0.14
 WeatherFinish.state.finish=smooth(WeatherFinish.state.finish,math.max(0.0,math.min(1.0,target)),0.12)
end

CreateThread(function()Wait(5000);while true do update();Wait(WeatherFinish.interval)end end)

RegisterCommand('svweatherfinish',function(_,a)
 if a[1]=='on' then WeatherFinish.enabled=true
 elseif a[1]=='off' then WeatherFinish.enabled=false
 elseif a[1]=='reapply' then update()
 elseif a[1]=='show' or not a[1] then
  local s=WeatherFinish.state
  print(('[SilvaVision] weatherfinish rain=%.2f wet=%.2f storm=%.2f fog=%.2f overcast=%.2f sky=%.2f reflection=%.2f finish=%.2f'):format(s.rain,s.wet,s.storm,s.fog,s.overcast,s.sky,s.reflection,s.finish))
  return
 else print('[SilvaVision] svweatherfinish on | off | reapply | show');return end
 print('[SilvaVision] Weather Finish '..(WeatherFinish.enabled and 'ON' or 'OFF'))
end,false)

exports('GetWeatherFinishState',function()return WeatherFinish.state end)
