Class {
	#name : #GLMCodeNavigator,
	#superclass : #Object,
	#instVars : [
		'browser'
	],
	#category : #'Glamour-Tests-Learning'
}

{ #category : #'instance creation' }
GLMCodeNavigator >> buildBrowser [
	browser := GLMTabulator new.
	browser
		column: #packages;
		column: #classes;
		column: #categories;
		column: #methods.
	browser transmit
		to: #packages;
		andShow: [ :a | self packagesIn: a ].
	browser transmit
		from: #packages;
		to: #classes;
		andShow: [ :a | self classesIn: a ].
	browser transmit
		from: #classes;
		to: #categories;
		andShow: [ :a | self categoriesIn: a ].
	browser transmit
		from: #classes;
		from: #categories;
		to: #methods;
		andShow: [ :a | self methodsIn: a ].
	browser transmit
		from: #classes;
		toOutsidePort: #selectedClass.
	browser transmit
		from: #methods;
		toOutsidePort: #selectedMethod.
	^ browser
]

{ #category : #'instance creation' }
GLMCodeNavigator >> categoriesIn: constructor [
	constructor list display: [ :class | class organization categories ]
]

{ #category : #'instance creation' }
GLMCodeNavigator >> childrenOf: rootPackage on: organizer [
	^ organizer packageNames
		select: [ :name | name beginsWith: rootPackage , '-' ]
]

{ #category : #'instance creation' }
GLMCodeNavigator >> classesIn: constructor [
	constructor list
		when: [ :packageName | self organizer includesPackageNamed: packageName ];
		display:
				[ :packageName | (self organizer packageNamed: packageName) definedClasses ];
		title: 'Class list'.
	constructor roassal2
		when: [ :packageName | self organizer includesPackageNamed: packageName ];
		painting: [ :view :packageName | 
			| elements |
			elements := RTBox
				elementsOn: (self organizer packageNamed: packageName) definedClasses.
			elements @ RTDraggable.
			view addAll: elements.
			RTEdgeBuilder new
				view: view;
				shape: (RTLine new color: Color purple);
				connectFrom: #superclass to: #yourself.
			RTTreeLayout on: view elements edges: view edges.
			view edges do: [ :e | e trachelShape pushBack ].
			view @ RTDraggableView ];
		title: 'Hierarchy'
]

{ #category : #building }
GLMCodeNavigator >> methodsIn: constructor [
	constructor list
		display:
			[ :class :category | (class organization listAtCategoryNamed: category) sorted ].
	constructor list
		when: [ :class :category | class notNil and: [ category isNil ] ];
		display: [ :class | class selectors sorted ];
		allowNil
]

{ #category : #'instance creation' }
GLMCodeNavigator >> open [
	self buildBrowser.
	browser openOn: self organizer
]

{ #category : #'instance creation' }
GLMCodeNavigator >> organizer [
	^ RPackageOrganizer default
]

{ #category : #private }
GLMCodeNavigator >> packagesIn: constructor [
	constructor tree
		display: [ :organizer | (self rootPackagesOn: organizer) asSet sorted ];
		children:
				[ :rootPackage :organizer | (self childrenOf: rootPackage on: organizer) sorted ];
		format: #asString
]

{ #category : #'instance creation' }
GLMCodeNavigator >> rootPackagesOn: organizer [
	^ organizer packageNames
		collect: [ :string | string readStream upTo: $- ]
]
