function hsi = rgb2hsi(rgb)
  r = rgb(:,1); g = rgb(:,2); b = rgb(:,3);
  disp([r g b])
  h = acos((r-g+r-b)/2./sqrt((r-g).^2+(r-b).*(g-b)));
  s = 1 .- 3./(r+g+b) .* min(rgb')';
  i = (r+g+b)/3;
  hsi = [h s i];
end
