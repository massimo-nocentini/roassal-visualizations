Class {
	#name : #WertzTree1,
	#superclass : #LogoViewBuilder,
	#category : #'Roassal2-Tests-Learning'
}

{ #category : #'as yet unclassified' }
WertzTree1 >> onView: v withPen: pen [
	self
		tree1: 80
		times: 8
		pen: pen
]

{ #category : #'as yet unclassified' }
WertzTree1 >> tree1: length times: n pen: pen [
	pen north;
		home;
		down.
	pen location: 75 @ 130.
	self tree1a: length pen: pen times: n
]

{ #category : #'as yet unclassified' }
WertzTree1 >> tree1a: length pen: pen times: n [
	n <= 0
		ifTrue: [ ^ self ].
	pen
		go: length;
		turn: -45.
	self tree1a: length / 2 pen: pen times: n - 1.
	pen turn: 90.
	self tree1a: length / 2 pen: pen times: n - 1.
	pen
		turn: -45;
		go: 0 - length
]
