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
	| v eb rootElement shapeBuilder initialPopulation |
	shapeBuilder := self shapeBuilder.
	v := RTView new.
	v @ RTDraggableView.
	initialPopulation := self makePopulationWith: 1000.
	rootElement := shapeBuilder elementOn: initialPopulation.
	v add: rootElement.
	self registerEventHandlersForElement: rootElement.
	rootElement @ RTDraggableChildren @ RTPopup.
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
			eachElement @ RTDraggableChildren.
			eachElement translateTo: anElement trachelShape position.
			eachElement parentElement: anElement
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> edgeBuilder [ 
 ^ RTEdgeBuilder new shape orthoVerticalLine.
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> layout [ 
 ^ RTTreeLayout new
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
RegressionTreeTest >> registerEventHandlersForElement: anElement [
	
	anElement model
		when: SplitEvent
		do: [ :ev | self splitEventHandler: ev withElement: anElement ]
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> shapeBuilder [ 
^ RTBox new
		height: [ :aPopulation | aPopulation subjects size ];
		width:
				[ :aPopulation | (aPopulation subjects collect: [ :each | each at: #y ]) average ];
		borderColor: Color black;
		yourself.
]

{ #category : #'as yet unclassified' }
RegressionTreeTest >> splitEventHandler: ev withElement: anElement [
	| aView layout |
	aView := anElement view.
	layout := self layout
		translator:
			(RTSmoothLayoutTranslator new
				nbCycles: 0.3;
				"in seconds"
					yourself);
		yourself.
	{ev firstHalf.
	ev secondHalf}
		do: [ :each | self addChild: each ofElement: anElement ].
	layout on: aView elements.
	aView signalUpdate
]
