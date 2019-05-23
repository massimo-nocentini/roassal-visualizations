Class {
	#name : #FoldableDecoration,
	#superclass : #Object,
	#instVars : [
		'folded',
		'obj'
	],
	#category : #RoassalPlayground
}

{ #category : #accessing }
FoldableDecoration >> folded [

^ folded
]

{ #category : #Accessing }
FoldableDecoration >> folded: aBoolean [
	folded := aBoolean
]

{ #category : #accessing }
FoldableDecoration >> obj [
	^ obj
]

{ #category : #accessing }
FoldableDecoration >> obj: aFileReference [ 
	obj := aFileReference
]
