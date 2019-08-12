Class {
	#name : #WertzLindenmayerBracketedShrub,
	#superclass : #WertzLindenmayerBracketed,
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #'as yet unclassified' }
WertzLindenmayerBracketedShrub >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	self
		axiom: 'X'
		rules: 'X -> F-[[X]+X]+F[+FX]-X. F -> FF.'
		angle: 22.5
		level: 5
		length: 5
		pen: pen
]
