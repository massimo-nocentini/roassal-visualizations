Class {
	#name : #ASTExpressionLindenmayerNode,
	#superclass : #SmaCCParseNode,
	#instVars : [
		'rules',
		'periodTokens'
	],
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #generated }
ASTExpressionLindenmayerNode >> acceptVisitor: anExpressionVisitor [
	^ anExpressionVisitor visitExpression: self
]

{ #category : #generated }
ASTExpressionLindenmayerNode >> compositeNodeVariables [
	^ #(#rules)
]

{ #category : #generated }
ASTExpressionLindenmayerNode >> compositeTokenVariables [
	^ #(#periodTokens)
]

{ #category : #'generated-initialize-release' }
ASTExpressionLindenmayerNode >> initialize [
	super initialize.
	rules := OrderedCollection new: 2.
	periodTokens := OrderedCollection new: 2.
]

{ #category : #generated }
ASTExpressionLindenmayerNode >> periodTokens [
	^ periodTokens
]

{ #category : #generated }
ASTExpressionLindenmayerNode >> periodTokens: anOrderedCollection [
	periodTokens := anOrderedCollection
]

{ #category : #generated }
ASTExpressionLindenmayerNode >> rules [
	^ rules
]

{ #category : #generated }
ASTExpressionLindenmayerNode >> rules: anOrderedCollection [
	self setParents: self rules to: nil.
	rules := anOrderedCollection.
	self setParents: self rules to: self
]
