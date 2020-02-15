function [is_fit x2 x2_gate interval_storage norm_interval_storage] = normfit(
                            value_list,
                            confidence = 0.95,
                            m = mean(value_list),
                            s = std(value_list, 0)
                          )
  interval_count = floor_to_even(columns(value_list) / 10);
  interval_range = s * 3 * 2 / interval_count;
  interval_storage = zeros(1, interval_count);
  for sx = floor((value_list.-m)./interval_range).+interval_count/2.+1
    if (sx<1)
      sx = 1;
    elseif (sx > interval_count)
      sx = interval_count;
    end

    interval_storage(1, sx) += 1;
  end

  norm_storage = zeros(1, interval_count+1);
  for i = [0:interval_count]
    norm_storage(1, i+1) = normcdf((i-interval_count/2)*interval_range, 0, s);
  end
  norm_interval_storage = diff(norm_storage);
  one_side_outleir = norm_storage(1,1);
  norm_interval_storage(1,1) += one_side_outleir;
  norm_interval_storage(1, end) += one_side_outleir;

  norm_interval_storage .*= columns(value_list); 
  x2 = sum(
           (interval_storage .- round(norm_interval_storage)).^2 ./
           norm_interval_storage
         );
  x2_gate = chi2inv(confidence, interval_count-3);
  is_fit = x2_gate > x2;
end

function even = floor_to_even(n)
  even = 2 * floor(n/2);
end
