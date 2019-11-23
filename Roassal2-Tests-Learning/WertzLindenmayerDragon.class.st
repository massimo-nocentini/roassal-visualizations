Class {
	#name : #WertzLindenmayerDragon,
	#superclass : #WertzLindenmayer,
	#category : #'Roassal2-Tests-Learning-Lindenmayer systems'
}

{ #category : #'as yet unclassified' }
WertzLindenmayerDragon >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	self
		axiom: 'FX'
		rules: 'X -> X+YF+. Y -> -FX-Y.'
		angle: 90
		level: 15
		length: 5
		pen: pen
]
