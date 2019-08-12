Class {
	#name : #LindenmayerParser,
	#superclass : #SmaCCParser,
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #'generated-accessing' }
LindenmayerParser class >> cacheId [
	^'2019-08-11T18:17:56.629058+02:00'
]

{ #category : #generated }
LindenmayerParser class >> definitionComment [
"<letter>	: [A-Z] ;
<number> : [0-9]+ (\. [0-9]*) ? ;
 <whitespace> : \s+;

      %annotate_tokens;
      %root Expression;
      %prefix AST;
      %suffix LindenmayerNode;
 
     Expression : (Rule 'rule' ""."") + {{}};
     Rule
        : Axiom
        | <letter> 'left' "" -> "" Axiom 'right' {{Binary}}
        ;
      Axiom
        : (<letter> | ""+"" | ""-"") + 'axiom' {{Axiom}}
        ;"
]

{ #category : #'generated-accessing' }
LindenmayerParser class >> scannerClass [
	^LindenmayerScanner
]

{ #category : #generated }
LindenmayerParser class >> startingStateForExpression [
	^ 1
]

{ #category : #'generated-reduction actions' }
LindenmayerParser >> reduceActionForAxiom1: nodes [
	| result |
	result := ASTAxiomLindenmayerNode new.
	result axiom: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LindenmayerParser >> reduceActionForExpression1: nodes [
	| result |
	result := ASTExpressionLindenmayerNode new.
	result addNodes: ((nodes at: 1) at: 1) to: result rules.
	result addTokens: ((nodes at: 1) at: 2) to: result periodTokens.
	^ result
]

{ #category : #'generated-reduction actions' }
LindenmayerParser >> reduceActionForRule2: nodes [
	| result |
	result := ASTBinaryLindenmayerNode new.
	result left: (nodes at: 1).
	result _MinusGreaterThan_Token: (nodes at: 2).
	result right: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LindenmayerParser >> reduceActionFor__Rule__rule______1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LindenmayerParser >> reduceActionFor__Rule__rule_______1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LindenmayerParser >> reduceActionFor__Rule__rule_______2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LindenmayerParser >> reduceActionFor___letter__________3: nodes [
	^ nodes at: 1
]

{ #category : #'generated-reduction actions' }
LindenmayerParser >> reduceActionFor___letter___________1: nodes [
	^ OrderedCollection with: (nodes at: 1)
]

{ #category : #'generated-reduction actions' }
LindenmayerParser >> reduceActionFor___letter___________2: nodes [
	^ (nodes at: 1)
		add: (nodes at: 2);
		yourself
]

{ #category : #generated }
LindenmayerParser >> reduceTable [
^#(
	#(12 1 #reduceActionFor___letter__________3:) 
	#(16 1 #reduceActionForExpression1:) 
	#(7 1 #reduceActionFor__Rule__rule_______1:) 
	#(11 1 #reduceActionFor___letter__________3:) 
	#(13 1 #reduceActionFor___letter___________1:) 
	#(10 1 #reduceActionForAxiom1:) 
	#(7 2 #reduceActionFor__Rule__rule_______2:) 
	#(8 2 #reduceActionFor__Rule__rule______1:) 
	#(13 2 #reduceActionFor___letter___________2:) 
	#(11 3 #reduceActionForRule2:)
	).
]

{ #category : #generated }
LindenmayerParser >> symbolNames [
	^ #('"."' '" -> "' '"-"' '"+"' '<letter>' '<whitespace>' '( Rule ''rule'' ".")+' '( Rule ''rule'' ".")' 'B e g i n' 'Axiom' 'Rule' '( <letter> "+" "-")' '( <letter> "+" "-")+' 'E O F' 'error' 'Expression')
]

{ #category : #generated }
LindenmayerParser >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #OrderedCollection #OrderedCollection #ASTExpressionLindenmayerNode #ASTAxiomLindenmayerNode #ASTExpressionLindenmayerNode #SmaCCToken #Object #SmaCCToken #SmaCCToken #ASTExpressionLindenmayerNode)
]

{ #category : #generated }
LindenmayerParser >> transitionTable [
^#(
#[1 0 9 0 3 0 13 0 4 0 17 0 5 0 21 0 7 0 25 0 8 0 29 0 10 0 33 0 11 0 37 0 12 0 41 0 13 0 45 0 16] 
#[0 0 6 0 1 0 3 0 4 0 5] 
#[0 0 6 0 1 0 3 0 4 0 5] 
#[1 0 6 0 1 0 49 0 2 0 6 0 3 0 6 0 4 0 6 0 5] 
#[1 0 9 0 3 0 13 0 4 0 17 0 5 0 53 0 8 0 29 0 10 0 33 0 11 0 37 0 12 0 41 0 13 0 10 0 14] 
#[0 0 14 0 3 0 4 0 5 0 14] 
#[0 0 18 0 1] 
#[0 0 57 0 1] 
#[0 0 22 0 1 0 3 0 4 0 5] 
#[1 0 26 0 1 0 9 0 3 0 13 0 4 0 61 0 5 0 65 0 12] 
#[0 0 0 0 14] 
#[1 0 9 0 3 0 13 0 4 0 61 0 5 0 69 0 10 0 37 0 12 0 41 0 13] 
#[0 0 30 0 3 0 4 0 5 0 14] 
#[0 0 34 0 3 0 4 0 5 0 14] 
#[0 0 6 0 1 0 3 0 4 0 5] 
#[0 0 38 0 1 0 3 0 4 0 5] 
#[0 0 42 0 1]
	).
]
