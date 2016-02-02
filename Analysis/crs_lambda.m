function lambda = crs_lambda(synchrogram,ratio)

sync = synchrogram(1:ratio:length(synchrogram));

M = length(sync);
sync = sync*2*pi;

sin_sync = sin(sync);
cos_sync = cos(sync);

lambda = sqrt((sum(sin_sync))^2 + (sum(cos_sync))^2)/M;

    



