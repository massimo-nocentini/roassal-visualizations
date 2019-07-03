"
I represent a container for a fractal tree visualization.

Take care of clicking on the canvas if the methods are ran via the TestRunner green button on their left, otherwise the Display objects will free and the *only* rescue procedure is to kill the image process and restart it, loosing unsaved changes.
"
Class {
	#name : #FractalTreeTest,
	#superclass : #TestCase,
	#category : #RoassalPlayground
}

{ #category : #'as yet unclassified' }
FractalTreeTest >> testFractalTreeDrawing [
	"The following drawing has been reproduced from:
	https://ericclack.blogspot.com/2014/03/smalltalk-fractal-trees.html"
	Display
		restoreAfter: [ Display fillWhite.
			self tree: 700 @ 700 length: 200 angle: 0 ]
]

{ #category : #'as yet unclassified' }
FractalTreeTest >> testSimpleLineWithLabelDrawing [
	Display
		restoreAfter: [ | myPen |
			Display fillWhite.
			myPen := Pen new.	"get graphic pen"
			myPen squareNib: 1.
			myPen color: Color blue.	"set pen color"
			myPen home.	"position pen at center of display"
			myPen up.	"makes nib unable to draw"
			myPen down.	"enable the nib to draw"
			myPen north.	"points direction towards top"
			myPen turn: -180.	"add specified degrees to direction"
			myPen direction.	"get current angle of pen"
			myPen go: 50.	"move pen specified number of pixels"
			myPen location.	"get the pen position"
			myPen goto: 200 @ 200.	"move to specified point"
			myPen place: 250 @ 250.	"move to specified point without drawing"
			myPen print: 'Hello World' withFont: (TextStyle default fontAt: 1).
			Display extent.	"get display width@height"
			Display width.	"get display width"
			Display height	"get display height" ]
]

{ #category : #'as yet unclassified' }
FractalTreeTest >> tree: aPoint length: aLength angle: anAngle [
	| p a thiner random |
	aLength > 10
		ifFalse: [ ^ self ].
	thiner := false.
	random := true.
	p := Pen new.
	p up.
	thiner
		ifTrue: [ p squareNib: aLength / 25 ].
	p goto: aPoint.
	p turn: anAngle.
	p down.
	5
		timesRepeat: [ p go: aLength / 5.
			p turn: 5 ].
	a := anAngle - 30.
	3
		timesRepeat: [ self tree: p location length: aLength * 0.7 angle: a.
			a := a + 30+ (random ifTrue: [20 atRandom ] ifFalse:[0])].
]
