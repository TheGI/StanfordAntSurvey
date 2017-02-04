%%
load('treemap.mat');
[X,Y,N] = deg2utm(LAT,LON);
[SC,iA,iC] = unique(SPECIESCOD);
cmap = colormap(hsv(length(iA)));

%% nest 1 references
[Xref1,Yref1,Nref1] = deg2utm(LAT(7518),LON(7518)); 
%% nest 2 references
[Xref2,Yref2,Nref2] = deg2utm(LAT(6071),LON(6071));

%% nest 3 references
[Xref3,Yref3,Nref3] = deg2utm(LAT(6997),LON(6997));
[Xref4,Yref4,Nref4] = deg2utm(LAT(4557),LON(4557));

%%
hold on;
Xref = Xref2;
Yref = Yref2;
for i = 1:length(iC)
    if(X(i) >= Xref-30 && X(i) <= Xref+30 && ...
            Y(i) >= Yref-30 && Y(i) <= Yref+30)
    plot(X(i),Y(i),'o','Color',cmap(iC(i),:));
    end
end
coordinates = [];
coordinates(1,:) = [Xref, Yref];
for i = 1:length(idfrom)
    [x, y] = pol2cart(angle1(i)*pi/180,distance1(i));
    coordinates(idto(i),:) = coordinates(idfrom(i),:) + [x, y];
end

for i = 1:length(coordinates)
    x = coordinates(i,1);
    y = coordinates(i,2);
    c = -Xref+Yref;  
    d = (x + (y-c))/2;
    coordinates(i,1) = 2*d-x;
    coordinates(i,2) = 2*d-y+2*c;
end

plot(coordinates(1:end,1),coordinates(1:end,2),'r*');
hold off;
%axis([Xref-25 Xref+5 Yref-5 Yref+25])
xlabel('UTM (meters)');
ylabel('UTM (meters)');
title('Camponotus Map');

