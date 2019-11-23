Extension { #name : #BlockClosure }

{ #category : #'*Roassal2-Tests-Learning' }
BlockClosure >> valueWithReturnExit [
	self value: [ :v | ^ v ]
]
