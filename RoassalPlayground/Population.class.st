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

{ #category : #moves }
Population >> populationThreshold [
^ 5
]

{ #category : #moves }
Population >> splitFeature: aString at: aNumber [
	| sat noSat |
	sat := LinkedList new.
	noSat := LinkedList new.
	subjects
		do: [ :each | 
			(each at: aString) < aNumber
				ifTrue: [ sat add: each ]
				ifFalse: [ "hardcoded, abstract it." noSat add: each ] ].
	(sat size > self populationThreshold
		and: [ noSat size > self populationThreshold ])
		ifTrue: [ self
				announce:
					(SplitEvent new
						feature: aString;
						at: aNumber;
						firstHalf: (Population withAll: sat);
						secondHalf: (Population withAll: noSat);
						yourself) ]
]

{ #category : #accessing }
Population >> subjects [
	^ subjects
]

{ #category : #accessing }
Population >> subjects: aCollection [ 
	subjects := aCollection
]
