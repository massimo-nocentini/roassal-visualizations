Class {
	#name : #SplitEvent,
	#superclass : #Announcement,
	#instVars : [
		'firstHalf',
		'secondHalf',
		'feature',
		'at'
	],
	#category : #'RoassalPlayground-RegressionTrees'
}

{ #category : #accessing }
SplitEvent >> at [
	^ at
]

{ #category : #accessing }
SplitEvent >> at: aValue [
	at:=aValue
]

{ #category : #accessing }
SplitEvent >> feature [
^ feature
]

{ #category : #accessing }
SplitEvent >> feature: aString [ 
feature:= aString 
]

{ #category : #accessing }
SplitEvent >> firstHalf [
	^ firstHalf
]

{ #category : #accessing }
SplitEvent >> firstHalf: aCollection [ 
	firstHalf:= aCollection 

]

{ #category : #accessing }
SplitEvent >> secondHalf [
	^ secondHalf 
]

{ #category : #accessing }
SplitEvent >> secondHalf: aCollection [ 
secondHalf:= aCollection 
]
