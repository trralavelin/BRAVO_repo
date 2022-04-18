local sec_values = {0}
local smooth_values = {0}
local oneHzCpt = 0
local smooth_max = 0
local smooth_mean = 0


-- Call at 25Hz
function lissageFormater (input)

   -- 1sec
   if #sec_values > 24 then table.remove(sec_values,1) end
   table.insert(sec_values, input)

   local sec_max = sec_values[1]
   local sec_mean = 0
   for i,val in ipairs(sec_values) do
      if val > sec_max then
         sec_max = val
      end
      sec_mean = sec_mean +val
   end
   sec_mean = sec_mean / #sec_values

   oneHzCpt = oneHzCpt +1
   if oneHzCpt > 24 then
      oneHzCpt = 0

      -- 30sec
      if #smooth_values > 29 then table.remove(smooth_values,1) end
      table.insert(smooth_values, sec_mean)

      smooth_max = smooth_values[1]
      for j,val in ipairs(smooth_values) do
         if val > smooth_max then
         smooth_max = val
         end
         smooth_mean = smooth_mean +val
      end
      smooth_mean = smooth_mean / 31

     
     
   end

   return smooth_mean
end
