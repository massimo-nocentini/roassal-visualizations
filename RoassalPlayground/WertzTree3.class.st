Class {
	#name : #WertzTree3,
	#superclass : #LogoViewBuilder,
	#instVars : [
		'times',
		'angleLeft',
		'angleRight'
	],
	#category : #RoassalPlayground
}

{ #category : #accessing }
WertzTree3 >> angleLeft [
	^ angleLeft
]

{ #category : #accessing }
WertzTree3 >> angleLeft: anObject [
	angleLeft := anObject
]

{ #category : #accessing }
WertzTree3 >> angleRight [
	^ angleRight
]

{ #category : #accessing }
WertzTree3 >> angleRight: anObject [
	angleRight := anObject
]

{ #category : #'as yet unclassified' }
WertzTree3 >> drawBranch: length times: times angleLeft: angleLeft angleRight: angleRight ind: ind pen: pen [
	pen go: length.
	self
		node:
			(ind
				ifTrue: [ length / 2 ]
				ifFalse: [ length ])
		times: times
		angleLeft: angleLeft angleRight: angleRight
		pen: pen.
	pen go: 0 - length
]

{ #category : #'as yet unclassified' }
WertzTree3 >> node: length times: times angleLeft: angleLeft angleRight: angleRight pen: pen [
	times = 0
		ifTrue: [ ^ self ].
	pen turn: 0 - angleLeft.
	self
		drawBranch: 2 * length
		times: times - 1
		angleLeft: angleLeft
		angleRight: angleRight
		ind: true
		pen: pen.
	pen turn: angleLeft;
	turn: angleRight.
	self
		drawBranch: length
		times: times - 1
		angleLeft: angleLeft
		angleRight: angleRight
		ind: false
		pen: pen.
	pen turn: 0 - angleRight
]

{ #category : #'as yet unclassified' }
WertzTree3 >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	self
		node: 10
		times: self times
		angleLeft: self angleLeft
		angleRight: self angleRight
		pen: pen
]

{ #category : #accessing }
WertzTree3 >> times [
	^ times
]

{ #category : #accessing }
WertzTree3 >> times: anObject [
	times := anObject
]
