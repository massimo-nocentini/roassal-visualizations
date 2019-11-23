Class {
	#name : #GLMCodeEditor,
	#superclass : #Object,
	#instVars : [
		'browser'
	],
	#category : #'Glamour-Tests-Learning'
}

{ #category : #'instance creation' }
GLMCodeEditor >> buildBrowser [
	browser := GLMTabulator new.
	browser
		row: #navigator;
		row: #source.
	browser transmit
		to: #navigator;
		andShow: [ :a | self navigatorIn: a ].
	browser transmit
		from: #navigator port: #selectedClass;
		from: #navigator port: #selectedMethod;
		to: #source;
		andShow: [ :a | self sourceIn: a ].
	^ browser
]

{ #category : #'instance creation' }
GLMCodeEditor >> navigatorIn: constructor [
	constructor custom: GLMCodeNavigator new buildBrowser
]

{ #category : #'instance creation' }
GLMCodeEditor >> open [
	self buildBrowser.
	browser openOn: self organizer
]

{ #category : #'instance creation' }
GLMCodeEditor >> organizer [
	^ RPackageOrganizer default
]

{ #category : #'instance creation' }
GLMCodeEditor >> sourceIn: constructor [
	constructor text
		display: [ :class :method | class sourceCodeAt: method ];
		act: [ :presentation :class :method | class compile: presentation text ]
			on: $s
			entitled: 'Save'
]
