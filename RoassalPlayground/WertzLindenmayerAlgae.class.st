Class {
	#name : #WertzLindenmayerAlgae,
	#superclass : #WertzLindenmayer,
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #'as yet unclassified' }
WertzLindenmayerAlgae >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	self
		axiom: 'F'
		rules: 'F -> F+B. B -> F+.'
		angle: 90
		level: 20
		length: 10
		pen: pen
]
