Class {
	#name : #ASTExpressionLindenmayerBracketedEvaluator,
	#superclass : #ASTExpressionLindenmayerEvaluator,
	#instVars : [
		'stack'
	],
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #generated }
ASTExpressionLindenmayerBracketedEvaluator >> initialize [
	super initialize.
	stack := Stack new.
	controls at: $[ put: #push;
		at: $] put: #pop
]

{ #category : #'API-remotes' }
ASTExpressionLindenmayerBracketedEvaluator >> pop [
        pen
           location: stack pop;
           direction: stack pop.
            stack pop ifTrue: [ pen down ] ifFalse: [ pen up ]
]

{ #category : #'API-remotes' }
ASTExpressionLindenmayerBracketedEvaluator >> push [
	stack
		push: pen isDown;
		push: pen direction;
		push: pen location
]
