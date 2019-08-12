Class {
	#name : #WertzLindenmayerSierpinski,
	#superclass : #WertzLindenmayer,
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #'as yet unclassified' }
WertzLindenmayerSierpinski >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	self
		axiom: 'FXF--FF--FF'
		rules: 'F -> FF. X -> --FXF++FXF++FXF--.'
		angle: 60
		level: 5
		length: 5
		pen: pen
]
