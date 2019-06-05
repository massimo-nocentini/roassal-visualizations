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
	#category : #RoassalPlayground
}

{ #category : #accessing }
Population >> RSS: aFeature [
	|avg|
	avg := self mean:aFeature .
	^ ((self collectFeature: aFeature) collect:[:each | (each - avg) ** 2]) sum
]

{ #category : #'as yet unclassified' }
Population >> cartesianProductOfFeaturesAndValues [

^ self features
		flatCollect: [ :aFeature | 
			(self collectFeature: aFeature)
				collect: [ :aValue | 
					{aFeature.
					aValue.
					self} ] ] .

]

{ #category : #accessing }
Population >> collectFeature: aKey [
 ^  subjects collect: [ :each | each at: aKey ]
]

{ #category : #accessing }
Population >> features [
	^ subjects first keys \ {#id . response}
]

{ #category : #move }
Population >> grow [
	self growUsingFeatures: self features
	
]

{ #category : #'as yet unclassified' }
Population >> growUsingFeatures: aCollection [

self announce: (GrowEvent new features: aCollection ; yourself)
	
]

{ #category : #accessing }
Population >> mean: aFeature [
 ^ (self collectFeature: aFeature) average
]

{ #category : #'as yet unclassified' }
Population >> optimizationFunction: aPopulation wrt: aSelector [

	^ (self subjects size > 5 and: [ aPopulation  subjects size > 5 ])
								ifTrue: [ (aSelector value: self) + (aSelector value: aPopulation ) ]
]

{ #category : #'as yet unclassified' }
Population >> optimizedGrow [
	| aSelectEvent |
	aSelectEvent := self
		subtreeSelect: #isLeaf
		then: [ :populations | 
			populations
				argMin: #cartesianProductOfFeaturesAndValues
				function: [ :f :v :p | 
					p
						splitFeature: f
						at: v
						with: [ :l :g | l optimizationFunction: g wrt: #responseRSS ] ] ].
	aSelectEvent result
		ifNotEmpty:
			[ :heap | heap first key unpackOnBlock: [ :f :v :p | p splitFeature: f at: v ] ]
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
Population >> responseRSS [
	| avg |
	avg := self mean: response.
	^ ((self collectFeature: response)
		collect: [ :each | (each - avg) ** 2 ]) sum
]

{ #category : #moves }
Population >> splitFeature: aString at: aNumber [
	self
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
