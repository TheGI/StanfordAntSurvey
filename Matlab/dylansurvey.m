
UNIQUEID_part = [UNIQUEID2; UNIQUEID3; UNIQUEID6];
SPECIES = [SPECIES2;SPECIES3;SPECIES6];
TREE = [TREE2;TREE3;TREE6];
BASE = [BASE2;BASE3;BASE6];
T_TRAIL = [T_TRAIL2;T_TRAIL3;T_TRAIL6];
B_TRAIL = [B_TRAIL2;B_TRAIL3;B_TRAIL6];

load('treemap.mat');
[Xref,Yref,Nref] = deg2utm(LAT(7518),LON(7518));
[X,Y,N] = deg2utm(LAT,LON);
[SC,iA,iC] = unique(SPECIESCOD);
cmap = colormap(hsv(length(iA)));

%%
hold on;
for i = 1:length(iC)
    plot(X(i),Y(i),'.','Color',cmap(iC(i),:));
end
hold off;

%%
[XYZ, H, DEC, DIP, F] = wrldmagm(22, LAT(2225), LON(2225), decyear(2016,7,25),'2015')
% declination 13

%%
bound1 = [37.437829, -122.166629; 37.437302, -122.166837; 37.436258, -122.167164; 37.436271, -122.165859; 37.437502, -122.165762; 37.437829, -122.166629];
bound2 = [37.437461, -122.167096;37.437070, -122.168899;37.436641, -122.169051;37.436080, -122.167533;37.437461, -122.167096];
bound3 = [37.436641, -122.169051;37.436232, -122.169598; 37.434798, -122.167967; 37.436080, -122.167533;37.436641, -122.169051];
bound4 = [37.436258, -122.167164;37.433934, -122.166422;37.434175, -122.166293; 37.435322, -122.165920; 37.436271, -122.165859;37.436258, -122.167164];

%[in, on] = inpolygon(LAT,LON,bound1(:,1),bound1(:,2));
%[names,index1] = sort(UNIQUEID(in))
[in, on] = inpolygon(LAT,LON,bound2(:,1),bound2(:,2));
[names,index2] = sort(UNIQUEID(in))
%[in, on] = inpolygon(LAT,LON,bound3(:,1),bound3(:,2));
%[names,index3] = sort(UNIQUEID(in))
%[in, on] = inpolygon(LAT,LON,bound4(:,1),bound4(:,2));
%[names,index4] = sort(UNIQUEID(in))
%%
[in, on] = inpolygon(LAT,LON,bound1(:,1),bound1(:,2));
names = BOTNAME(in);
names = names(index1)
[in, on] = inpolygon(LAT,LON,bound2(:,1),bound2(:,2));
names = BOTNAME(in);
names = names(index2)
[in, on] = inpolygon(LAT,LON,bound3(:,1),bound3(:,2));
names = BOTNAME(in);
names = names(index3)
[in, on] = inpolygon(LAT,LON,bound4(:,1),bound4(:,2));
names = BOTNAME(in);
names = names(index4)

%%
hold on;
for i = 1:length(iC)
    if in(i) == 1
        plot(X(i),Y(i),'.','Color',cmap(iC(i),:));
        text(X(i),Y(i),UNIQUEID(i),'Color',cmap(iC(i),:));
    end
end
hold off;

%%
[uniqueSpecies,ua,uc] = unique(SPECIES);

% Species Color Code
% Camponotus semitesteceus: [153 76 0]
% Formica moki: [255 0 0]
% Liometopum occidental: [0 153 0]
% Crematogaster coarctata: [0 0 153]
% Prenolepis imparis: [0 255 255]
% Linepithema humile: [255 0 255]
% Tapinoma sessile: [255 255 0]
% Camponotus laevigatus: [255 128 0]
% No Ants: [224 224 224]
figure('units','normalized','position',[.1 .1 .5 1]);
hold on;
for i = 1:length(UNIQUEID_part)
    ind = strcmp(UNIQUEID,UNIQUEID_part{i});
    
    markerSize = nansum([TREE(i),BASE(i)])+5;
    if (nansum([T_TRAIL(i) + B_TRAIL(i)]) > 0)
        markerType = 's';
    else
        markerType = 'o';
    end
    switch SPECIES{i}
        case 'CS'
            plot(X(ind),Y(ind),'o','Color', [0.6,0.3,0],...
                'MarkerSize',markerSize,'Marker',markerType);
            text(X(ind)+3,Y(ind),num2str(markerSize - 5));
        case 'FM'
            plot(X(ind),Y(ind),'o','Color', [1,0,0],...
                'MarkerSize',markerSize,'Marker',markerType);
            text(X(ind)+3,Y(ind),num2str(markerSize - 5));
        case 'CC'
            plot(X(ind),Y(ind),'o','Color', [0,0,0.6],...
                'MarkerSize',markerSize,'Marker',markerType);
            text(X(ind)+3,Y(ind),num2str(markerSize - 5));
        case 'LO'
            plot(X(ind),Y(ind),'o','Color', [0,0.6,0],...
                'MarkerSize',markerSize,'Marker',markerType);
            text(X(ind)+3,Y(ind),num2str(markerSize - 5));
        case 'PI'
            plot(X(ind),Y(ind),'o','Color', [0,1,1],...
                'MarkerSize',markerSize,'Marker',markerType);
            text(X(ind)+3,Y(ind),num2str(markerSize - 5));
        case 'TS'
            plot(X(ind),Y(ind),'o','Color', [0.8,0.8,0],...
                'MarkerSize',markerSize,'Marker',markerType);
            text(X(ind)+3,Y(ind),num2str(markerSize - 5));
        case 'LH'
            plot(X(ind),Y(ind),'o','Color', [1,0,1],...
                'MarkerSize',markerSize,'Marker',markerType);
            text(X(ind)+3,Y(ind),num2str(markerSize - 5));
        case 'CL'
            plot(X(ind),Y(ind),'o','Color', [1,0.502,0],...
                'MarkerSize',markerSize,'Marker',markerType);
            text(X(ind)+3,Y(ind),num2str(markerSize - 5));
        case 'DEAD'
        case 'NA'
            plot(X(ind),Y(ind),'o','Color', [0.875 0.875 0.875], ...
                'MarkerSize',4);
    end
end
hold off;

title('Region 2,3,6 Tree Survey Day');
xlabel('UTM (meters)');
ylabel('UTM (meters)');
