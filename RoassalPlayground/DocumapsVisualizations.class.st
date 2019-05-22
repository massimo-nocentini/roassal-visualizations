"
I collect some examples about Roassal and a few applications of it to real world problems.
"
Class {
	#name : #DocumapsVisualizations,
	#superclass : #Object,
	#category : #RoassalPlayground
}

{ #category : #examples }
DocumapsVisualizations >> addBlockForView: v withShapeBuilder: shape withGetter: attrGetter [
	| block line |
	line := RTShapeBuilder new orthoHorizontalLine.
	block := [ :element :mouseClickHandler | 
	| newElements children |
	children := attrGetter value: element model.
	newElements := shape elementsOn: children.
	newElements @ RTDraggableChildren.
	newElements
		collect: [ :child | 
			child translateTo: element trachelShape position.
			child parentElement: element.
			mouseClickHandler value: child.
			v add: child.
			v add: (line edgeFrom: element to: child).
			child ] ].
	^ block
]

{ #category : #examples }
DocumapsVisualizations >> cleanDownBlockForView: v [
	| block |
	block := nil.	"to quiet the compiler and to prepare for recursion"
	block := [ :element | 
	element outgoingEdges
		do: [ :edge | 
			| child |
			child := edge to.
			block value: child.
			v removeElement: child.
			v removeEdge: edge .
			child] ].
	^ block
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
	<gtExample>
	| v shape cleanDownBlock addBlock boxCtor labelCtor mouseClickHandlerForShrink rootElement |
	"Ctor for elements to be rendered as box shapes"
	boxCtor := [ RTRoundedBox new
		borderRadius: 5;
		borderColor: Color black;
		borderWidth: 0.5;
		yourself ].
	"Joint ctor for attaching a label within each box shape"
	labelCtor := [ RTLabel text: [ :path | path pathSegments last ] ].
	v := RTView new.	"The main view"
	v @ RTDraggableView.	"set some interactions"
	shape := (boxCtor value + labelCtor value) allOfSameSizeWithPadding.
	cleanDownBlock := self cleanDownBlockForView: v.
	addBlock := self
		addBlockForView: v
		withShapeBuilder: shape
		withGetter: attrGetter.
	mouseClickHandlerForShrink := self
		mouseClickHandleBlockForView: v
		withCleanDownBlock: cleanDownBlock
		withAddBlock: addBlock.
	rootElement := shape elementOn: rootObject.
	mouseClickHandlerForShrink value: rootElement.
	v add: rootElement.
	rootElement announce: TRMouseLeftClick new.
	v animations
		do: [ :each | each after: [ v canvas camera focusOnCenterScaled ] ].
	^ v
]

{ #category : #examples }
DocumapsVisualizations >> mouseClickHandleBlockForView: v withCleanDownBlock: cleanDownBlock withAddBlock: addBlock [
	| block translator layout |
	translator := RTSmoothLayoutTranslator new
		nbCycles: 0.2;
		"in seconds"
			yourself.
	layout := RTHorizontalTreeLayout new
		translator: translator;
		yourself.
	block := nil.
	block := [ :element | 
	element
		when: TRMouseLeftClick
			do: [ :ev | 
			ev shiftKeyPressed
				ifTrue: [ cleanDownBlock value: ev shape element ]
				ifFalse: [ addBlock value: ev shape element value: block ].
			layout on: v elements.
			"v canvas camera focusOnCenter."
			v signalUpdate ];
		yourself ].
	^ block
]
