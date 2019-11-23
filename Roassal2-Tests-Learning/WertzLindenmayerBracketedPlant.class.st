Class {
	#name : #WertzLindenmayerBracketedPlant,
	#superclass : #WertzLindenmayerBracketed,
	#category : #'Roassal2-Tests-Learning-Lindenmayer systems'
}

{ #category : #'as yet unclassified' }
WertzLindenmayerBracketedPlant >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	self
		axiom: 'X'
		rules: 'X -> F+[[X]-X]-F[-FX]+X. F -> FF.'
		angle: 25
		level: 7
		length: 5
		pen: pen
]
