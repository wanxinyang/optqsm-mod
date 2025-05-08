%Andrew Burt - a.burt@ucl.ac.uk

function [inputs] = optInputs(cname,dNNz1,dNNz2)
	inputs = struct([]);
    	lcyl = [4, 8, 12, 16];
	%iterations per param set
	N = 5;
	i = 1;
%	for j = pd1Start : pd1Int : pd1End
	for j = .01: .002 : .02
    %	for k = pd2MinStart : pd2MinInt : pd2MinEnd
   	    for k = .0005 : .0005 : .005
    		%for l = pd2MaxStart : pd2MaxInt : pd2MaxEnd
    		for l = .001 :.005: .02 
    			for m = 1:length(lcyl)
    				for n = 1:N   
    					input.PatchDiam1 = j;
    					input.PatchDiam2Min = k;
    					input.PatchDiam2Max = l;
    					input.lcyl = lcyl(m);
    					input.FilRad = 3.5;
    					input.BallRad1 = j * 1.1
    					input.BallRad2 = l * 1.1;
    					input.nmin1 = 3;
    					input.nmin2 = 1;
    					input.OnlyTree = 1;
    					input.Tria = 0;
    					input.Dist = 1;
    					input.MinCylRad = 0.001;
    					input.ParentCor = 1;
    					input.TaperCor = 0;
    					input.GrowthVolCor = 0;
    					input.GrowthVolFrac = 2.5;
    					tmp1 = strsplit(char(cname),'/');
    					tmp2 = strsplit(char(tmp1(length(tmp1))),'.');
    					%mname = char(strcat(tmp2(1),'-',num2str(input.PatchDiam1),'_',num2str(input.PatchDiam2Min),'_',num2str(input.PatchDiam2Max),'_'),num2str(input.lcyl),'_',num2str(input.FilRad),'_', num2str(n));
                        mname = char(strcat(tmp2(1),'-',num2str(i))); 
    					input.name = mname;
    					input.tree = 1;
    					input.model = i;%N;
    					input.savemat = 1;
    					input.savetxt = 0;
    					input.plot = 0;
    					input.disp = 0;
    					inputs = [inputs, input];
    					i = i+1;
    				end
    			end
    		end
    	end
	end
end
