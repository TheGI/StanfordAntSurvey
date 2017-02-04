% Stanford Tree-Ant Survey Data Preprocessing and Analysis script
% survey region bounding logitude and latitude
bound1 = [37.437829, -122.166629; 37.437302, -122.166837; 37.436258, -122.167164; 37.436271, -122.165859; 37.437502, -122.165762; 37.437829, -122.166629];
bound2 = [37.437461, -122.167096;37.437070, -122.168899;37.436641, -122.169051;37.436080, -122.167533;37.437461, -122.167096];
bound3 = [37.436641, -122.169051;37.436232, -122.169598; 37.434798, -122.167967; 37.436080, -122.167533;37.436641, -122.169051];
bound4 = [37.436258, -122.167164;37.433934, -122.166422;37.434175, -122.166293; 37.435322, -122.165920; 37.436271, -122.165859;37.436258, -122.167164];
bound5 = [37.436220, -122.167169;37.434587, -122.167739;37.434296, -122.167032;37.433824, -122.166380; 37.434084, -122.166531; 37.434826, -122.166788; 37.436220, -122.167169];
bound6 = [37.437377, -122.169098;37.437076, -122.168903;37.437476, -122.167077;37.437979, -122.166919;37.438309, -122.167846;37.437377, -122.169098];
bound7 = [37.436018, -122.169947;37.434545, -122.169600;37.434613, -122.168020;37.434785, -122.167979;37.436228, -122.169588;37.436018, -122.169947];
bound8 = [37.436018, -122.169947;37.434545, -122.169600;37.434652, -122.171005;37.435975, -122.170327;37.436018, -122.169947];
bound9 = [37.437377, -122.169098;37.438309, -122.167846;37.438771, -122.169098;37.438095, -122.169871;37.437377, -122.169098];
bound10 = [37.439318, -122.166465;37.439872, -122.168116;37.438771, -122.168824;37.438052, -122.166879;37.439318, -122.166465];
bound11 = [37.439318, -122.166465;37.439872, -122.168116;37.441359, -122.167254;37.440384, -122.166103;37.439318, -122.166465];
bound12 = [37.441016, -122.165581;37.437953, -122.166631;37.437592, -122.165753;37.439341, -122.165638;37.440242, -122.165072;37.441016, -122.165581];

bounds = {bound1, bound2, bound3, bound4, bound5, bound6,...
          bound7, bound8, bound9, bound10, bound11, bound12};

C_CS = [0.6,0.3,0];
C_CV = [0.6,0.3,0];
C_CL = [0.6,0.3,0];
C_FM = [1,0,0];
C_CC = [0,0,0.6];
C_LO = [0,0.6,0];
C_PI = [0,1,1];
C_TS = [0.8,0.8,0];
C_LH = [1,0,1];
C_PC = [1,0.502,0];
C_NA = [0.875 0.875 0.875];
C_DEAD = [1, 1, 1];

colors = [C_CC;C_CL;C_CS;C_CV;C_DEAD;C_FM;C_LH;C_LO;C_NA;C_PC;C_PI;C_TS];
      
% set the working directory to the tree ant survey folder
cd('/Users/GailLee/Google Drive/Research/Stanford_Ant_Map/dataAnalysis/');

% load the original tree data acquired from Map office
% orginal data format
% formatSpec = '%q%q%d%q%C%C%C%{MM/dd/yy}D%q%q%C%q%d%C%C%d%d%d%f%f';
formatSpec = '%q%q%d%q%q%q%q%{MM/dd/yy}D%q%q%q%q%d%q%q%d%d%d%f%f';
% store original tree data to table
T = readtable('data/stanford_tree_LONLAT.csv',...
    'Delimiter',',', ...
    'Format',formatSpec);
% convert longitude and latitude to UTM xy coordinates
[T.UTMX, T.UTMY, ~] = deg2utm(T.LON, T.LAT);

% assign survey region numbers to each tree
% 0 is no survey region
T.region = zeros(size(T,1),1);
for i = 1:length(bounds)
    [in, ~] = inpolygon(T.LAT,T.LON,bounds{i}(:,1),bounds{i}(:,2));
    T.region(in) = i;
end
%T.region = categorical(T.region);

% read ant data
antdatalist = dir(['./data/TAS*.csv']);
%formatSpec = '%q%C%d%d%d%d%d%C%C%C';
formatSpec = '%q%q%d%d%d%d%q%q%q%d%d%d';
for i = 1:length(antdatalist)
    if i == 1
        T_ant = readtable(['data/' antdatalist(i).name],...
        'Delimiter',',', ...
        'Format',formatSpec);
    else
        T_temp = readtable(['data/' antdatalist(i).name],...
        'Delimiter',',', ...
        'Format',formatSpec);
        T_ant = vertcat(T_ant,T_temp);
    end
end

% combine ant data with original tree data
for i = 1:size(T_ant,1)
    index = strcmp(T_ant.UNIQUEID(i),T.TREES_ID);
    T_ant.BOTNAME(i) = T.BOTNAME(index);
    T_ant.VIGORRATIN(i) = T.VIGORRATIN(index);
    T_ant.MAP_CODE(i) = T.MAP_CODE(index);
    T_ant.TREEHT(i) = T.TREEHT(index);
    T_ant.SEQ(i) = T.SEQ(index);
    T_ant.LAT(i) = T.LAT(index);
    T_ant.LON(i) = T.LON(index);
    T_ant.UTMX(i) = T.UTMX(index);
    T_ant.UTMY(i) = T.UTMY(index);
