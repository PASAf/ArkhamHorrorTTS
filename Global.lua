panelGUID = 'a9a349'
mapBoardGUID = '46e546'

-- Decks
commonItemsDeckGUID = 'ead480'
uniqueItemsDeckGUID = 'fce27e'
spellsDeckGUID = '3c99e8'
skillsDeckGUID = '4c15aa'
alliesDeckGUID = 'bcf982'

mythosDeckGUID = '694d09'
gatesDeckGUID = 'ca8f8b'

northsideLocationDeckGUID = '26755b'
downtownLocationDeckGUID = 'fe6863'
easttownLocationDeckGUID = 'b1b634'
merchantDistrictLocationDeckGUID = '1973fc'
rivertownLocationDeckGUID = '0bac1f'
miskatonicUniversityLocationDeckGUID = 'd1d429'
frenchHillLocationDeckGUID = '2ade4d'
uptownLocationDeckGUID = '26e0b1'
southsideLocationDeckGUID = 'b942bf'

-- Bags
investigatorSheetsBagGUID = '19dd07'
ancientOneSheetsBagGUID = '585458'
gateMarkersBagGUID = '42c3cc'
monsterMarkersBagGUID = 'bebbc3'
cheatsheetsBagGUID = '08f827'

-- Investigators miscellaneous
skillSlidersBagGUID = '2a61d5'
sanityTokensBagGUID = 'c9764c'
staminaTokensBagGUID = 'bb967f'
clueTokensBagGUID = 'bbc788'
moneyTokensBagGUID = '6b1a8b'

-- Buttons
buttonSetup = { click_function='setup', function_owner=nil,
label='Setup', position={0,0.8,0}, rotation={0,0,0}, width=3000,
height=1500, font_size=1000 }

buttonMove = { click_function='nullFunc', function_owner=nil, label='Ход',
position={0,0.8,-6}, rotation={0,0,0}, width=3500, height=1500, font_size=1000 }
buttonPhase = { click_function='nullFunc', function_owner=nil, label='Фаза',
position={0,0.8,-3}, rotation={0,0,0}, width=3500, height=1500, font_size=500 }
buttonIncreaseMove = { click_function='increaseMove',
function_owner=nil, label='>', position={6,0.8,-6},
rotation={0,0,0}, width=1500, height=1500, font_size=1000 }
buttonDecreaseMove = { click_function='decreaseMove',
function_owner=nil, label='<', position={-6,0.8,-6},
rotation={0,0,0}, width=1500, height=1500, font_size=1000 }
buttonIncreasePhase = { click_function='increasePhase',
function_owner=nil, label='>', position={6,0.8,-3},
rotation={0,0,0}, width=1500, height=1500, font_size=1000 }
buttonDecreasePhase = { click_function='decreasePhase',
function_owner=nil, label='<', position={-6,0.8,-3},
rotation={0,0,0}, width=1500, height=1500, font_size=1000 }

-- Globals
setupEd = false
move = 0
phase = 0
phaseLiteral = {'Пердышка', 'Движение', 'Контакты в\nАркхэме',
    'Контакты в\nИных мирах', 'Миф' }

function onload()
    panel = getObjectFromGUID(panelGUID)
    panel.createButton(buttonSetup)
end

