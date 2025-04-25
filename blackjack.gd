extends Node2D
#class_name Card
class Card1:
	var suits=["Spades", "Diamonds","Clubs","Hearts"]
	var facevalues=[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]
	var faces=["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"]
	var suit
	var face
	var suitIndex
	var faceIndex
	func _init(i,j) -> void:
		suitIndex = i;
		faceIndex = j;
		suit = suits[i];
		face = faces[j];
	func get_faces():
		return str(faces[faceIndex])
	func face_value():
		return facevalues[faceIndex]
	func get_suit():
		return suits[suitIndex];
	func _to_string() -> String:
		return str("" + face + " of " + suit)
var deck=[]
var cardsremaining=52
func _ready() -> void:
	randomize()
	deck.resize(52)
	
	
	for i in range(cardsremaining):
			#deck[i]=Card(i/13, i%13).new()
			deck[i]=Card1.new(i/13, i%13)
	shuffle()
	#play()
func shuffle():
	cardsremaining=52
	for i in range(deck.size()):
		var x= randi()%52
		var temp=deck[x]
		var temp2=deck[i]
		deck[i] = temp
		deck[x] = temp2
func deal():
	var card1=deck[52-cardsremaining]
	cardsremaining-=1
	return card1
var playerhand=[]
var dealerhand=[]
var bankroll=10000
var turnchoice=""
var dealercount=0
var hand
var input=""
var wager:float=0
var roundcounter=1
var counter=2
var pvalue1=0
var cardstringreveal
#var entry
func play():
	#hand = "Your hand is now: " + playerhand[0] + ", " + playerhand[1]
	playerhand=[deal(),deal()]
	dealerhand=[deal(),deal()]
	bankroll=10000
	hand = "Your hand is now: " + str(playerhand[0]) + ", " + str(playerhand[1])
	while bankroll>0 && input=="":
		print("Let's play Blackjack! How much of your $" + str(bankroll) + "0 would you like to wager?")
		#Make input box for wager
		
		turnchoice=""
		input=""
		while wager>bankroll || wager<0:
			print("Wager cannot be greater than bankroll or less than zero.")
		if roundcounter>0:
			dealercount=0
			counter=2
			playerhand=[Card1.new(randi()%4, randi()%13),Card1.new(randi()%4, randi()%13)]
			dealerhand=[Card1.new(randi()%4, randi()%13),Card1.new(randi()%4, randi()%13)]
			for i in range(2):
				if cardsremaining==0:
					shuffle()
				playerhand[i]=deal()
			for i in range(2):
				if cardsremaining==0:
					shuffle()
				dealerhand[i]=deal()
			hand = "Your hand is now: " + str(playerhand[0]) + ", " + str(playerhand[1])
			while pvalue() < 21 && dvalue() <= 21:
				taketurn()
			if pvalue()==21 && dvalue()<17:
				dealerturn()
			compare()
			roundcounter+=1
			if bankroll<=0:
				print("You lose!!!")
				#Change scene to casino
			
