extends Node2D
#class_name Deck
class Deck:
	var deck=[]
	var cardsremaining=52
	func _init() -> void:
		#deck=new Card[52]
		for i in range(cardsremaining):
			#deck[i]=Card(i/13, i%13).new()
			#deck[i]=Card.new(i/13, i%13)
			pass
		
