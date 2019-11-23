Extension { #name : #RTElement }

{ #category : #'*Roassal2-Tests-Learning' }
RTElement >> childrenElements [
	^(self outgoingEdges collect: #to)
]

{ #category : #'*Roassal2-Tests-Learning' }
RTElement >> depth [
^	self parentElement ifNil: [ 0 ] ifNotNil: [ 1 + self parentElement depth ]
]

{ #category : #'*Roassal2-Tests-Learning' }
RTElement >> folded [
	^ self attributeAt: #documapsFolded ifAbsentPut: [ true ]
]

{ #category : #'*Roassal2-Tests-Learning' }
RTElement >> folded: aBoolean [ 
	self attributeAt: #documapsFolded put: aBoolean
]

{ #category : #'*Roassal2-Tests-Learning' }
RTElement >> isLeaf [
	^ self childrenElements isEmpty 
]

{ #category : #'*Roassal2-Tests-Learning' }
RTElement >> isRootElement [
	^ self parentElement isNil 
]

{ #category : #'*Roassal2-Tests-Learning' }
RTElement >> leafElements [
	^ self childrenElements
		ifEmpty: [ Array with: self ]
		ifNotEmpty: [ | leaves |
			leaves := LinkedList new.
			self childrenElements
				do: [ :childElement | leaves addAll: childElement leafElements ].
			leaves ]
]

{ #category : #'*Roassal2-Tests-Learning' }
RTElement >> presentation [
	^ (self
		getInteractionForClass: RTSelectableElementsContextInteraction)
		presentation
]

{ #category : #'*Roassal2-Tests-Learning' }
RTElement >> removeRecursively [
	self childrenElements do: #removeRecursively.
	self remove 
]

{ #category : #'*Roassal2-Tests-Learning' }
RTElement >> rootElement [
	^ self parentElement ifNil: [ self ] ifNotNil: [ self parentElement rootElement  ]
]

{ #category : #'*Roassal2-Tests-Learning' }
RTElement >> subtreeElements [
|elements|
	 elements := LinkedList with: self.
			self childrenElements
				do: [ :child | elements addAll: child subtreeElements ].
	^		elements
]
