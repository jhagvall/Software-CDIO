function PPV = PPV(tot_vessels, no_flow, intermittent_flow)

PPV = 100 * ((tot_vessels - (no_flow + intermittent_flow)) / tot_vessels);

end