func _process(delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	#playerhand=[deal(),deal()]
	#dealerhand=[deal(),deal()]
	#bankroll=10000
	#hand = "Your hand is now: " + str(playerhand[0]) + ", " + str(playerhand[1])
	if bankroll>0 && input=="":
		pass
		#maybe change to while
		#print("Let's play Blackjack! How much of your $" + str(bankroll) + "0 would you like to wager?")
		#Make input box for wager
		
		#turnchoice=""
		#input=""
		#if wager>bankroll || wager<0:
		#	print("Wager cannot be greater than bankroll or less than zero.")
		#if roundcounter>0:
			#dealercount=0
			#counter=2
			#playerhand=[Card1.new(randi()%4, randi()%13),Card1.new(randi()%4, randi()%13)]
			#dealerhand=[Card1.new(randi()%4, randi()%13),Card1.new(randi()%4, randi()%13)]
			#for i in range(2):
			#	if cardsremaining==0:
			#		shuffle()
			#	playerhand[i]=deal()
			#for i in range(2):
			#	if cardsremaining==0:
			#		shuffle()
			#	dealerhand[i]=deal()
			#hand = "Your hand is now: " + str(playerhand[0]) + ", " + str(playerhand[1])
			#while pvalue() < 21 && dvalue() <= 21:
			#	taketurn()
			#if pvalue()==21 && dvalue()<17:
			#	dealerturn()
			#compare()
			#roundcounter+=1
			#if Globals.bankroll<=0:
			#	print("You lose!!!")
				#Change scene to casino
			
func taketurn():
	#while !turnchoice=="hit"&& !turnchoice=="stand" && $"../slowdown".is_stopped():
	#	$"../slowdown".start()
	if turnchoice=="hit":
		hit()
		hand+=", "+str(playerhand[counter])
		counter+=1
		#hand = "Your hand is now: " + str(playerhand[0]) + ", " + str(playerhand[1])
		print(hand)
		turnchoice=""
	print(hand)
func dealerturn():
	while dvalue()<17:
		dealerhit()
		dealercount+=1
func dealerhit():
	if cardsremaining==0:
		shuffle()
	var handlength = dealerhand.size()
	var temp=[]
	temp.resize(handlength)
	for i in range(handlength):
		temp[i] = dealerhand[i]
	dealerhand.resize(handlength+1)
	dealerhand[dealerhand.size()-1]=deal()
	var cardstring="res://cards/"+str(dealerhand[dealerhand.size()-1].get_faces())+str(dealerhand[dealerhand.size()-1].get_suit())+".tscn"
	var CARD=load(cardstring)
	var displayc=CARD.instantiate()
	Globals.dealerxpos+=160
	displayc.position.x=displayc.position.x + Globals.dealerxpos
	$Dealerhand.add_child(displayc)
	for x in range(dealerhand.size()-1):
		dealerhand[x] = temp[x]
	print(dealerhand)
	return dealerhand
func hit():
	if cardsremaining==0:
		shuffle()
	var handlength = playerhand.size()
	var temp=[]
	temp.resize(handlength)
	for i in range(handlength):
		temp[i] = playerhand[i]
	playerhand.resize(handlength+1)
	playerhand[playerhand.size()-1]=deal()
	var cardstring="res://cards/"+str(playerhand[playerhand.size()-1].get_faces())+str(playerhand[playerhand.size()-1].get_suit())+".tscn"
	var CARD=load(cardstring)
	var displayc=CARD.instantiate()
	Globals.nextxpos+=160
	displayc.position.x=displayc.position.x + Globals.nextxpos
	$Playerhand.add_child(displayc)
	for x in range(playerhand.size()-1):
		playerhand[x] = temp[x]
		
	return playerhand
func _on_line_edit_text_submitted(new_text: String) -> void:
	wager=new_text.to_float()
	if wager>Globals.bankroll || wager<0:
			print("Wager cannot be greater than bankroll or less than zero.")
	else:
		print("You wagered: $" + str(wager) + ". Let's get started!")
		playerhand.resize(2)
		dealerhand.resize(2)
		for i in range(2):
			if cardsremaining==0:
				shuffle()
				print("Shuffled deck")
			playerhand[i]=deal()
			var cardstring="res://cards/"+str(playerhand[i].get_faces())+str(playerhand[i].get_suit())+".tscn"
			var CARD=load(cardstring)
			var displayc=CARD.instantiate()
			displayc.position.x=displayc.position.x + (i * 160)
			$Playerhand.add_child(displayc)
			Globals.nextxpos=160
		for i in range(2):
			if cardsremaining==0:
				shuffle()
				print("Shuffled deck")
			dealerhand[i]=deal()
			if i==0:
				var cardstring="res://cards/blank.tscn"
				cardstringreveal="res://cards/"+str(dealerhand[i].get_faces())+str(dealerhand[i].get_suit())+".tscn"
				var CARD=load(cardstring)
				var displayc=CARD.instantiate()
				displayc.position.x=displayc.position.x + (i * 160)
				#displayc.position.y=500
				$Dealerhand.add_child(displayc)
			else:
				var cardstring="res://cards/"+str(dealerhand[i].get_faces())+str(dealerhand[i].get_suit())+".tscn"
				var CARD=load(cardstring)
				var displayc=CARD.instantiate()
				displayc.position.x=displayc.position.x + (i * 160)
				#displayc.position.y=500
				$Dealerhand.add_child(displayc)
			Globals.dealerxpos=160
		hand = "Your hand is now: " + str(playerhand[0]) + ", " + str(playerhand[1])
		print(hand)
		print(pvalue())
		print("The dealer's hand is: " + str(dealerhand[0]) + " and one hidden card")

	
func pvalue():
	var pvalue=0
	for i in range(playerhand.size()):
		pvalue+=playerhand[i].face_value()
	if pvalue<=11:
		pvalue=0
		for i in range(playerhand.size()):
			if playerhand[i].get_faces()=="Ace" && pvalue<=10:
				pvalue+=11
			else:
				pvalue+=playerhand[i].face_value()
	return pvalue
func dvalue():
	var dvalue=0
	for i in range(dealerhand.size()):
		dvalue+=dealerhand[i].face_value()
	if dvalue<=11:
		dvalue=0
		for i in range(dealerhand.size()):
			if dealerhand[i].get_faces()=="Ace" && dvalue<=10:
				dvalue+=11
			else:
				dvalue+=dealerhand[i].face_value()
	return dvalue
func compare():
	#if pvalue()<=21:
		if pvalue()==21 && dvalue()!=21:
			#You have blackjack
			Globals.bankroll+=(wager*(1.5))
		elif dvalue()>21 && pvalue()>21:
			Globals.bankroll-=wager
		elif dvalue()>21:
			#Dealer Bust
			Globals.bankroll+=wager
		elif pvalue()>dvalue() && pvalue()<=21:
			#Player value is higher
			Globals.bankroll+=wager
		elif dvalue()>pvalue() && dvalue()<=21:
			#Dealer value higher
			Globals.bankroll-=wager
		elif pvalue()>21:
			#Player Bust
			Globals.bankroll-=wager
		print(Globals.bankroll)
		$Money.text="$"+str(Globals.bankroll)
		$Playervalue.text=str(pvalue())
		$Dealervalue.text=str(dvalue())


func _on_hit_pressed() -> void:
	input="hit"
	turnchoice="hit"
	#print("got here")
	taketurn()


func _on_stay_pressed() -> void:
	input="stand"
	turnchoice="stand"
	taketurn()
	dealerturn()
	compare()
	var hidden=$Dealerhand.get_children()
	for i in hidden:
		if i==hidden[0]:
			#i.queue_free()
			Globals.dealerxpos=160
			#var cardstring="res://cards/"+str(dealerhand[i].get_faces())+str(dealerhand[i].get_suit())+".tscn"
			i.queue_free()
			var CARD=load(cardstringreveal)
			var displayc=CARD.instantiate()
			displayc.position.x=displayc.position.x
			#displayc.position.y=500
			$Dealerhand.add_child(displayc)
	$slowdown.start()
	await $slowdown.timeout
	if $slowdown.is_stopped():
		var cards=$Playerhand.get_children()
		for i in cards:
			i.queue_free()
			
		#$Playerhand.queue_free()
		playerhand.clear()
		print("got here")
		var cards1=$Dealerhand.get_children()
		for i in cards1:
			i.queue_free()
			
		#$Playerhand.queue_free()
		dealerhand.clear()
	counter=0
	
	Globals.nextxpos=160
	Globals.dealerxpos=160
	if Globals.bankroll<=0:
		print("You lose!!!")
	#taketurn()
