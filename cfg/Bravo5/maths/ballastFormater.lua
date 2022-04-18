local sec_values = {0}
local tens_values = {0}
local sixty_values = {0}
local oneHzCpt = 0
local tenSecCpt = 0
local tens_max = 0
local tens_mean = 0
local sixty_max = 0
local sixty_mean = 0

-- Call at 25Hz
function loadFormater (input)

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

      -- 10sec
      if #tens_values > 9 then table.remove(tens_values,1) end
      table.insert(tens_values, sec_mean)

      tens_max = tens_values[1]
      for j,val in ipairs(tens_values) do
         if val > tens_max then
         tens_max = val
         end
         tens_mean = tens_mean +val
      end
      tens_mean = tens_mean / 11

      -- 60sec
      tenSecCpt = tenSecCpt +1
      if tenSecCpt > 9 then
         tenSecCpt = 0

         if #sixty_values > 5 then table.remove(sixty_values,1) end
         table.insert(sixty_values, tens_mean)

         sixty_max = sixty_values[1]
         for k,val in ipairs(sixty_values) do
            if val > sixty_max then
            sixty_max = val
            end
            sixty_mean = sixty_mean +val
         end
         sixty_mean = sixty_mean / 7

      end
   end

   return sec_max, sec_mean, tens_max, tens_mean, sixty_max, sixty_mean
end
