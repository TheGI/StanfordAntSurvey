load('treemap.mat');

[Xref,Yref,Nref] = deg2utm(LAT(7518),LON(7518));

%%
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
hold on;
for i = 1:length(iC)
    if(X(i) >= Xref-30 && X(i) <= Xref+30 && ...
            Y(i) >= Yref-30 && Y(i) <= Yref+30)
    plot(X(i),Y(i),'o','Color',cmap(iC(i),:));
    end
end

coordinates = [];
coordinates(47,:) = [Xref, Yref];

for i = 1:length(idfrom)
    [xtemp, ytemp] = pol2cart((angle1(i)+13)*pi/180,distance1(i)/100);
    coordinates(idto(i),:) = coordinates(idfrom(i),:) + [xtemp, ytemp];
end

for i = 1:46
    x = coordinates(i,1);
y = coordinates(i,2);
c = -Xref+Yref;

d = (x + (y-c))/2;
coordinates(i,1) = 2*d-x;
coordinates(i,2) = 2*d-y+2*c;
end

plot(coordinates(1:17,1),coordinates(1:17,2),'r*');
plot(coordinates(19:46,1),coordinates(19:46,2),'r*');
hold off;
axis([Xref-25 Xref+5 Yref-5 Yref+25])
xlabel('UTM (meters)');
ylabel('UTM (meters)');
title('Camponotus Map');

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
uniqueSpecies = {'CL','CS','FM','LO','TS','DEAD','NA'}; % NA
speciescmap = colormap(hsv(length(uniqueSpecies)));
hold on;
for i = 1:length(UNIQUEID_part)
    k = strfind(UNIQUEID,UNIQUEID_part{i});
    ind = find(~cellfun(@isempty,k));
    
    n = strfind(uniqueSpecies, SPECIES{i});
    colorind = find(~cellfun(@isempty,n));
    switch colorind
        case 1
            plot(X(ind),Y(ind),'co');
        case 2
            plot(X(ind),Y(ind),'go');
        case 3
            plot(X(ind),Y(ind),'ro');
        case 4
            plot(X(ind),Y(ind),'yo');
        case 5
            plot(X(ind),Y(ind),'bo');
        case 6
        case 7
            plot(X(ind),Y(ind),'ko');
    end
    
end
hold off;
