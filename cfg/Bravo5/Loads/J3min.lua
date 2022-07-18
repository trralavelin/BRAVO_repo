--
-- 

-- 

local led = 6
local SeuilT = 0
local heure = 0
local BoD_activateACK = 5
local Seuil = 0
local t0 = 0
local Buzz = 0
local alarmeVALIDE = 0
local clock=os.clock()

function J3min(E3_1s_mean,E1_1s_mean,stateACK,E3min,E1max, waituser,activate)
	
	
	--Cas LED rge
	if E3_1s_mean < E3min and E1_1s_mean > E1max
	then 
		heure = os.date("%H%M")
		led = 3
		BoD_activateACK = 1
	--	SeuilT = 0 
		Seuil = 1
		
	--CAS2 LED org
	elseif stateACK == 1 
	then
		led = 2
		Seuil = 0
						
	--CAS3 = normal/init input10s ss le seuil et acquittement
	elseif stateACK == 0  
	then 
		BoD_activateACK = 0
		led = 1
		Seuil = 0
	else		
		led = 4
	end  
--------------- gestion du bouton ACK --------------------------------
 	-- on dépasse le seuil, et on a pas encore appuyer sur ACK (stateACK est à 1)
	if Seuil == 1 and stateACK == 1
	then 
		t0 = os.clock()
		varmute = 1 -- Alarme sonne 
	end
	
	-- On est au dessus du seuil et on a appuyé sur le bouton ACK
	if Seuil == 1 and stateACK == 0
	then 
		-- on attend 	
		if os.clock() - t0 < waituser 
		then
				BoD_activateACK = 0 -- on garde le bouton ACK desactive
				varmute = 0
		else 
				BoD_activateACK = 1 --on reactive le bouton ACK
				varmute = 1
		end
	end
	
	
	-- Desactivation de l'alarmes (varmute = 1 si pas d'appuie sur le bouton)
	if activate == 1 and varmute == 1
	then 
		alarmeVALIDE = 1
	else
		alarmeVALIDE = 0
	end
	-- On dépasse le seuil et l'alarme est valide, donc ça peut buzzer
	if alarmeVALIDE == 1 and Seuil == 1
	then 
		Buzz = 1
	else 
		Buzz = 0
	end
	return led,BoD_activateACK, Buzz, heure 
	-- l'ordre est important pour le MaxSeuil_10s.add
end

