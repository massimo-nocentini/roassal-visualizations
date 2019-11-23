Extension { #name : #Interval }

{ #category : #'*Roassal2-Tests-Learning' }
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

{ #category : #'*Roassal2-Tests-Learning' }
Interval >> isAscendingMonotone [
	^ start < stop
]

{ #category : #'*Roassal2-Tests-Learning' }
Interval >> start [
	^ start
]

{ #category : #'*Roassal2-Tests-Learning' }
Interval >> stop [
	^ stop
]
