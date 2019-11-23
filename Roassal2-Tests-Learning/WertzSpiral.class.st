Class {
	#name : #WertzSpiral,
	#superclass : #LogoViewBuilder,
	#category : #'Roassal2-Tests-Learning'
}

{ #category : #'as yet unclassified' }
WertzSpiral >> onView: v withPen: pen [
	pen
		north;
		location: 0@0;
		down.
	1 to: 50 do: [ :i | 
		pen
			go: 2 * i;
			turn: 89 ]
]
