% function [prm] = model_setprm(prm)
%
% Conducts custom initialisation of the system parameters for L40 model.
%
% @param prm - system parameters
% @return prm - system parameters

% File:           model_setprm.m
%
% Created:        31/08/2007
%
% Last modified:  26/08/2010
%
% Author:         Pavel Sakov
%                 CSIRO Marine and Atmospheric Research
%                 NERSC
%
% Purpose:        Conducts custom initialisation of the system parameters for
%                 L40 model.
%
% Description:    Does nothing.
%
% Revisions:      14.08.2008 PS:
%                   - added "prm.periodic = 1"
%                 26.08.2010 PS:
%                   - added a warning that only rk4 integrator can be used with
%                     compiled code
%                   - added a check on the existence of the compiled model code

%% Copyright (C) 2008 Pavel Sakov
%% 
%% This file is part of EnKF-Matlab. EnKF-Matlab is a free software. See 
%% LICENSE for details.

function [prm] = model_setprm(prm)
    
    prm.periodic = 1;
    
    if prm.customprm.use_compiled & exist('L40_step_c') ~= 3
        fprintf('  L40: warning: could not find compiled binary of L40_step_c.c; (slower) matlab code will be used\n');
        prm.customprm.use_compiled = 0;
    end
    
    if prm.customprm.use_compiled & strcmp(prm.customprm.integrator, 'dp5')
        fprintf('  L40: warning: setting customprm.use_compiled = 1 implies customprm.integrator = rk4\n');
        customprm.integrator = 'rk4';
    end
    
    return
