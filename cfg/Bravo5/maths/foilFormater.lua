local in_1_values = {0}
local in_2_values = {0}
local in_3_values = {0}
local ex_1_values = {0}
local ex_2_values = {0}
local ex_3_values = {0}
local ex_4_values = {0}
local ex_5_values = {0}


-- Call at frequence Param (in Hz)
function foilFormater (in_1, in_2, in_3, ex_1, ex_2, ex_3, ex_4, ex_5, frequency)

   -- in_1
   local size = #in_1_values
   if size >= frequency then table.remove(in_1_values,1) end
   table.insert(in_1_values, in_1)

   local in_1_min = math.min(table.unpack(in_1_values))
   local in_1_max = math.max(table.unpack(in_1_values))

   -- in_2
   if size >= frequency then table.remove(in_2_values,1) end
   table.insert(in_2_values, in_2)

   local in_2_min = math.min(table.unpack(in_2_values))
   local in_2_max = math.max(table.unpack(in_2_values))

   -- in_3
   if size >= frequency then table.remove(in_3_values,1) end
   table.insert(in_3_values, in_3)

   local in_3_min = math.min(table.unpack(in_3_values))
   local in_3_max = math.max(table.unpack(in_3_values))

   -- ex_1
   if size >= frequency then table.remove(ex_1_values,1) end
   table.insert(ex_1_values, ex_1)

   local ex_1_min = math.min(table.unpack(ex_1_values))
   local ex_1_max = math.max(table.unpack(ex_1_values))

   -- ex_2
   if size >= frequency then table.remove(ex_2_values,1) end
   table.insert(ex_2_values, ex_2)

   local ex_2_min = math.min(table.unpack(ex_2_values))
   local ex_2_max = math.max(table.unpack(ex_2_values))

   -- ex_3
   if size >= frequency then table.remove(ex_3_values,1) end
   table.insert(ex_3_values, ex_3)

   local ex_3_min = math.min(table.unpack(ex_3_values))
   local ex_3_max = math.max(table.unpack(ex_3_values))

   -- ex_4
   if size >= frequency then table.remove(ex_4_values,1) end
   table.insert(ex_4_values, ex_4)

   local ex_4_min = math.min(table.unpack(ex_4_values))
   local ex_4_max = math.max(table.unpack(ex_4_values))

   -- ex_5
   if size >= frequency then table.remove(ex_5_values,1) end
   table.insert(ex_5_values, ex_5)

   local ex_5_min = math.min(table.unpack(ex_5_values))
   local ex_5_max = math.max(table.unpack(ex_5_values))

   -- In
   local in_min = math.min(in_1_min, in_2_min, in_3_min)
   local in_max = math.max(in_1_max, in_2_max, in_3_max)
   
   local in_peak = in_min -- ajouté. Pour prendre comme peak la valeur en compression (négative)
		-- modifications
   --local in_peak = in_max
   --if math.abs(in_min) > in_peak then in_peak = in_min end

   -- Ex
   local ex_min = math.min(ex_1_min, ex_2_min, ex_3_min, ex_4_min, ex_5_min)
   local ex_max = math.max(ex_1_max, ex_2_max, ex_3_max, ex_4_max, ex_5_max)
   
   local ex_peak = ex_min -- ajouté. Pour prendre comme peak la valeur en compression (négative)
		--modifications
   --local ex_peak = ex_max
   --if math.abs(ex_min) > ex_peak then ex_peak = ex_min end

   local peak = in_peak
   --if math.abs(ex_peak) > peak then peak = ex_peak end
   if ex_peak < peak then peak = ex_peak end -- Pour prendre le minimum entre intrados et extrados

   return in_1_min, in_1, in_1_max, in_2_min, in_2, in_2_max, in_3_min, in_3, in_3_max, ex_1_min, ex_1, ex_1_max, ex_2_min, ex_2, ex_2_max, ex_3_min, ex_3, ex_3_max, ex_4_min, ex_4, ex_4_max, ex_5_min, ex_5, ex_5_max, in_min, in_max, ex_min, ex_max, in_peak, ex_peak, peak

end
