Class {
	#name : #Population,
	#superclass : #Announcer,
	#instVars : [
		'subjects',
		'response'
	],
	#classInstVars : [
		'subjects'
	],
	#category : #'RoassalPlayground-RegressionTrees'
}

{ #category : #accessing }
Population >> RSS: aFeature [
	|avg|
	avg := self meanOf:aFeature .
	^ ((self collectFeature: aFeature) collect:[:each | (each - avg) ** 2]) sum
]

{ #category : #'as yet unclassified' }
Population >> cartesianProductOfFeaturesAndValues [
	| wrappedPopulation |
	wrappedPopulation := Dictionary new
		at: #model put: self;
		at: #exploredDuringGrow put: false;
		yourself.
	^ self features
		flatCollect: [ :aFeature | 
			(self collectFeature: aFeature)
				collect: [ :aValue | 
					{aFeature.
					aValue.
					wrappedPopulation} ] ]
]

{ #category : #accessing }
Population >> collectFeature: aKey [
 ^  subjects collect: [ :each | each at: aKey ]
]

{ #category : #accessing }
Population >> features [
	^ subjects first keys \ {#id . response}
]

{ #category : #'as yet unclassified' }
Population >> growerOnHeap: heap usingWeight: weightBlock [
	[ heap isNotEmpty and: [(heap removeFirst key
		unpackOnBlock: [ :f :v :p | 
			"discard its ranking which is the response of #value"
			(p at: #exploredDuringGrow)
				ifTrue: [ true	"keep removing elements" ]
				ifFalse: [ p at: #exploredDuringGrow put: true.
					(p at: #model)
						splitFeature: f
						at: v
						thenArgMin: weightBlock
						usingHeap: heap.
					false ] ])  ] ] whileTrue
]

{ #category : #accessing }
Population >> meanOf: aFeature [
 ^ (self collectFeature: aFeature) average
]

{ #category : #'as yet unclassified' }
Population >> optimizedGrow [
	| aSelectEvent weightBlock heap |
	weightBlock := [ :f :v :p | 
	(p at: #model)
		splitFeature: f
		at: v
		with: [ :l :g | l weightFunction: g wrt: #responseRSS ] ].
	aSelectEvent := self
		subtreeSelect: #isLeaf
		then: [ :populations | 
			populations
				argMin: #cartesianProductOfFeaturesAndValues
				function: weightBlock ].
	heap := aSelectEvent result copy.
	^ [ heap isNotEmpty
		ifTrue: [ self growerOnHeap: heap usingWeight: weightBlock ] ]
]

{ #category : #move }
Population >> prune [
	self announce: PruneEvent new
]

{ #category : #accessing }
Population >> response: aString [ 
	response := aString
]

{ #category : #accessing }
Population >> responseMean [
	^ self meanOf: response
]

{ #category : #accessing }
Population >> responseRSS [
	^ self RSS: response
]

{ #category : #moves }
Population >> splitFeature: aString at: aNumber [
	^ self
		splitFeature: aString
		at: aNumber
		with: [ :lessThanPopulation :greaterThanPopulation | 
			self
				announce:
					(SplitEvent new
						feature: aString;
						at: aNumber;
						firstHalf: lessThanPopulation;
						secondHalf: greaterThanPopulation;
						yourself) ]
]

{ #category : #accessing }
Population >> splitFeature: f at: v thenArgMin: weightBlock usingHeap: heap [
	| splitEvent newPopulations |
					splitEvent := self splitFeature: f at: v.
					newPopulations := Array
						with: splitEvent firstHalf
						with: splitEvent secondHalf.
					newPopulations
						arg: #cartesianProductOfFeaturesAndValues
						function: weightBlock
						using: heap.
]

{ #category : #moves }
Population >> splitFeature: aString at: aNumber with: aReceiver [
	| sat noSat |
	sat := LinkedList new.
	noSat := LinkedList new.
	subjects
		do: [ :each | 
			(each at: aString) < aNumber
				ifTrue: [ sat add: each ]
				ifFalse: [ noSat add: each ] ].
	^ aReceiver
		value: (Population new response: response; subjects: sat; yourself)
		value: (Population new response: response; subjects:  noSat; yourself)
]

{ #category : #accessing }
Population >> subjects [
	^ subjects
]

{ #category : #accessing }
Population >> subjects: aCollection [ 
	subjects := aCollection
]

{ #category : #announcing }
Population >> subtreeSelect: aPredicate then: aCollector [
	^self
		announce:
			(SelectEvent new
				predicate: aPredicate;
				collector: aCollector;
				yourself)
]

{ #category : #'as yet unclassified' }
Population >> weightFunction: aPopulation wrt: aSelector [

	^ (self subjects size > 5 and: [ aPopulation  subjects size > 5 ])
								ifTrue: [ (aSelector value: self) + (aSelector value: aPopulation ) ]
]
