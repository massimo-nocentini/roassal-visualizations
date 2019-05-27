Extension { #name : #Collection }

{ #category : #'*RoassalPlayground' }
Collection >> atRandomBounded [
	^ self withMinMax: [ :min :max | Random new next * (max - min) ]
]

{ #category : #'*RoassalPlayground' }
Collection >> withMinMax: aBlock [
	| min max |
	min := Float infinity.
	max := Float negativeInfinity .
	self
		do: [ :each | 
			each < min
				ifTrue: [ min := each ].
			each > max
				ifTrue: [ max := each ] ].
	^ aBlock value: min value: max
]
