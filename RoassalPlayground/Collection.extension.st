Extension { #name : #Collection }

{ #category : #'*RoassalPlayground' }
Collection >> arg: aSelector function: aBlockClosure opt: sortBlock [

	^ self arg: aSelector function: aBlockClosure using: (Heap
		sortBlock: [ :anAssoc :anotherAssoc | 
			sortBlock
				valueWithArguments:
					{anAssoc value.
					anotherAssoc value} ])
]

{ #category : #'*RoassalPlayground' }
Collection >> arg: aSelector function: aBlockClosure using: heap [
	| tuples progress |
	progress := 0.
	tuples := [ :job | 
	self
		flatCollect: [ :aPopulation | 
			| perc |
			progress := progress + 1.
			perc := progress / self size.
			job
				progress: perc;
				title: 'Building the search space (' , perc printString , '%)'.
			aSelector value: aPopulation ] ] asJob run.
	progress := 0.
	[ :job | 
	tuples
		collect: [ :tuple | tuple unpackOnBlock: aBlockClosure ]
		thenDoWithEach: [ :tuple :v | 
			| perc |
			progress := progress + 1.
			perc := (progress / tuples size) asFloat.
			job
				progress: perc;
				title: 'Ranking tuples (' , (perc * 100) printString , '%)'.
			v ifNotNil: [ heap add: tuple -> v ] ] ] asJob run.
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
Collection >> unpackOnBlock: aBlockClosure [ 
	^ aBlockClosure valueWithArguments: self
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
