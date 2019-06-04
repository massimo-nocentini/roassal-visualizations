Class {
	#name : #Population,
	#superclass : #Announcer,
	#instVars : [
		'subjects'
	],
	#classInstVars : [
		'subjects'
	],
	#category : #RoassalPlayground
}

{ #category : #creating }
Population class >> withAll: aCollection [
	^ self new subjects: aCollection; yourself
]

{ #category : #accessing }
Population >> RSS: aFeature [
	|avg|
	avg := self mean:aFeature .
	^ ((self collectFeature: aFeature) collect:[:each | (each - avg) ** 2]) sum
]

{ #category : #accessing }
Population >> collectFeature: aKey [
 ^  subjects collect: [ :each | each at: aKey ]
]

{ #category : #accessing }
Population >> features [
	^ subjects first keys \ {#id . #y}
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
Population >> optimizedGrow [
	| ranking |
	ranking := self
		subtreeSelect: #isLeaf
		then: [ :populations | 
			populations
				argMin: [ :aPopulation | 
					aPopulation features
						flatCollect: [ :aFeature | 
							(aPopulation collectFeature: aFeature)
								collect: [ :aValue | 
									{aFeature.
									aValue.
									aPopulation} ] ] ]
				function: [ :f :v :p | 
					p
						splitFeature: f
						at: v
						with: [ :l :g | 
							(l subjects size > 5 and: [ g subjects size > 5 ])
								ifTrue: [ (l RSS: #y) + (g RSS: #y) ] ] ] ].
	ranking result
		ifNotEmpty: [ :heap | heap first key unpackOnBlock: [ :f :v :p | p splitFeature: f at: v ] ] 
]

{ #category : #move }
Population >> prune [
	self announce: PruneEvent new
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
				ifFalse: [  noSat add: each ] ].
			^ aReceiver value: (Population withAll: sat) value: (Population withAll: noSat)
	
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
