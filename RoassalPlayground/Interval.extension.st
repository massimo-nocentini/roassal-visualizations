Extension { #name : #Interval }

{ #category : #'*RoassalPlayground' }
Interval >> <& anInterval [
	^ Interval from: { start . anInterval start } max to: { stop . anInterval stop } min
]

{ #category : #'*RoassalPlayground' }
Interval >> start [
	^ start
]

{ #category : #'*RoassalPlayground' }
Interval >> stop [
	^ stop
]
