Class {
	#name : #RTPenEdgeBuilder,
	#superclass : #RTEdgeBuilder,
	#instVars : [
		'location',
		'direction',
		'penDown',
		'vertices',
		'vertexShape',
		'edges'
	],
	#category : #'Roassal2-Tests-Learning'
}

{ #category : #heads }
RTPenEdgeBuilder >> buildOnView: v withShape: shape [
	v addAll: (shape elementsOn: vertices).
	v elements do: [ :each | each translateTo: each model ].
	self useAssociations: edges.
"	edges do: [ :assoc | self connectFrom: assoc key to: assoc value ]"
]

{ #category : #heads }
RTPenEdgeBuilder >> direction [
	"Answer the receiver's current direction. 0 is towards the top of the
	screen."

	^ direction
]

{ #category : #heads }
RTPenEdgeBuilder >> direction: aDirection [

	 direction:=aDirection 
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

	| old from to |
	old := location.
	location := aPoint.
	penDown
		ifFalse: [ ^ self ].
	from := old rounded.
	to := location rounded.
	vertices
		add: from;
		add: to.
	edges add: from -> to
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
	edges := Set new.
]

{ #category : #heads }
RTPenEdgeBuilder >> isDown [
	^ penDown 
]

{ #category : #heads }
RTPenEdgeBuilder >> location [
	"Answer where the receiver is currently located."

	^ location
]

{ #category : #heads }
RTPenEdgeBuilder >> location: aPoint [
	"Set the receiver at position aPoint. No lines are drawn."

	location := aPoint
]

{ #category : #heads }
RTPenEdgeBuilder >> north [
	"Set the receiver's direction to facing toward the top of the display screen."

	direction := 270
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
