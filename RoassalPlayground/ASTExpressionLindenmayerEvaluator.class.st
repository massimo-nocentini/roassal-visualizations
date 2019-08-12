Class {
	#name : #ASTExpressionLindenmayerEvaluator,
	#superclass : #ASTExpressionLindenmayerNodeVisitor,
	#instVars : [
		'productions',
		'pen',
		'length',
		'angle',
		'level',
		'controls'
	],
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #accessing }
ASTExpressionLindenmayerEvaluator >> angle [
	^ angle
]

{ #category : #accessing }
ASTExpressionLindenmayerEvaluator >> angle: anObject [
	angle := anObject
]

{ #category : #'as yet unclassified' }
ASTExpressionLindenmayerEvaluator >> automate: aString [
	aString
		do: [ :ele | 
			 controls
				at: ele
				ifPresent: [ :message | self perform: message ] ]
]

{ #category : #'as yet unclassified' }
ASTExpressionLindenmayerEvaluator >> forward [
      pen go: length
]

{ #category : #generated }
ASTExpressionLindenmayerEvaluator >> initialize [
	super initialize.
	productions := Dictionary new.
	controls := Dictionary new
		at: $F put: #forward;
		at: $+ put: #plus;
		at: $- put: #minus;
		yourself
]

{ #category : #'as yet unclassified' }
ASTExpressionLindenmayerEvaluator >> interpretAxiom: anAxiom [
	self automate: (self replace: anAxiom times: level)
]

{ #category : #accessing }
ASTExpressionLindenmayerEvaluator >> length [
	^ length
]

{ #category : #accessing }
ASTExpressionLindenmayerEvaluator >> length: anObject [
	length := anObject
]

{ #category : #accessing }
ASTExpressionLindenmayerEvaluator >> level [
	^ level
]

{ #category : #accessing }
ASTExpressionLindenmayerEvaluator >> level: anObject [
	level := anObject
]

{ #category : #'as yet unclassified' }
ASTExpressionLindenmayerEvaluator >> minus [
      pen turn: 0 - angle

]

{ #category : #accessing }
ASTExpressionLindenmayerEvaluator >> pen [
	^ pen
]

{ #category : #accessing }
ASTExpressionLindenmayerEvaluator >> pen: anObject [
	pen := anObject
]

{ #category : #'as yet unclassified' }
ASTExpressionLindenmayerEvaluator >> plus [
      pen turn: angle
]

{ #category : #'as yet unclassified' }
ASTExpressionLindenmayerEvaluator >> replace: aString [
	^ aString
		inject: String empty
		into: [ :new :ele | 
			(productions at: ele asString ifAbsent: [ nil ])
				ifNil: [ new , ele asString ]
				ifNotNil: [ :tmp | new , tmp ] ]
]

{ #category : #'as yet unclassified' }
ASTExpressionLindenmayerEvaluator >> replace: aString times: n [
	^ n isZero
		ifTrue: [ aString ]
		ifFalse: [ self replace: (self replace: aString) times: n - 1 ]
]

{ #category : #generated }
ASTExpressionLindenmayerEvaluator >> visitAxiom: anAxiom [
	^ '' join: (anAxiom axiom collect: #value)
	
]

{ #category : #generated }
ASTExpressionLindenmayerEvaluator >> visitBinary: aBinary [
	^ productions
		at: aBinary left value
		put: (aBinary right acceptVisitor: self)
]
