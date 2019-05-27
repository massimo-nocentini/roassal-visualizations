Class {
	#name : #SelectEvent,
	#superclass : #Announcement,
	#instVars : [
		'predicate',
		'collector'
	],
	#category : #RoassalPlayground
}

{ #category : #accessing }
SelectEvent >> collector [
	^ collector
]

{ #category : #accessing }
SelectEvent >> collector: aBlockClosure [ 
	collector:= aBlockClosure 
]

{ #category : #accessing }
SelectEvent >> predicate [
	^ predicate
]

{ #category : #accessing }
SelectEvent >> predicate: aBlockClosure [ 
predicate:= aBlockClosure 
]
