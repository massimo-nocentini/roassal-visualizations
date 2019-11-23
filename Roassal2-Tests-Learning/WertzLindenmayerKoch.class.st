Class {
	#name : #WertzLindenmayerKoch,
	#superclass : #WertzLindenmayer,
	#category : #'Roassal2-Tests-Learning-Lindenmayer systems'
}

{ #category : #'as yet unclassified' }
WertzLindenmayerKoch >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	self
		axiom: 'F'
		rules: 'F -> F+F-F-F+F.'
		angle: 90
		level: 5
		length: 5
		pen: pen
]
