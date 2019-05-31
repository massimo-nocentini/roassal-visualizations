Extension { #name : #RTElement }

{ #category : #'*RoassalPlayground' }
RTElement >> childrenElements [
	^(self outgoingEdges collect: #to)
]

{ #category : #'*RoassalPlayground' }
RTElement >> depth [
^	self parentElement ifNil: [ 0 ] ifNotNil: [ 1 + self parentElement depth ]
]

{ #category : #'*RoassalPlayground' }
RTElement >> folded [
	^ self attributeAt: #documapsFolded ifAbsentPut: [ true ]
]

{ #category : #'*RoassalPlayground' }
RTElement >> folded: aBoolean [ 
	self attributeAt: #documapsFolded put: aBoolean
]

{ #category : #'*RoassalPlayground' }
RTElement >> isLeaf [
	^ self childrenElements isEmpty 
]

{ #category : #'*RoassalPlayground' }
RTElement >> leafElements [
	^ self childrenElements
		ifEmpty: [ Array with: self ]
		ifNotEmpty: [ | leaves |
			leaves := LinkedList new.
			self childrenElements
				do: [ :childElement | leaves addAll: childElement leafElements ].
			leaves ]
]

{ #category : #'*RoassalPlayground' }
RTElement >> presentation [
	^ (self
		getInteractionForClass: RTSelectableElementsContextInteraction)
		presentation
]

{ #category : #'*RoassalPlayground' }
RTElement >> removeRecursively [
	self childrenElements do: #removeRecursively.
	self remove 
]

{ #category : #'*RoassalPlayground' }
RTElement >> subtreeElements [
|elements|
	 elements := LinkedList with: self.
			self childrenElements
				do: [ :child | elements addAll: child subtreeElements ].
	^		elements
]
