local t0 = 0
local clock=os.clock()
local mutelua = 0
local alarmeVALIDE = 0
local wait = 10

function aater(muteAlarme,activate,waituser)

	-- CAS1 : état par défaut
	--------------------------------------------
	if muteAlarme == 1 	
	then
			mutelua =1
			t0 = os.clock()
	end
	 
	--CAS2 : on click sur le bouton MUTE (passe de 1 à 0)
	if muteAlarme == 0
	then 
		if os.clock() - t0 < waituser 
		then
				mutelua = 0
				-- on laisse le bouton à 0 tant qu'on a pas dépasser le temps
		else	
				mutelua = 1 -- à 3
				-- dès que le temps est dépassé on fait rebasculer le bouton MUTE à 1 via expertsys
		end
	end 
	
	--CAS3 : on regarde aussi si l'alarme est active (dans les settings alarmes)
	if mutelua == 1 and activate == 1
	then
		alarmeVALIDE = 1 --Alarme valide 
	else
		alarmeVALIDE = 0 --Alarme non valide
	end
	return alarmeVALIDE, mutelua
end 