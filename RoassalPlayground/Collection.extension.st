Extension { #name : #Collection }

{ #category : #'*RoassalPlayground' }
Collection >> arg: aSelector function: aBlockClosure opt: sortBlock [
	| tuples heap |
	heap := Heap
		sortBlock:
			[ :anAssoc :anotherAssoc | sortBlock valueWithArguments: {   anAssoc value . anotherAssoc value }].
	tuples := self flatCollect: aSelector.
	tuples
		collect: [ :tuple | tuple unpackOnBlock: aBlockClosure ]
		thenDoWithEach: [ :tuple :v | v ifNotNil: [ heap add: tuple -> v ] ].
	^ heap
]

{ #category : #'*RoassalPlayground' }
Collection >> argMin: aSelector function: aBlockClosure [
	^ self
		arg: aSelector
		function: aBlockClosure
		opt: [ :v :w | v < w ]
]

{ #category : #'*RoassalPlayground' }
Collection >> atRandomBounded [
	^ self withMinMax: [ :min :max | Random new next * (max - min) ]
]

{ #category : #'*RoassalPlayground' }
Collection >> collect: collectBlock thenDoWithEach: doBlock [
	"Utility method to improve readability."

	^ self do: [ :each | doBlock value: each value: (collectBlock value: each) ]
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
