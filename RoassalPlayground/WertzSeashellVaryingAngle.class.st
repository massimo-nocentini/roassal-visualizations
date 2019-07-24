Class {
	#name : #WertzSeashellVaryingAngle,
	#superclass : #WertzSeashellElegant,
	#category : #RoassalPlayground
}

{ #category : #'as yet unclassified' }
WertzSeashellVaryingAngle >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	1 to: 200 do: [ :i | 
		pen
			go: 5.5;
			turn: i * 0.25 ]
]
