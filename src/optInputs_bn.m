%Andrew Burt - a.burt@ucl.ac.uk

function [inputs] = optInputs(cname)
	inputs = struct([]);
    N = 10;
	for n = 1:N   
		input.PatchDiam1 = .014;
		input.PatchDiam2Min = .001;
		input.PatchDiam2Max = .006;
		input.lcyl = 10;
		input.FilRad = 3.5;
		input.BallRad1 = .014 * 1.1
		input.BallRad2 = .006 * 1.1;
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
        mname = char(strcat(tmp2(1),'-',num2str(n))); 
		input.name = mname;
		input.tree = 1;
		input.model = n;%N;
		input.savemat = 1;
		input.savetxt = 0;
		input.plot = 0;
		input.disp = 0;
		inputs = [inputs, input];
	end
end
