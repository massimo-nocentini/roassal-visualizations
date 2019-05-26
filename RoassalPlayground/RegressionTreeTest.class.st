"
I collect tests and Roassal visualizations about __Regression Trees__.
"
Class {
	#name : #RegressionTreeTest,
	#superclass : #TestCase,
	#category : #RoassalPlayground
}

{ #category : #'as yet unclassified' }
RegressionTreeTest >> CART [
	<gtExample>
	| v rootElement shapeBuilder initialPopulation |
	shapeBuilder := self shapeBuilder.
	v := RTView new.
	v @ RTDraggableView.
	initialPopulation := self makePopulationWith: 1000.
	rootElement := shapeBuilder elementOn: initialPopulation.
	v add: rootElement.
	v attributeAt: #rootElement put: rootElement.
	self
		registerEventHandlersForElement: rootElement;
		addInteractionsToElement: rootElement.
	RTTreeLayout on: v elements.
	^ v
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> addChild: each ofElement: anElement [
	| eachElement |
	eachElement := anElement shape elementOn: each.
	anElement view
		add: eachElement;
		add: (self edgeBuilder edgeFrom: anElement to: eachElement).
	RTSelectableElementsContextInteraction new
		presentation: anElement presentation;
		initializeSingleElement: eachElement.
	self registerEventHandlersForElement: eachElement.
	self addInteractionsToElement: eachElement.
	
	eachElement translateTo: anElement trachelShape position.
	eachElement parentElement: anElement
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> addInteractionsToElement: anElement [
	| popupBlock |
	popupBlock := [ :aPopulation | 
	'subjects: ' , aPopulation subjects size asString , String cr
		, 'mean: ' , (aPopulation mean: #y) asString ].
	^ anElement @ RTDraggableChildren
		@
			(RTPopup new
				text: popupBlock;
				yourself)
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> edgeBuilder [ 
 ^ RTEdgeBuilder new shape orthoVerticalLine.
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> growEventHandler: ev withElement: anElement [
	| aLeafElement aFeature aSplitValue |
	aLeafElement := anElement leafElements atRandom.
	aFeature := aLeafElement model subjects first keys atRandom.
	aSplitValue := (aLeafElement model collectFeature: aFeature)
		atRandomBounded.
	aLeafElement model splitFeature: aFeature at: aSplitValue
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> layout [ 
 ^ RTTreeLayout new
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> layoutWithTranslator [
	^ self layout translator:
			(RTSmoothLayoutTranslator new
				nbCycles: 0.3;
				"in seconds"
					yourself); yourself
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> makePopulationWith: populationSize [
	| population rand |
	rand := Random new.
	population := LinkedList new.
	1 to: populationSize do: [ :i | 
		| subject |
		subject := Dictionary new
			at: #id put: i;
			at: #x0 put: rand next;
			at: #x1 put: rand next;
			at: #x2 put: rand next;
			at: #x3 put: rand next;
			at: #y put: rand next;
			yourself.
		population add: subject ].
	^ Population withAll: population
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> pruneEventHandler: ev withElement: anElement [
	| removeBlock candidateElements |
	candidateElements := ev predicate
		ifNil: [ anElement childrenElements ]
		ifNotNil: [ | satisfying |
			satisfying := anElement withAllConnectedElements
				select: ev predicate.
			satisfying
				ifEmpty: [ Array new ]
				ifNotEmpty: [ | randomElement |
					randomElement := satisfying atRandom.
					(randomElement parentElement
						ifNil: [ randomElement ])childrenElements ]  ].
	removeBlock := nil.
	removeBlock := [ :element | 
	element childrenElements do: removeBlock.
	element remove ].
	candidateElements do: removeBlock.
	anElement view signalUpdate
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> registerEventHandlersForElement: anElement [
	anElement model
		when: SplitEvent
			do: [ :ev | self splitEventHandler: ev withElement: anElement ];
		when: GrowEvent
			do: [ :ev | self growEventHandler: ev withElement: anElement ];
		when: PruneEvent
			do: [ :ev | self pruneEventHandler: ev withElement: anElement ]
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> shapeBuilder [
	^ RTBox new
		width: [ :aPopulation | aPopulation subjects size ];
			borderColor: Color black;
		yourself
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> splitEventHandler: ev withElement: anElement [
	| aView |
	aView := anElement view.
	{ev firstHalf.
	ev secondHalf}
		do: [ :each | self addChild: each ofElement: anElement ].
	RTMetricNormalizer new
		elements: aView elements;
		normalizeHeight: [ :aPopulation | aPopulation mean: #y ].
	self layoutWithTranslator on: aView elements.
	aView signalUpdate
]
