Extension { #name : #Interval }

{ #category : #'*RoassalPlayground' }
Interval >> <& anInterval [
	| sooner later |
	self assert: [ self isAscendingMonotone and: [ anInterval isAscendingMonotone ] ].
	start < anInterval start
		ifTrue: [ sooner := self.
			later := anInterval ]
		ifFalse: [ sooner := anInterval.
			later := self ].
	^ Interval
		from:
			{sooner start.
			later start} max
		to:
			{sooner stop.
			anInterval stop} min
]

{ #category : #'*RoassalPlayground' }
Interval >> isAscendingMonotone [
	^ start < stop
]

{ #category : #'*RoassalPlayground' }
Interval >> start [
	^ start
]

{ #category : #'*RoassalPlayground' }
Interval >> stop [
	^ stop
]
