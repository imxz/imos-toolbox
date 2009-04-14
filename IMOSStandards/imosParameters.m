function value = imosParameters( short_name, field )
%IMOSPARAMETERS Returns IMOS compliant standard name or units of measurement
% given the short parameter name.
%
% The list of all IMOS parameters is stored in a file 'imosParameters.txt'
% which is in the same directory as this m-file.
%
% The file imosParameters.txt contains a list of all parameters for which an
% IMOS compliant identifier (the short_name) exists. This function looks up the 
% given short_name and returns the corresponding standard name or units of 
% measurement. If the given short_name is not in the list of IMOS parameters,
% an error is raised.
%
% Inputs:
%   short_name  the IMOS parameter name
%
%   field      - either 'standard_name' or 'uom'.
%
% Outputs:
%   value      - the IMOS standard name or unit of measurement, whichever was 
%                requested.
%
%
% Author: Paul McCarthy <paul.mccarthy@csiro.au>
%

%
% Copyright (c) 2009, eMarine Information Infrastructure (eMII) and Integrated 
% Marine Observing System (IMOS).
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without 
% modification, are permitted provided that the following conditions are met:
% 
%     * Redistributions of source code must retain the above copyright notice, 
%       this list of conditions and the following disclaimer.
%     * Redistributions in binary form must reproduce the above copyright 
%       notice, this list of conditions and the following disclaimer in the 
%       documentation and/or other materials provided with the distribution.
%     * Neither the name of the eMII/IMOS nor the names of its contributors 
%       may be used to endorse or promote products derived from this software 
%       without specific prior written permission.
% 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
% POSSIBILITY OF SUCH DAMAGE.
%

error(nargchk(2, 2, nargin));
if ~ischar(short_name), error('short_name must be a string'); end
if ~ischar(field),      error('field must be a string');      end

value = '';

% get the location of this m-file, which is 
% also the location of imosParamaters.txt
path = fileparts(which(mfilename));

fid = fopen([path filesep 'imosParameters.txt']);
if fid == -1, return; end

params = textscan(fid, '%s%s%s', 'delimiter', ',', 'commentStyle', '%');

names          = params{1};
standard_names = params{2};
uoms           = params{3};

% search the list for a match
for k = 1:length(names)
  
  if strcmp(short_name, names{k})
    
    switch field
      case 'standard_name', value = standard_names{k};
      case 'uom',           value = uoms{k};
    end
    break;
  end
end

if strcmp(value,'')
  error([short_name ' is not a recognised IMOS parameter']); 
end