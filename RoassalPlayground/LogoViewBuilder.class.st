Class {
	#name : #LogoViewBuilder,
	#superclass : #Object,
	#category : #RoassalPlayground
}

{ #category : #'as yet unclassified' }
LogoViewBuilder >> onView: v withPen: pen [
self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
LogoViewBuilder >> view [
	| v eb |
	v := RTView new.
	v @ RTDraggableView.
	eb := RTPenEdgeBuilder new
		view: v;
		yourself.
	eb shape line color: (Color black alpha: 1 / 2).
	self onView: v withPen: eb.
	eb buildOnView: v withShape: (RTEllipse new size:1 ; yourself).
	^ v
]
