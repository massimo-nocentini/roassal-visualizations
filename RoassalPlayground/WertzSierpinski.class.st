Class {
	#name : #WertzSierpinski,
	#superclass : #LogoViewBuilder,
	#category : #RoassalPlayground
}

{ #category : #'as yet unclassified' }
WertzSierpinski >> onView: v withPen: pen [
	pen
		north;
		place: 20 @ 290;
		down.
	self sierp: 60 pen: pen
]

{ #category : #'as yet unclassified' }
WertzSierpinski >> sierp: times pen: pen [
	times < 2 ifTrue:[^self].
 3
				timesRepeat: [ self sierp: times / 2 pen: pen.
					pen
						go: times;
						turn: 120 ] 
]
