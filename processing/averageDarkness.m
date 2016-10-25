function output = averageDarkness(a)
  re = reshape(a, [1, numel(a)]);
  output = 1- mean(re)/255;
end