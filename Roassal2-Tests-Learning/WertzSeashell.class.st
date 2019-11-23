Class {
	#name : #WertzSeashell,
	#superclass : #LogoViewBuilder,
	#category : #'Roassal2-Tests-Learning'
}

{ #category : #'as yet unclassified' }
WertzSeashell >> onView: v withPen: pen [
	| dist |
	pen
		north;
		location: 60 @ 90;
		down.
	dist := 1.2.
	200
		timesRepeat: [ pen
				go: (dist := dist * 1.03);
				turn: 13 ]
]
