Class {
	#name : #WertzPolygon,
	#superclass : #LogoViewBuilder,
	#category : #'Roassal2-Tests-Learning'
}

{ #category : #'as yet unclassified' }
WertzPolygon >> angle: angle polygon: long pen: pen [
|total|
total := 0.
pen location: long  / ((360/angle) )
                    @ (long * ((360/angle) / 2 ) - 10).
      [pen go: long; turn: angle.
       ((total := total + angle) \\ 360) = 0] whileFalse.
]

{ #category : #'as yet unclassified' }
WertzPolygon >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	self angle: 102 polygon: 200 pen: pen
]
