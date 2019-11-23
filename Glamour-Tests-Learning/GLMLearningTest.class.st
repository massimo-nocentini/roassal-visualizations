Class {
	#name : #GLMLearningTest,
	#superclass : #TestCase,
	#category : #'Glamour-Tests-Learning'
}

{ #category : #tests }
GLMLearningTest >> testCodeEditor [
	GLMCodeEditor new open
]

{ #category : #tests }
GLMLearningTest >> testCodeNavigator [
	GLMCodeNavigator new open
]

{ #category : #tests }
GLMLearningTest >> testFileSystem [
	| browser |
	browser := GLMFinder new.
	browser
		show: [ :a | 
			a list
				when: #isDirectory;
				display: #children;
				format: #basenameWithIndicator ].
	browser openOn: FileSystem disk root
]

{ #category : #tests }
GLMLearningTest >> testFileSystemBeauty [
	| browser |
	browser := GLMFinder new
		variableSizePanes;
		title: 'Find your file';
		yourself.
	browser
		show: [ :a | 
			a list
				when: #isDirectory;
				display: [ :each | 
					[ each children ]
						on: Exception
						do: [ Array new ] ];
				format: #basenameWithIndicator.
			a text
				when: #isFile;
				display: [ :entry | 
					[ entry readStream contents ]
						on: Exception
						do: [ 'Can''t display the content of this file' ] ] ].
	browser openOn: FileSystem disk root
]

{ #category : #tests }
GLMLearningTest >> testRoassalPainting [
	"as yet unclassified"

	"self new roassalPainting openOn: 42"

	<glmBrowser: 'Roassal painting' input: '42'>
	| browser |
	browser := GLMTabulator withStatusbar.
	browser
		column: #one;
		column: #two.
	browser transmit
		to: #one;
		andShow: [ :a | 
			a list
				title: 'Select and trigger from menu';
				display: [ :x | 1 to: x ];
				selectionAct: [ :list | 
					| value |
					value := list selection * 10.	"simulate some custom setup"
					(list pane port: #customSelection) value: value ]
					entitled: 'Multiply by 10 and then send outside' ].
	browser transmit
		to: #two;
		from: #one port: #customSelection;
		andShow: [ :a | 
			a roassal2
				title: 'Numbers in Roassal';
				initializeView: [ RTMondrian new ];
				painting: [ :view :number | 
					view shape label.
					view nodes: (1 to: number).
					view edges connectFrom: [ :each | each // 5 ].
					view layout tree ] ].
	browser openOn: 42
]

{ #category : #tests }
GLMLearningTest >> testSubclasses [
	| browser |
	browser := GLMFinder new.
	browser show: [ :a | a list display: #subclasses ].
	browser openOn: Collection
]
