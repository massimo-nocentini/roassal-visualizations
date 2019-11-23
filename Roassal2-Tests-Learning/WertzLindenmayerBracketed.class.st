Class {
	#name : #WertzLindenmayerBracketed,
	#superclass : #WertzLindenmayer,
	#category : #'Roassal2-Tests-Learning-Lindenmayer systems'
}

{ #category : #'as yet unclassified' }
WertzLindenmayerBracketed >> visitor [
	^ ASTExpressionLindenmayerBracketedEvaluator new
]
