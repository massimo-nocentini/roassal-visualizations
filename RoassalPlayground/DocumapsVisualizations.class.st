"
I collect some examples about Roassal and a few applications of it to real world problems.
"
Class {
	#name : #DocumapsVisualizations,
	#superclass : #Object,
	#category : #RoassalPlayground
}

{ #category : #examples }
DocumapsVisualizations >> addElement: element withGetter: attrGetter [
	^ element folded
		ifTrue: [ self unfoldElement: element withGetter: attrGetter ]
		ifFalse: [ element childrenElements  ]
]

{ #category : #examples }
DocumapsVisualizations >> cleanDownForElement: element [
	element outgoingEdges
		do: [ :edge | 
			| child |
			child := edge to.
			self cleanDownForElement: child.
			child translateTo: child parentElement trachelShape position.
			element view
				removeElement: child;
				removeEdge: edge ].
	element folded: true
]

{ #category : #examples }
DocumapsVisualizations >> documaps [
	<gtExample>
	^ self
		expandeableTreeViewFor:
			'/Users/mn/Developer/working-copies/logics/mk/microkanrenst/'
				asFileReference
		using: [ :fileReference | fileReference isDirectory ifTrue:[fileReference children ] ifFalse:[{}]].
]

{ #category : #examples }
DocumapsVisualizations >> edgeBuilder [
 ^ RTShapeBuilder new orthoHorizontalLine
]

{ #category : #examples }
DocumapsVisualizations >> expandeableTreeViewFor: rootObject using: attrGetter [
	^ self
		expandeableTreeViewFor: rootObject
		using: attrGetter
		uptoDepth: 2
]

{ #category : #examples }
DocumapsVisualizations >> expandeableTreeViewFor: rootObject using: attrGetter uptoDepth: depth [
	| v shape rootElement |
	shape := self shapeBuilder.
	v := RTView new.
	v @ RTDraggableView.
	rootElement := shape elementOn: rootObject.
	v add: rootElement.
	self
		registerMouseClickHandlerForElement: rootElement
		withGetter: attrGetter.
	self
		exploreElements: {rootElement}
		atDepth: depth
		withGetter: attrGetter.
	self layout on: v elements.
	"v canvas camera focusOnCenter."
	^ v
]

{ #category : #examples }
DocumapsVisualizations >> exploreElements: elements atDepth: d withGetter: attrGetter [
	d > 0
		ifTrue: [ elements
				do: [ :each | 
					self
						addElement: each withGetter: attrGetter;
						exploreElements: each childrenElements
							atDepth: d - 1
							withGetter: attrGetter ] ]
]

{ #category : #examples }
DocumapsVisualizations >> layout [
	
	^ RTHorizontalTreeLayout new
	
]

{ #category : #examples }
DocumapsVisualizations >> mouseLeftClickHandlerForEvent: ev withGetter: attrGetter [
	| layout |
	layout := self layout
		translator:
			(RTSmoothLayoutTranslator new
				nbCycles: 0.3;
				"in seconds"
					yourself);
		yourself.
	ev shiftKeyPressed
		ifTrue: [ self cleanDownForElement: ev element ]
		ifFalse: [ self addElement: ev element withGetter: attrGetter ].
	layout on: ev element view elements.
	ev element view signalUpdate
]

{ #category : #examples }
DocumapsVisualizations >> registerMouseClickHandlerForElement: element withGetter: attrGetter [
	element
		when: TRMouseLeftClick
		do:
			[ :ev | self mouseLeftClickHandlerForEvent: ev withGetter: attrGetter ].
	
]

{ #category : #examples }
DocumapsVisualizations >> shapeBuilder [
	| box label |
	box := RTRoundedBox new
		borderRadius: 5;
		borderColor: Color black;
		borderWidth: 0.5;
		yourself.
	label := RTLabel text: [ :path | path  pathSegments last ].
	^ (box + label) allOfSameSizeWithPadding
]

{ #category : #examples }
DocumapsVisualizations >> unfoldElement: element withGetter: attrGetter [
	| children elements |
	children := attrGetter value: element model.
	elements := element shape elementsOn: children.
	elements @ RTDraggableChildren.
	elements
		do: [ :child | 
			child translateTo: element trachelShape position.
			child parentElement: element.
			self
				registerMouseClickHandlerForElement: child
				withGetter: attrGetter.
			element view
				add: child;
				add: (self edgeBuilder edgeFrom: element to: child) ].
	element folded: false.
	^ elements
]
