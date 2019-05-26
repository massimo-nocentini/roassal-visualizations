Class {
	#name : #PruneEvent,
	#superclass : #Announcement,
	#instVars : [
		'predicate'
	],
	#category : #RoassalPlayground
}

{ #category : #accessing }
PruneEvent >> predicate [
	^ predicate
]

{ #category : #accessing }
PruneEvent >> predicate: aBlockClosure [ 
	predicate := aBlockClosure 
]
