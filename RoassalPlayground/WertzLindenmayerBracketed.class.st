Class {
	#name : #WertzLindenmayerBracketed,
	#superclass : #WertzLindenmayer,
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #'as yet unclassified' }
WertzLindenmayerBracketed >> visitor [
	^ ASTExpressionLindenmayerBracketedEvaluator new
]
