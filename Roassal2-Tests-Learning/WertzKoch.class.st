Class {
	#name : #WertzKoch,
	#superclass : #LogoViewBuilder,
	#category : #'Roassal2-Tests-Learning'
}

{ #category : #'as yet unclassified' }
WertzKoch >> onView: v withPen: pen [
	| long |
	long := 280.
	pen
		north;
		location: 10 @ (long / 2 - 5);
		turn: 90;
		down.
	self times: 4 koch: long pen: pen
]

{ #category : #'as yet unclassified' }
WertzKoch >> times: times koch: long pen: pen [
	times = 0
		ifTrue: [ pen go: long ]
		ifFalse: [ self times: times - 1 koch: long / 3 pen: pen.
			pen turn: -60.
			self times: times - 1 koch: long / 3 pen: pen.
			pen turn: 120.
			self times: times - 1 koch: long / 3 pen: pen.
			pen turn: -60.
			self times: times - 1 koch: long / 3 pen: pen ]
]
