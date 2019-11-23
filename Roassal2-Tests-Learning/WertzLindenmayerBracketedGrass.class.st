Class {
	#name : #WertzLindenmayerBracketedGrass,
	#superclass : #WertzLindenmayerBracketed,
	#category : #'Roassal2-Tests-Learning-Lindenmayer systems'
}

{ #category : #'as yet unclassified' }
WertzLindenmayerBracketedGrass >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	self
		axiom: 'F'
		rules: 'F -> F[+F]F[-F]F.'
		angle: 25.7
		level: 5
		length: 5
		pen: pen
]
