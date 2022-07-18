-- V1.0
-- fichier lua made by AA
--
-- last update : 26 mai 2022
--
-- Permet de gérer les alarmes VOIX et BUZZ
-- l'alarme Voix est générée dans le fichier bravo_hardware.sys sur le node 0x05C
-- l'alarme Buzz est générée dans le fichier bravo_hardware?sys sur le node 0x05C

local K11 = 0
local K12 = 0
local K21 = 0
local K22 = 0
local buzz = 0



function aabis(E2Buzz,E3Buzz,E0E1Buzz,E4Buzz,Outrigger_Buzz,Runner_Buzz,Foil_Buzz,J3minBuzz,BatteryBuzz,EauBuzz,PiloteBuzz)
-- muteE1, muteE2, muteE3, muteOTrib, muteObab, muteRtrib, muteRbab, muteFtrib, muteFbab, muteEau, muteBatt, M_Brain, M_Controller
-- valide : si l'Alarme est valide (de 1 à 11)
-- mute : Appuie sur le bouton MUTE en face de chaque Alarme muteE1 ..

	if E2Buzz == 1 
	then
		K11 = 0
		K12 = 1
		K21 = 0
		K22 = 0
		buzz = 1 
	elseif E3Buzz == 1 	
	then
		K11 = 1
		K12 = 1
		K21 = 0
		K22 = 0
		buzz = 1
	elseif E0E1Buzz == 1 
	then
		K11 = 1
		K12 = 0
		K21 = 0
		K22 = 0
		buzz = 1
	elseif E4Buzz == 1
	then
		K11 = 0
		K12 = 0
		K21 = 0
		K22 = 1
		buzz = 1
	elseif Outrigger_Buzz == 1 
	then
		K11 = 0
		K12 = 0
		K21 = 1
		K22 = 0
		buzz = 1
	elseif Runner_Buzz == 1 
	then
		K11 = 1
		K12 = 1
		K21 = 0
		K22 = 1
		buzz = 1
	elseif Foil_Buzz == 1 
	then
		K11 = 1
		K12 = 0
		K21 = 0
		K22 = 1
		buzz = 1
	elseif J3minBuzz == 1
	then
		K11 = 0
		K12 = 1
		K21 = 0
		K22 = 1
		buzz = 1
	elseif BatteryBuzz == 1 
	then
		K11 = 0
		K12 = 1
		K21 = 1
		K22 = 0
		buzz = 1
	elseif EauBuzz == 1 
	then
		K11 = 1
		K12 = 1
		K21 = 1
		K22 = 0
		buzz = 1
	elseif PiloteBuzz == 1 
	then
		K11 = 1
		K12 = 0
		K21 = 1
		K22 = 0
		buzz = 1
	else
		K11 = 0
		K12 = 0
		K21 = 0
		K22 = 0
		buzz = 0
	end
	return K11,K12,K22,K21,buzz
end  