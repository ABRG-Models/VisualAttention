% octave file to investigate the cartesian-invariant gaussian
% projective field This is then implemented in the model as the
% RetinoGauss python connection script.

% The neural field size - never changes in this model, so this is
% not a parameter.
W_nfs = 150;

%
% The following will be parameters to the RetinoGauss script
%
% The sigma multiplier from which sigma(r) is computed (as
% sigma_m/M_f +- offsets)
sigma_m = 50 % m_sigma in the paper

% An offset applied to sigma(r). Needs to be a new parameter.
sigma_0 = 0

% E2 participates in the magnification factor. In practice this is
% not changed, but it's still included as a param.
E2 = 2.5

fovshift = 1 % Past the foveal region, really, this is where the
             % increase in the sigma starts, for r<fovshift,
             % sigma is sigma_0

% A normalisation power
normpower = 0 %1.45

r = [1:W_nfs]; % 1-W_nfs range here. 0-(W_nfs-1) range of srcloc[1] in python
               % RetinoGauss script is bumped up by 1.

M_f = W_nfs ./ ( E2 .* log (( r/(2.*E2) )+1) ); % for r=0, M_f is
                                                % infinity. Python
                                                % can't cope.

M_f_start = W_nfs ./ ( E2 .* log (( fovshift/(2.*E2) )+1) );

M_f(1:fovshift) = M_f_start;

figure(1)
plot (r, M_f);
xlabel('r');
ylabel('MagFactor(r)');
title ('MagFactor');
omsetgrid([2,2]);

% sigma(r) in the paper
_sigma = (sigma_m./M_f) - (sigma_m./M_f_start) + sigma_0;

_SIGMA=repmat(_sigma, W_nfs, 1);

figure(2)
plot (r, _sigma);
xlabel('r');
ylabel('\_sigma(r)');
title('\_sigma(r)');
omsetgrid([3,2]);

dist = [1:W_nfs];
DIST = repmat (dist, W_nfs, 1)';

% Power based normalisation
normterm = 1./power(_sigma,normpower);

figure(4)
plot (r, normterm);
title ('normterm(r)');
omsetgrid([4,2]);

GAUSS = normterm.*exp(-0.5.*power(DIST./_SIGMA,2));
figure(3)
surf(GAUSS)
xlabel('r')
ylabel('d')
ylim([1,15])
%view([268 0.1])
view([241,56])
omsetgrid([3,1]);

figure(5);
plot (r, sum(GAUSS, 1));
title('Sum of GAUSS surface (figure 3) along d axis')
%ylim([0 1.25])
omsetgrid([4,1]);

hold_on = 0
if hold_on
    for i = [1 5]
        figure(i); hold on;
    end
end
