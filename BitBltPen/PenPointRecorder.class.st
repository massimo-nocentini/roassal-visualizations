"
This class is a special kind of Pen that instead of actually drawing lines records the destination points for those lines. These points can later be accessed through my accessing method #points.

This can be useful when determining the boundaries of a drawing session.

Example:

| pen |
pen _ PenPointRecorder new.
pen up; goto: 100@100; down; goto: 120@120.
Transcript cr;
	show: 'Bounding box for drawing: ';
	show: (Rectangle encompassing: pen points)

Implementation note: Shouldn't we override #drawFrom:to:withFirstPoint: instead, and what about #drawLoopX:Y:? Aren't we missing those calls?
"
Class {
	#name : #PenPointRecorder,
	#superclass : #Pen,
	#instVars : [
		'points'
	],
	#category : #BitBltPen
}

{ #category : #'line drawing' }
PenPointRecorder >> drawFrom: p1 to: p2 [ 
	"Overridden to skip drawing but track bounds of the region traversed."
	points ifNil: [ points := OrderedCollection with: p1 ].
	points addLast: p2
]

{ #category : #accessing }
PenPointRecorder >> points [
	^ points
]
