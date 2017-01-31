function bool = is_red(rgb)
   if rgb(1) > 200 && rgb(2) < 100 && rgb(3) < 100
       bool = 1;
   else
       bool = 0;
   end
end