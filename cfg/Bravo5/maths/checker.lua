local in_values = {0}

function checker (x, N)

   local size = #in_values
   if size >= N then table.remove(in_values,1) end
   table.insert(in_values, x)
   local status = 0

   if size > 1 then
      local value = in_values[1]

      for i,val in ipairs(in_values) do
         if val ~= value then
           status = 1
         end
      end
   end
   return status
end
