"
I collect tests and Roassal visualizations about __Regression Trees__.
"
Class {
	#name : #RegressionTreeTest,
	#superclass : #TestCase,
	#category : #'RoassalPlayground-RegressionTrees'
}

{ #category : #'as yet unclassified' }
RegressionTreeTest >> CART [
	<gtExample>
	| v rootElement  initialPopulation |
	initialPopulation := self makePopulationWith: 1000.
	
	rootElement := self shapeBuilder elementOn: initialPopulation.
	v := RTView new.
	v @ RTDraggableView.
	rootElement attributeAt: #splitBounds put: Dictionary new.
	v add: rootElement.
	v attributeAt: #rootElement put: rootElement.
	self registerEventHandlersForElement: rootElement.
	self
		addInteractionsToElement: rootElement
		withPopupDescriptor: [ :_ | self describeModelOfElement: rootElement ].
	RTTreeLayout on: v elements.
	^ v
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> addChild: each ofElement: anElement afterSplitEvent: ev [
	| eachElement bounds valuesOfSplittedFeature halfInterval |
	eachElement := anElement shape elementOn: each.
	anElement view
		add: eachElement;
		add: (self edgeBuilder edgeFrom: anElement to: eachElement).
	RTSelectableElementsContextInteraction new
		presentation: anElement presentation;
		initializeSingleElement: eachElement.
	self registerEventHandlersForElement: eachElement.
	self
		addInteractionsToElement: eachElement
		withPopupDescriptor: [ :_ | self describeModelOfElement: eachElement afterSplitEvent: ev ].
	eachElement translateTo: anElement trachelShape position.
	eachElement parentElement: anElement.
	bounds := (eachElement parentElement attributeAt: #splitBounds) copy.
	valuesOfSplittedFeature := eachElement model
		collectFeature: ev feature.
	halfInterval := eachElement model == ev firstHalf
		ifTrue: [ '<'.
			valuesOfSplittedFeature min to: ev at ]
		ifFalse: [ '>='.
			ev at to: valuesOfSplittedFeature max ].
	bounds
		at: ev feature
		ifPresent:
			[ :anInterval | bounds at: ev feature put: halfInterval <& anInterval ]
		ifAbsentPut: [ halfInterval ].
	eachElement attributeAt: #splitBounds put: bounds
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> addInteractionsToElement: anElement withPopupDescriptor: aBlock [
	^ anElement @ RTDraggableChildren
		@
			(RTHighlightable new
				color: Color gray;
				yourself)
		@
			(RTPopup new
				text: aBlock;
				yourself)
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> describeModelOfElement: anElement [
	| aPopulation percentage SRSS |
	aPopulation := anElement model.
	percentage := aPopulation subjects size
		/ anElement rootElement model subjects size * 100.
	SRSS := (anElement leafElements
		collect: [ :each | each model responseRSS ]) sum.
	^ 'subjects: ' , aPopulation subjects size asString , ' ('
		, percentage asFloat asString , '%)' , String cr , 'mean: '
		, aPopulation responseMean asString , String cr , 'RSS: '
		, aPopulation responseRSS asString , String cr , 'SRSS: '
		, SRSS asString
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> describeModelOfElement: anElement afterSplitEvent: ev [
	| boundsRepr bounds |
	bounds := anElement attributeAt: #splitBounds.
	boundsRepr := String
		streamContents: [ :s | 
			bounds
				keysAndValuesDo: [ :k :v | 
					s
						nextPutAll: String tab;
						nextPutAll: v start asString;
						nextPutAll: ' <= ';
						nextPutAll: k asString;
						nextPutAll: ' < ';
						nextPutAll: v stop asString;
						nextPutAll: String cr;
						yourself ] ].
	^ 'Split of ' , ev feature asString , ' at ' , ev at asString
		, ', bounds:' , String cr , boundsRepr
		, (self describeModelOfElement: anElement)
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> edgeBuilder [
	^ RTEdgeBuilder new shape
		color: Color black;orthoVerticalLine
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
	| subjects rand |
	rand := Random new.
	subjects := LinkedList new.
	1 to: populationSize do: [ :i | 
		| subject |
		subject := Dictionary new
			at: #id put: i;
			at: #x0 put: rand next;
			at: #x1 put: rand next;
			at: #x2 put: rand next;
			at: #x3 put: rand next;
			yourself.
		subject at: #y put: (subject at: #x0) + rand next.
		subjects add: subject ].
	^ Population new
		subjects: subjects;
		response: #y;
		yourself
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> normalizerOnElements: elements [
	^ RTMetricNormalizer new
		elements: elements;
		normalizeHeight: #responseRSS;
		yourself
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> pruneEventHandler: ev withElement: anElement [
	anElement childrenElements do: #removeRecursively.
	anElement view signalUpdate
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> registerEventHandlersForElement: anElement [
	anElement model
		when: SplitEvent
			do: [ :ev | self splitEventHandler: ev withElement: anElement ];
		when: PruneEvent
			do: [ :ev | self pruneEventHandler: ev withElement: anElement ];
		when: SelectEvent
			do: [ :ev | self selectEventHandler: ev withElement: anElement ]
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> selectEventHandler: ev withElement: anElement [
	| elements |
	elements := anElement subtreeElements
		select: ev predicate
		thenCollect: ev selector.
	ev result: (ev collector value: elements)
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> shapeBuilder [
	| color |
	color := RTMultiLinearColor new
		colors: RTPalette c4;
		command: #responseMean;
		yourself.
	^ RTBox new
		width: [ :aPopulation | aPopulation subjects size ];
		borderColor: Color black;
		color: color;
		yourself
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> splitEventHandler: ev withElement: anElement [
	| aView |
	aView := anElement view.
	{ev firstHalf.
	ev secondHalf}
		do: [ :each | self addChild: each ofElement: anElement afterSplitEvent: ev].
	self normalizerOnElements: aView elements.
	self layoutWithTranslator on: aView elements.
	aView signalUpdate
]
