Extension { #name : #BlockClosure }

{ #category : #'*RoassalPlayground' }
BlockClosure >> valueWithReturnExit [
	self value: [ :v | ^ v ]
]
