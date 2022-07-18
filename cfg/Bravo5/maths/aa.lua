--
-- V1.0 
--  fichier LUA made by AA
-- 
-- last update : 26 mai 2022
-- Next version : daté le dernier dépassement pour l'afficher ds le BoD
--
-- Permet de détecter un dépassement de seuil structurel et de garder affiché le 
-- seuil du capteur affiché jusqu'à l'acquittement par l'appuie d'un bouton RESET dans BoD
-- le fichier est appelé dans boat_load.sys, dans lequel sont définis les seuils
--
-- un autre fichier lua gère les alarmes en sortie
-- 
-- 
local cpt = 0
local led = 6
local MaxSeuil_10s = 1
local MaxSeuil_1s = 1
local tableoutput10s = {0} -- déclaration de la table 
local tableoutput1s = {0} -- déclaration de la table 
local BoD_activateACK = 0
local Seuil = 0 -- dépassement instantanée du seuil
local SeuilT = 0
local heure = 0
local t0 = 0
local Buzz = 0
local alarmeVALIDE = 0
local clock=os.clock()
local varmute = 0

function aa(input10s,input1s,stateACK,waituser,activate)
-- input10s = LoadSense en %
-- stateACK = Appuie sur le bouton correspondant à au stateACK du LoadSense dans le BoD

	-- tout est OK
	if input10s < 100 and input1s < 100
	then 
		SeuilT = 1
	end
	
	-- CAS1 LED rge dépassement de seuil 100%, et on garde le MAX de la valeure LoadSense
	if input10s > 100 or input1s > 100
	then 
		-- on remplit la table uniquement qd il y a dépassement de seuil
		table.insert(tableoutput10s, input10s)
		MaxSeuil_10s = tableoutput10s[1] --1er dépassement de seuil, 1ere valeure de la table
		table.insert(tableoutput1s, input1s)
		MaxSeuil_1s = tableoutput1s[1]
		--time = os.date("*t")
		heure = os.date("%H%M")
		for i, val in ipairs(tableoutput10s) do
			if val > MaxSeuil_10s then
				MaxSeuil_10s = val --détermine le max de la table
			end
		end 
		for j, valj in ipairs(tableoutput1s) do 
			if valj > MaxSeuil_1s 	then
				MaxSeuil_1s = valj --détermine le max de la table
			end
		end
		led = 3
		Seuil = 1
		SeuilT = 0 
		BoD_activateACK = 1 --pour activer le bouton ACK dans BOD; cela fait passer la VAR stateACK = 1
		
	--CAS2 LED org, tout est OK mais on a pas appuyé sur ACK 
	elseif SeuilT == 1 and stateACK == 1 
	then
		led = 2
		Seuil = 0
		
	--CAS3 retour LED VERTE; tout est OK et on a appuyé sur ACK
	elseif SeuilT == 1 and stateACK == 0  
	then 
		MaxSeuil_10s = input10s 
		tableoutput10s = {0}
		MaxSeuil_1s = input1s 
		tableoutput1s = {0}  -- on remet la table à 0
		BoD_activateACK = 0 -- on a appuyé sur ACK donc l'état du bouton ACK passe à 0
		Seuil = 0
		led = 1
	 
	else
		cpt = 8
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
	return led,MaxSeuil_10s,MaxSeuil_1s, cpt,BoD_activateACK, Buzz, heure
	-- l'ordre est important pour le MaxSeuil_10s.add
end

