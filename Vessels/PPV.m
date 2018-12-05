function PPV = PPV(tot_vessels, no_flow, intermittent_flow)
%Calculate the proportion of perfused vessels. tot_vessels is the total
%number of vessels, no_flow is vessels with no flow and intermittent_flow
%is vessels with intermittents flow in the video. 
PPV = 100 * ((tot_vessels - (no_flow + intermittent_flow)) / tot_vessels);

end
