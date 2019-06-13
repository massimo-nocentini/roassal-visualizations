Class {
	#name : #SelectEvent,
	#superclass : #Announcement,
	#instVars : [
		'predicate',
		'collector',
		'result'
	],
	#category : #'RoassalPlayground-RegressionTrees'
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

{ #category : #accessing }
SelectEvent >> result [
	^ result
]

{ #category : #accessing }
SelectEvent >> result: aValue [ 
	result := aValue
]
