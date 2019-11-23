Class {
	#name : #WertzSeashellElegant,
	#superclass : #WertzSeashell,
	#category : #'Roassal2-Tests-Learning'
}

{ #category : #'as yet unclassified' }
WertzSeashellElegant >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	1 to: 200 do: [ :i | 
		pen
			go: i * 0.5;
			turn: 13 ]
]