function setup()
    if setupEd then
        return
    end
    panel = getObjectFromGUID(panelGUID)
    panel.removeButton(0)

    spreadMessage('Let the magic begins.')

    -- create buttons
    panel.createButton(buttonMove)
    panel.createButton(buttonPhase)
    panel.createButton(buttonIncreaseMove)
    panel.createButton(buttonDecreaseMove)
    panel.createButton(buttonIncreasePhase)
    panel.createButton(buttonDecreasePhase)

    -- Setup objects
    --  Decks
    commonItemsDeck = getObjectFromGUID(commonItemsDeckGUID)
    uniqueItemsDeck = getObjectFromGUID(uniqueItemsDeckGUID)
    spellsDeck = getObjectFromGUID(spellsDeckGUID)
    skillsDeck = getObjectFromGUID(skillsDeckGUID)
    alliesDeck = getObjectFromGUID(alliesDeckGUID)

    mythosDeck = getObjectFromGUID(mythosDeckGUID)
    gatesDeck = getObjectFromGUID(gatesDeckGUID)

    northsideLocationDeck = getObjectFromGUID(northsideLocationDeckGUID)
    downtownLocationDeck = getObjectFromGUID(downtownLocationDeckGUID)
    easttownLocationDeck = getObjectFromGUID(easttownLocationDeckGUID)
    merchantDistrictLocationDeck = getObjectFromGUID(merchantDistrictLocationDeckGUID)
    rivertownLocationDeck = getObjectFromGUID(rivertownLocationDeckGUID)
    miskatonicUniversityLocationDeck = getObjectFromGUID(miskatonicUniversityLocationDeckGUID)
    frenchHillLocationDeck = getObjectFromGUID(frenchHillLocationDeckGUID)
    uptownLocationDeck = getObjectFromGUID(uptownLocationDeckGUID)
    southsideLocationDeck = getObjectFromGUID(southsideLocationDeckGUID)

    --  Bags
    investigatorSheetsBag = getObjectFromGUID(investigatorSheetsBagGUID)
    ancientOneSheetsBag = getObjectFromGUID(ancientOneSheetsBagGUID)
    gateMarkersBag = getObjectFromGUID(gateMarkersBagGUID)
    monsterMarkersBag = getObjectFromGUID(monsterMarkersBagGUID)
    cheatsheetsBag = getObjectFromGUID(cheatsheetsBagGUID)

    -- Shuffle everything
    commonItemsDeck.shuffle()
    uniqueItemsDeck.shuffle()
    spellsDeck.shuffle()

    mythosDeck.shuffle()
    gatesDeck.shuffle()

    northsideLocationDeck.shuffle()
    downtownLocationDeck.shuffle()
    easttownLocationDeck.shuffle()
    merchantDistrictLocationDeck.shuffle()
    rivertownLocationDeck.shuffle()
    miskatonicUniversityLocationDeck.shuffle()
    frenchHillLocationDeck.shuffle()
    uptownLocationDeck.shuffle()
    southsideLocationDeck.shuffle()

    investigatorSheetsBag.shuffle()
    ancientOneSheetsBag.shuffle()
    gateMarkersBag.shuffle()
    monsterMarkersBag.shuffle()

    -- Get players
    Players = getSeatedPlayers()

    -- Place cheatsheets
    cheatsheetsBag.takeObject(
    {position={-34,1,-5},
    rotation={0,180,0},
    params = {self,1},
    flip = false,
    index = #Players-1}).setLock(true)

    -- Reveal Ancient One
    ancientOneSheet = ancientOneSheetsBag.takeObject(
    {position={50,1,0},
    rotation={0,90,0},
    params = {self,1},
    flip = false,
    top = false})
	
	ancientOneSheet.setLock(true)

    setupEd = true
end

function increaseMove()
	phase = 1
	move = move + 1
	setMovePhase()
end

function decreaseMove()
	if move == 1 then
		return
	end
	phase = 5
	move = move - 1
	setMovePhase()
end

function increasePhase()
	if phase > 4 then
		return
	end
	if move == 0 then
		move = 1
	end
	phase = phase + 1
	setMovePhase()
end

function decreasePhase()
	if phase < 2 then
		return
	end
	if move == 0 then
		move = 1
	end
	phase = phase - 1
	setMovePhase()
end

function nullFunc()

end

function setMovePhase()
	spreadMessage('Ход '.. move .. '. Фаза: ' .. string.gsub(phaseLiteral[phase], "\n", " "))
	panel.editButton({index = 0, label = move})
	panel.editButton({index = 1, label = phaseLiteral[phase]})
    setNotes('Ход: ' .. move .. '\nФаза: ' .. string.gsub(phaseLiteral[phase], "\n", " "))
end

function spreadMessage(message)
    printToAll(message, {1, 1, 1})
end
