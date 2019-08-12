Class {
	#name : #ASTBinaryLindenmayerNode,
	#superclass : #ASTExpressionLindenmayerNode,
	#instVars : [
		'left',
		'_MinusGreaterThan_Token',
		'right'
	],
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #generated }
ASTBinaryLindenmayerNode >> _MinusGreaterThan_Token [
	^ _MinusGreaterThan_Token
]

{ #category : #generated }
ASTBinaryLindenmayerNode >> _MinusGreaterThan_Token: aSmaCCToken [
	_MinusGreaterThan_Token := aSmaCCToken
]

{ #category : #generated }
ASTBinaryLindenmayerNode >> acceptVisitor: anExpressionVisitor [
	^ anExpressionVisitor visitBinary: self
]

{ #category : #generated }
ASTBinaryLindenmayerNode >> left [
	^ left
]

{ #category : #generated }
ASTBinaryLindenmayerNode >> left: aSmaCCToken [
	left := aSmaCCToken
]

{ #category : #generated }
ASTBinaryLindenmayerNode >> nodeVariables [
	^ #(#right)
]

{ #category : #generated }
ASTBinaryLindenmayerNode >> right [
	^ right
]

{ #category : #generated }
ASTBinaryLindenmayerNode >> right: anASTAxiomLindenmayerNode [
	self right notNil
		ifTrue: [ self right parent: nil ].
	right := anASTAxiomLindenmayerNode.
	self right notNil
		ifTrue: [ self right parent: self ]
]

{ #category : #generated }
ASTBinaryLindenmayerNode >> tokenVariables [
	^ #(#left #_MinusGreaterThan_Token)
]
