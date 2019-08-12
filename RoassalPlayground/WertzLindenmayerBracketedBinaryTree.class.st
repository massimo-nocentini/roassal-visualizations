Class {
	#name : #WertzLindenmayerBracketedBinaryTree,
	#superclass : #WertzLindenmayerBracketed,
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #'as yet unclassified' }
WertzLindenmayerBracketedBinaryTree >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	self
		axiom: 'X'
		rules: 'F -> FF. X -> F[+X-]X.'
		angle: 45
		level: 10
		length: 5
		pen: pen
]
