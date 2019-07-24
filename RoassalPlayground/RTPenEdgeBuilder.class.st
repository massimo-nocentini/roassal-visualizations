Class {
	#name : #RTPenEdgeBuilder,
	#superclass : #RTEdgeBuilder,
	#instVars : [
		'location',
		'direction',
		'penDown',
		'vertices',
		'vertexShape'
	],
	#category : #RoassalPlayground
}

{ #category : #heads }
RTPenEdgeBuilder >> direction [
	"Answer the receiver's current direction. 0 is towards the top of the
	screen."

	^ direction
]

{ #category : #heads }
RTPenEdgeBuilder >> down [
	"Set the state of the receiver's pen to down (drawing)."

	penDown := true
]

{ #category : #heads }
RTPenEdgeBuilder >> go: distance [
	"Move the pen in its current direction a number of bits equal to the 
	argument, distance. If the pen is down, a line will be drawn using the 
	receiver's form source as the shape of the drawing brush."

	self
		goto: direction degreeCos @ direction degreeSin * distance + location
]

{ #category : #heads }
RTPenEdgeBuilder >> goto: aPoint [
	"Move the receiver to position aPoint. If the pen is down, a line will be 
	drawn from the current position to the new one using the receiver's 
	form source as the shape of the drawing brush. The receiver's set 
	direction does not change."

	| old from to|
	old := location.
	location := aPoint.
	penDown
		ifFalse:[^self].
			
			from := old rounded.
			to := location rounded.
			(vertices includes: from)
				ifFalse: [ vertices add: from.
					view add: (vertexShape elementOn: from) ].
			(vertices includes: to)
				ifFalse: [ vertices add: to.
					view add: (vertexShape elementOn: to) ].
			view addEdge: (self connectFrom: from to: to) 
			
		 "NOTE:  This should be changed so it does NOT draw the first point, so as
	not to overstrike at line junctions.  At the same time, place should draw
	a single dot if the pen is down, as should down (put-pen-down) if it
	was not down before."
			
]

{ #category : #heads }
RTPenEdgeBuilder >> home [
	"Place the receiver at the center of its frame."

	location := view canvas morph ifNil: [ 0@0 ]
		ifNotNil: [ :morph | morph bounds center ]
]

{ #category : #heads }
RTPenEdgeBuilder >> initialize [
	super initialize.
	vertexShape := RTEllipse new
		size: 1;
		yourself.
		vertices := Set new.
]

{ #category : #heads }
RTPenEdgeBuilder >> location [
	"Answer where the receiver is currently located."

	^ location
]

{ #category : #heads }
RTPenEdgeBuilder >> north [
	"Set the receiver's direction to facing toward the top of the display screen."

	direction := 270
]

{ #category : #heads }
RTPenEdgeBuilder >> place: aPoint [
	"Set the receiver at position aPoint. No lines are drawn."

	location := aPoint
]

{ #category : #heads }
RTPenEdgeBuilder >> turn: degrees [
	"Change the direction that the receiver faces by an amount equal to the 
	argument, degrees."

	direction := direction + degrees
]

{ #category : #heads }
RTPenEdgeBuilder >> up [
	"Set the state of the receiver's pen to up (no drawing)."

	penDown := false
]
