Class {
	#name : #WertzLindenmayerBracketedAnotherShrub,
	#superclass : #WertzLindenmayerBracketed,
	#category : #'Roassal2-Tests-Learning-Lindenmayer systems'
}

{ #category : #'as yet unclassified' }
WertzLindenmayerBracketedAnotherShrub >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	self
		axiom: 'F'
		rules: 'F -> FF+[+F-F-F]-[-F+F+F].'
		angle: 22.5
		level: 4
		length: 5
		pen: pen
]
