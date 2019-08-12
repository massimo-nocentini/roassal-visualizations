Class {
	#name : #LindenmayerScanner,
	#superclass : #SmaCCScanner,
	#category : #'RoassalPlayground-Lindenmayer systems'
}

{ #category : #generated }
LindenmayerScanner class >> states [
	^ #(#default)
]

{ #category : #generated }
LindenmayerScanner >> emptySymbolTokenId [
	^ 14
]

{ #category : #generated }
LindenmayerScanner >> errorTokenId [
	^ 15
]

{ #category : #generated }
LindenmayerScanner >> scanForToken [
	self step.
	currentCharacter == Character space
		ifTrue: [ self recordMatch: #(6).
			self step.
			currentCharacter == $-
				ifTrue: [ self step.
					currentCharacter == $>
						ifTrue: [ self step.
							currentCharacter == Character space
								ifTrue: [ ^ self recordAndReportMatch: #(2) ] ].
					^ self reportLastMatch ].
			(currentCharacter isSeparator
				or: [ currentCharacter == Character pageUp ])
				ifTrue: [ [ self recordMatch: #(6).
					self step.
					currentCharacter isSeparator
						or: [ currentCharacter == Character pageUp ] ] whileTrue ].
			^ self reportLastMatch ].
	currentCharacter == $+
		ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter == $-
		ifTrue: [ ^ self recordAndReportMatch: #(3) ].
	currentCharacter == $.
		ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	(currentCharacter isSeparator
		or: [ currentCharacter == Character pageUp ])
		ifTrue: [ [ self recordMatch: #(6).
			self step.
			currentCharacter isSeparator
				or: [ currentCharacter == Character pageUp ] ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter between: $A and: $Z)
		ifTrue: [ ^ self recordAndReportMatch: #(5) ].
	^ self reportLastMatch
]

{ #category : #generated }
LindenmayerScanner >> tokenActions [
	^ #(nil nil nil nil nil #whitespace)
]