%    T_ant.REGION(i) = T.region(index);
    T_ant.NUMSTEMS(i) = T.NUMSTEMS(index);
    T_ant.DBH(i) = T.DBH(index);
    T_ant.AGGRDBH(i) = T.AGGRDBH(index);
    T_ant.SPECIESCOD(i) = T.SPECIESCOD(index);
    T_ant.COMNAME(i) = T.COMNAME(index);
end

% update dead trees
T_ant.VIGORRATIN(strcmp(T_ant.SPECIES, 'DEAD')) = {'Dead'};

% save table to a file
writetable(T_ant,'data/antdata_matlab.csv');

%% Analysis
% for each tree species, number of trees where CS were found
index1 = find(categorical(T_ant.DAY_NIGHT) == 'night' & ...
    categorical(T_ant.REGION) ~= '0' & ...
    categorical(T_ant.SPECIES) == 'CS');
[idx1,label1] = grp2idx(sort(T_ant.BOTNAME(index1)));
M1 = hist(idx1,unique(idx1));

% for each tree species, number of all trees
index2 = find(categorical(T_ant.DAY_NIGHT) == 'night' & ...
    categorical(T_ant.REGION) ~= '0');
[C, IA, IC] = unique(categorical(T_ant.UNIQUEID(index2)));
temp = T_ant.BOTNAME(index2);
[idx2,label2] = grp2idx(sort(temp(IA)));
M2 = hist(idx2,unique(idx2));

% two categorical factors
% CS found / not found
% Q.agrifolia / other trees

% construct observed table first



%%
% find out the distribution of camponotus activity across
% all observed tree species
index1 = find(categorical(T_ant.DAY_NIGHT) == 'night' & ...
    categorical(T_ant.REGION) ~= '0' & ...
    categorical(T_ant.SPECIES) == 'CS');
[idx1,label1] = grp2idx(sort(T_ant.BOTNAME(index1)));
M1 = hist(idx1,unique(idx1));

index2 = find(categorical(T_ant.DAY_NIGHT) == 'night' & ...
    categorical(T_ant.REGION) ~= '0');
[C, IA, IC] = unique(categorical(T_ant.UNIQUEID(index2)));
temp = T_ant.BOTNAME(index2);
[idx2,label2] = grp2idx(sort(temp(IA)));
M2 = hist(idx2,unique(idx2));

chitable_obs = [];
chitable_exp = [];
for i = 1:length(label2)
    % observed counts
        if sum(strcmp(label1, label2(i))) == 0
%             chitable_obs((i-1)*2+1,1) =  0;
%             chitable_obs((i-1)*2+2,1) = M2(i);
        else
%             chitable_obs((i-1)*2+1,1) =  M1(strcmp(label1,label2(i)));
%             chitable_obs((i-1)*2+2,1) = M2(i) - chitable_obs((i-1)*2+1,1);
            chitable_obs(end+1,1) = M1(strcmp(label1,label2(i)));
            chitable_obs(end+1,1) = M2(i) - M1(strcmp(label1,label2(i)));
        chitable_exp(end+1,1) = sum(M1) * M2(i) / sum(M2);
        chitable_exp(end+1,1) = M2(i) - (sum(M1) * M2(i) / sum(M2));
        end  
%         chitable_exp((i-1)*2+1,1) = sum(M1) * M2(i) / sum(M2);
%         chitable_exp((i-1)*2+2,1) = M2(i) - (sum(M1) * M2(i) / sum(M2));
end
chi2stat = sum((chitable_obs-chitable_exp).^2 ./ chitable_exp);
p = 1 - chi2cdf(chi2stat,1)
[h,p,stats] = chi2gof([1:48],'freq',chitable_obs,'expected',chitable_exp,'ctrs',[1:48]);

%% plot map
index = find(categorical(T_ant.DAY_NIGHT) ~= 'day' & ...
    categorical(T_ant.REGION) ~= '0' & ...
    categorical(T_ant.SEASON) == 'summer' & ...
    categorical(T_ant.SPECIES) ~= 'DEAD');

uniquespecies = unique(T_ant.SPECIES);

hold on;
for i = index'
    colorindex = find(categorical(uniquespecies) == T_ant.SPECIES(i));
    markerSize = T_ant.TREE(i) + T_ant.BASE(i) + 5;
    if (T_ant.T_TRAIL(i) + T_ant.B_TRAIL(i) > 0)
        markerType = 's';
    else
        markerType = 'o';
    end
    plot(T_ant.UTMX(i),T_ant.UTMY(i),'o',...
        'Color', colors(colorindex,:),...
        'MarkerSize',markerSize,...
        'Marker',markerType);
end
hold off;
%     legend(categories(T_ant.SPECIES(index)))
% gscatter(T_ant.UTMX(index),T_ant.UTMY(index),T_ant.SPECIES(index),...
%     cmap,'o',(T_ant.TREE(index)+T_ant.BASE(index))*2+1)
