Class {
	#name : #WertzLindenmayer,
	#superclass : #LogoViewBuilder,
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #'as yet unclassified' }
WertzLindenmayer >> axiom: anAxiom rules: spec angle: angle level: level length: length pen: pen [
	| visitor |
	visitor := ASTExpressionLindenmayerEvaluator new
		accept: (LindenmayerParser parse: spec);
		yourself.
	visitor
		angle: angle;
		level: level;
		length: length;
		pen: pen.
	visitor interpretAxiom: anAxiom
]

{ #category : #'as yet unclassified' }
WertzLindenmayer >> onView: v withPen: pen [
	pen
		north;
		home;
		down.
	self
		axiom: 'F' rules: 'F -> F-F++F-F.'
		angle: 60
			level: 5
			length: 5
			pen: pen
	"		rules: 'F -> F-F++F-F.';"
]
