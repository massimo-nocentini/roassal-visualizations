Class {
	#name : #ASTExpressionLindenmayerNodeVisitor,
	#superclass : #SmaCCParseNodeVisitor,
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #generated }
ASTExpressionLindenmayerNodeVisitor >> visitAxiom: anAxiom [
	^ self visitExpression: anAxiom
]

{ #category : #generated }
ASTExpressionLindenmayerNodeVisitor >> visitBinary: aBinary [
	^ self visitExpression: aBinary
]

{ #category : #generated }
ASTExpressionLindenmayerNodeVisitor >> visitExpression: anExpression [
	^ self visitSmaCCParseNode: anExpression
]
