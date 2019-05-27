Class {
	#name : #GrowEvent,
	#superclass : #Announcement,
	#instVars : [
		'features'
	],
	#category : #RoassalPlayground
}

{ #category : #accessing }
GrowEvent >> features [
	^ features
]

{ #category : #accessing }
GrowEvent >> features: aCollection [ 
	features := aCollection 
]
