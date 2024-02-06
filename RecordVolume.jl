#=
    Note: set number of threads and restart vs code
    if considered necesary. I´ve originaly set the number of threads 20 in settings. 
    =#

#Define Function to Record Simulation

using GLMakie
function record_volume(sim, data_function;
    name= "file.mp4"
    duration= 1
    step=0.1)

#Set up visualization data and figure 

data=Observable(data_function(sim))
set_theme!(
    theme_dark(),
    resolution(1090,1090)

)

fig= volume (
    data,
    colorrange=(pi,3pi)),
    algorithm=:mip

#Run simulation and update figure data

t0=round(sim_time(sim))
t=range(t0,t0+duration;step)
record(fig,name,t) do ti
    sim_step!(sim,ti)
    data[]=data_funtion(sim)
    println("simulation", round(Int,(ti-t0)/duration*100),
    "%complete"
    )
    end

return sim, fig 
end 
