Class {
	#name : #WertzLindenmayerBracketedPlant,
	#superclass : #WertzLindenmayerBracketed,
	#category : #'RoassalPlayground-Lindenmayer systems'
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
