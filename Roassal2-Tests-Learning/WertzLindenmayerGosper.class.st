Class {
	#name : #WertzLindenmayerGosper,
	#superclass : #WertzLindenmayer,
	#category : #'Roassal2-Tests-Learning-Lindenmayer systems'
}

{ #category : #'as yet unclassified' }
WertzLindenmayerGosper >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	self
		axiom: 'XF'
		rules: 'X -> X+YF++YF-FX--FXFX-YF+. Y -> -FX+YFYF++YF+FX--FX-Y.'
		angle: 60
		level: 4
		length: 5
		pen: pen
]
