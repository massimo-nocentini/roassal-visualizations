Class {
	#name : #WertzSierpinskiCurve,
	#superclass : #LogoViewBuilder,
	#category : #'Roassal2-Tests-Learning'
}

{ #category : #'as yet unclassified' }
WertzSierpinskiCurve >> onView: v withPen: pen [
	pen
		north;
		down.
	self times: 6 line: 12 pen: pen
]

{ #category : #'as yet unclassified' }
WertzSierpinskiCurve >> times: times left: long pen: pen [
times > 0
         ifTrue: [self times: times - 1 right: long pen: pen.
            pen go: long;
                turn: -60.
            self times: times - 1 left: long pen: pen.
            pen go: long;
                turn: -60.
            self times: times - 1 right: long pen: pen]

]

{ #category : #'as yet unclassified' }
WertzSierpinskiCurve >> times: times line: long pen: pen [
	pen
		location:
			(times odd
				ifTrue: [ 290 ]
				ifFalse: [ 10 ]) @ 290.
	"times odd
		ifTrue: [ pen turn: -30 ].
	self times: times left: long pen: pen."
	times odd
		ifTrue: [ pen turn: -30.
			self times: times left: long pen: pen ]
		ifFalse: [ pen turn: 90.
			self times: times right: long pen: pen ].

	pen go: long
]

{ #category : #'as yet unclassified' }
WertzSierpinskiCurve >> times: times right: long pen: pen [

times > 0
         ifTrue: [self times: times - 1 left: long pen: pen.
            pen go: long;
                turn: 60.
            self times: times- 1 right: long pen: pen.
            pen go: long;
                turn: 60.
            self times: times- 1 left: long pen: pen]
]
