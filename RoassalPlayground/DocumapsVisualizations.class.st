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
	| newElements children |
	element model folded
		ifFalse: [ ^ element ].
	children := attrGetter value: element model.
	newElements := element shape elementsOn: children.
	newElements @ RTDraggableChildren.
	newElements
		do: [ :child | 
			child translateTo: element trachelShape position.
			child parentElement: element.
			self
				registerMouseClickHandlerForElement: child
				withGetter: attrGetter.
			element view
				add: child;
				add: (RTShapeBuilder new orthoHorizontalLine edgeFrom: element to: child) ].
	element model folded: false.
	^ newElements
]

{ #category : #examples }
DocumapsVisualizations >> cleanDownForElement: element [
	element outgoingEdges
		do:
			[ :edge | 
			| child |
			child := edge to.
			self cleanDownForElement: child.
			element view
				removeElement: child;
				removeEdge: edge ]. element model
		folded: true
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
DocumapsVisualizations >> expandeableTreeViewFor: rootObject using: attrGetter [
	| ctor |
	ctor := [ :v | 
	FoldableDecoration new
		obj: v;
		folded: true;
		yourself ].
	^ self
		expandeableTreeViewFor: (ctor value: rootObject)
		using: [ :each | (attrGetter value: each obj) collect: ctor ]
		uptoDepth: 3
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
					self addElement: each withGetter: attrGetter;
					
						exploreElements: (each outgoingEdges collect: #to)
						atDepth: d - 1
						withGetter: attrGetter ] ]
]

{ #category : #examples }
DocumapsVisualizations >> layout [
	
	^ RTHorizontalTreeLayout new
	
]

{ #category : #examples }
DocumapsVisualizations >> registerMouseClickHandlerForElement: element withGetter: attrGetter [
	| layout |
	layout := self layout
		translator:
			(RTSmoothLayoutTranslator new
				nbCycles: 0.2;
				"in seconds"
					yourself);
		yourself.	"add translator to beautify the viz"
	element
		when: TRMouseLeftClick
		do: [ :ev | 
			ev shiftKeyPressed
				ifTrue: [ self cleanDownForElement: element ]
				ifFalse: [ self addElement: element withGetter: attrGetter ].
			layout on: element view elements .element view signalUpdate ].
	^ element
]

{ #category : #examples }
DocumapsVisualizations >> shapeBuilder [
	| box label |
	box := RTRoundedBox new
		borderRadius: 5;
		borderColor: Color black;
		borderWidth: 0.5;
		yourself.
	label := RTLabel text: [ :path | path  obj pathSegments last ].
	^ (box + label) allOfSameSizeWithPadding
]
