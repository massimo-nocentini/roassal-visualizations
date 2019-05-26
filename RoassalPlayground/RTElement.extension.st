Extension { #name : #RTElement }

{ #category : #'*RoassalPlayground' }
RTElement >> childrenElements [
	^(self outgoingEdges collect: #to)
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
