Class {
	#name : #WertzSpiral,
	#superclass : #LogoViewBuilder,
	#category : #RoassalPlayground
}

{ #category : #'as yet unclassified' }
WertzSpiral >> onView: v withPen: pen [
	pen
		north;
		place: 0@0;
		down.
	1 to: 50 do: [ :i | 
		pen
			go: 2 * i;
			turn: 89 ]
]
