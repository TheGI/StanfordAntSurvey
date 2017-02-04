coordinates = [];
coordinates(47,:) = [0, 0];
for i = 1:length(idfrom)
    [x, y] = pol2cart(angle1(i)*pi/180,distance1(i));
    coordinates(idto(i),:) = coordinates(idfrom(i),:) + [x, y];
end

hold on;
coordinates = coordinates .* -1;

plot(coordinates(1:46,2),coordinates(1:46,1),'ro');
for i = 1:46
text(coordinates(i,2)-5,coordinates(i,1)+10,num2str(i),'HorizontalAlignment','right');
end
plot(coordinates(47:end,2),coordinates(47:end,1),'b*');
for i = 47:51
text(coordinates(i,2)-5,coordinates(i,1)+20,num2str(i),'HorizontalAlignment','right');
end
hold off;
%axis([-100 2600 -2600 100])
%axis([-100 1250 -2600 -1250])
%axis([-100 1250 -1250 100])
%axis([1250 2600 -2600 -1250])
%axis([1250 2600 -1250 100])
%axis([400 830 -1200 -700])
%axis([400 830 -700 -200])
%axis([830 1260 -1200 -700])
axis([830 1260 -700 -200])
