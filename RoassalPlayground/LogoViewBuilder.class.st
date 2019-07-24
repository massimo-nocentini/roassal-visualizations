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
	| v |
	v := RTView new.
	v @ RTDraggableView.
	self
		onView: v
		withPen:
			(RTPenEdgeBuilder new
				view: v;
				yourself).
	v elements do: [ :each | each translateTo: each model ].
	^ v
]
