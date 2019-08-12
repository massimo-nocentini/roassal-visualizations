Class {
	#name : #ASTAxiomLindenmayerNode,
	#superclass : #ASTExpressionLindenmayerNode,
	#instVars : [
		'axiom'
	],
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #generated }
ASTAxiomLindenmayerNode >> acceptVisitor: anExpressionVisitor [
	^ anExpressionVisitor visitAxiom: self
]

{ #category : #generated }
ASTAxiomLindenmayerNode >> axiom [
	^ axiom
]

{ #category : #generated }
ASTAxiomLindenmayerNode >> axiom: anObject [
	axiom := anObject
]

{ #category : #generated }
ASTAxiomLindenmayerNode >> otherVariables [
	^ #(#axiom)
]
