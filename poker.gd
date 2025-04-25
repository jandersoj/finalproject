extends Node2D

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
	print("shuffled deck")
	print(cardsremaining)
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
#var pvalue1=0
var cardstringreveal0
var cardstringreveal1
var cardstringreveal2
var cardstringreveal3
var cardstringreveal4
var playervalue=0
var dealervalue=0
func pvalue():
	playervalue=0
	var curremtsuit=playerhand[0].get_suit()
	for i in range(playerhand.size()):
		playervalue+=playerhand[i].face_value()
	
		
		if playerhand[i].get_faces()=="Ace":
			playervalue+=11
		
func dvalue():
	dealervalue=0
	var curremtsuit=dealerhand[0].get_suit()
	for i in range(dealerhand.size()):
		dealervalue+=dealerhand[i].face_value()
	
		
		if dealerhand[i].get_faces()=="Ace":
			dealervalue+=11
		

func _process(delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()


func _on_bet_text_submitted(new_text: String) -> void:
	wager=new_text.to_float()
	if wager>Globals.bankroll || wager<0:
			print("Wager cannot be greater than bankroll or less than zero.")
	else:
		print("You wagered: $" + str(wager) + ". Let's get started!")
		playerhand.resize(5)
		dealerhand.resize(5)
		for i in range(5):
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
		for i in range(5):
			if cardsremaining==0:
				shuffle()
				print("Shuffled deck")
			dealerhand[i]=deal()
			if i==0:
				var cardstring="res://cards/blank.tscn"
				cardstringreveal0="res://cards/"+str(dealerhand[i].get_faces())+str(dealerhand[i].get_suit())+".tscn"
				var CARD=load(cardstring)
				var displayc=CARD.instantiate()
				displayc.position.x=displayc.position.x + (i * 160)
				#displayc.position.y=500
				$Dealerhand.add_child(displayc)
			if i==1:
				var cardstring="res://cards/blank.tscn"
				cardstringreveal1="res://cards/"+str(dealerhand[i].get_faces())+str(dealerhand[i].get_suit())+".tscn"
				var CARD=load(cardstring)
				var displayc=CARD.instantiate()
				displayc.position.x=displayc.position.x + (i * 160)
				#displayc.position.y=500
				$Dealerhand.add_child(displayc)
			if i==2:
				var cardstring="res://cards/blank.tscn"
				cardstringreveal2="res://cards/"+str(dealerhand[i].get_faces())+str(dealerhand[i].get_suit())+".tscn"
				var CARD=load(cardstring)
				var displayc=CARD.instantiate()
				displayc.position.x=displayc.position.x + (i * 160)
				#displayc.position.y=500
				$Dealerhand.add_child(displayc)
			if i==3:
				var cardstring="res://cards/blank.tscn"
				cardstringreveal3="res://cards/"+str(dealerhand[i].get_faces())+str(dealerhand[i].get_suit())+".tscn"
				var CARD=load(cardstring)
				var displayc=CARD.instantiate()
				displayc.position.x=displayc.position.x + (i * 160)
				#displayc.position.y=500
				$Dealerhand.add_child(displayc)
			if i==4:
				var cardstring="res://cards/blank.tscn"
				cardstringreveal4="res://cards/"+str(dealerhand[i].get_faces())+str(dealerhand[i].get_suit())+".tscn"
				var CARD=load(cardstring)
				var displayc=CARD.instantiate()
				displayc.position.x=displayc.position.x + (i * 160)
				#displayc.position.y=500
				$Dealerhand.add_child(displayc)
			#else:
				#var cardstring="res://cards/"+str(dealerhand[i].get_faces())+str(dealerhand[i].get_suit())+".tscn"
				#var CARD=load(cardstring)
				#var displayc=CARD.instantiate()
				#displayc.position.x=displayc.position.x + (i * 160)
				#displayc.position.y=500
				#$Dealerhand.add_child(displayc)
			Globals.dealerxpos=160
		hand = "Your hand is now: " + str(playerhand[0]) + ", " + str(playerhand[1])
		print(hand)
		print("Cards left: "+str(cardsremaining))
		
		print("The dealer's hand is: " + str(dealerhand[0]) + " and one hidden card")
		
		

func _on_end_turn_pressed() -> void:
	input="stand"
	turnchoice="stand"
	var hidden=$Dealerhand.get_children()
	Globals.dealerxpos=0
	var base
	var count=0
	pvalue()
	dvalue()
	if playervalue>dealervalue:
		Globals.bankroll+=wager
	if playervalue<dealervalue:
		Globals.bankroll-=wager
	print(Globals.bankroll)
	$Money.text="$"+str(Globals.bankroll)
	print(dealervalue)
	print(playervalue)
	$Playervalue.text=str(playervalue)
	$Dealervalue.text=str(dealervalue)
	for i in hidden:
		
			#i.queue_free()
			
			#var cardstring="res://cards/"+str(dealerhand[i].get_faces())+str(dealerhand[i].get_suit())+".tscn"
		if count==0:
			i.queue_free()
			var CARD=load(cardstringreveal0)
			var displayc=CARD.instantiate()
			displayc.position.x=Globals.dealerxpos
			#displayc.position.y=500
			$Dealerhand.add_child(displayc)
		if count==1:
			i.queue_free()
			var CARD=load(cardstringreveal1)
			var displayc=CARD.instantiate()
			displayc.position.x=Globals.dealerxpos
			#displayc.position.y=500
			$Dealerhand.add_child(displayc)
		if count==2:
			i.queue_free()
			var CARD=load(cardstringreveal2)
			var displayc=CARD.instantiate()
			displayc.position.x=Globals.dealerxpos
			#displayc.position.y=500
			$Dealerhand.add_child(displayc)
		if count==3:
			i.queue_free()
			var CARD=load(cardstringreveal3)
			var displayc=CARD.instantiate()
			displayc.position.x=Globals.dealerxpos
			#displayc.position.y=500
			$Dealerhand.add_child(displayc)
		if count==4:
			i.queue_free()
			var CARD=load(cardstringreveal4)
			var displayc=CARD.instantiate()
			displayc.position.x=Globals.dealerxpos
			#displayc.position.y=500
			$Dealerhand.add_child(displayc)
		count+=1
		Globals.dealerxpos+=160
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
	if cardsremaining<=10:
		shuffle()
	
	Globals.nextxpos=160
	Globals.dealerxpos=160
	if Globals.bankroll<=0:
		print("You lose!!!")
	#taketurn()
