Class {
	#name : #WertzTree2,
	#superclass : #LogoViewBuilder,
	#category : #RoassalPlayground
}

{ #category : #'as yet unclassified' }
WertzTree2 >> node: length angle: angle times: times pen: pen [
	times isZero
		ifTrue: [ ^ self ].
	pen turn: 0 - angle.
	self
		tree2a: length
		angle: angle
		times: times - 1
		pen: pen.
	pen turn: 2 * angle.
	self
		tree2b: length
		angle: angle
		times: times - 1
		pen: pen.
	pen turn: 0 - angle
]

{ #category : #'as yet unclassified' }
WertzTree2 >> onView: v withPen: pen [
	self
		tree2: 10
		angle: 20
		times: 7
		pen: pen
]

{ #category : #'as yet unclassified' }
WertzTree2 >> tree2: length angle: angle times: times pen: pen [
	pen north;
		home;
		down.
	pen location: 85 @ 130.
	self
		tree2a: length
		angle: angle
		times: times
		pen: pen
]

{ #category : #'as yet unclassified' }
WertzTree2 >> tree2a: length angle: angle times: times pen: pen [
	pen go: length * 2.
	self node: length angle: angle times: times pen: pen.
	pen go: -2 * length
]

{ #category : #'as yet unclassified' }
WertzTree2 >> tree2b: length angle: angle times: times pen: pen [
	pen go: length.
	self node: length angle: angle times: times pen: pen.
	pen go: 0 - length
]
