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
