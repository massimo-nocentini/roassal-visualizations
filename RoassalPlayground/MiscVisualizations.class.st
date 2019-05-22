Class {
	#name : #MiscVisualizations,
	#superclass : #Object,
	#category : #RoassalPlayground
}

{ #category : #examples }
MiscVisualizations >> bezierTest [
	<gtExample>
	| b v children |
	children := '/Users/mn/Developer/working-copies/logics/mk/microkanrenst/'
		asFileReference allChildren.
	v := RTView new.
	b := RTBundleBuilder new.
	b layout cluster verticalGap: 45.
	b view: v.
	b
		explore:
			'/Users/mn/Developer/working-copies/logics/mk/microkanrenst/'
				asFileReference
		using: #allChildren.
	b bezier color: (Color colorFrom: '#4682b4').
	b useBezierlineWith: #parent.
	^ b
]

{ #category : #examples }
MiscVisualizations >> dynamicalView [
	<gtExample>
	| v stepping |
	v := RTView new.
	v @ RTDraggableView.
	"We set a dynamic spring layout"
	stepping := RTSpringLayoutStepping new view: v.
	stepping after: [ v canvas camera focusOnCenter ].
	v addAnimation: stepping.
	"Add a new circle when pressing on a button"
	v canvas
		addMenu: 'Add circle'
		callback: [ | el |
			el := (RTEllipse new
				size: 20;
				color: (Color blue alpha: 0.4)) element.
			el @ RTDraggable.
			el translateTo: 5 atRandom @ 5 atRandom.
			v add: el.
			stepping addNode: el.
			v signalUpdate ].
	"Add a new edge when pressing on a button"
	v canvas
		addMenu: 'Add connected circle'
		callback: [ | el edge |
			el := (RTEllipse new
				size: 20;
				color: (Color blue alpha: 0.4)) element.
			el @ RTDraggable.
			el translateTo: 5 atRandom @ 5 atRandom.
			v add: el.
			edge := RTLine edgeFrom: el to: v elements atRandom.
			v add: edge.
			stepping
				addNode: el;
				addEdge: edge.
			v signalUpdate ].
	^ v
]

{ #category : #'public translation' }
MiscVisualizations >> smoothTranslation [
	<gtExample>
| v translator |


	translator := RTSmoothLayoutTranslator new.
	v := RTView new.
	v canvas
		addMenu: 'grid'
		callback: [ RTGridLayout new
				translator: translator;
				on: v elements.
			v canvas signalUpdate ].
	v canvas
		addMenu: 'hori'
		callback: [ RTHorizontalLineLayout new
				translator: translator;
				on: v elements.
			v canvas signalUpdate ].
	v canvas
		addMenu: 'treeV'
		callback: [ RTTreeLayout new
				translator: translator;
				on: v elements edges: v edges.
			v canvas signalUpdate ].
	v canvas
		addMenu: 'treeH'
		callback: [ RTHorizontalTreeLayout new
				translator: translator;
				on: v elements edges: v edges.
			v canvas signalUpdate ].
	v canvas
		addMenu: 'cluster'
		callback: [ RTClusterLayout new
				translator: translator;
				on: v elements edges: v edges.
			v canvas signalUpdate ].
	v canvas
		addMenu: 'circle'
		callback: [ RTCircleLayout new
				translator: translator;
				scaleBy: 0.8;
				on: v elements.
			v canvas signalUpdate ].
	v canvas
		addMenu: 'radial'
		callback: [ RTRadialTreeLayout new
				translator: translator;
				on: v elements.
			v canvas signalUpdate ].
	v canvas
		addMenu: 'sugiyama'
		callback: [ RTSugiyamaLayout new
				translator: translator;
				on: v elements.
			v canvas signalUpdate ].
	v addAll: (RTBox new elementsOn: (1 to: 100)).
	RTEdgeBuilder new
		view: v;
		objects: (1 to: 100);
		connectFrom: [ :value | value // 2 ] to: #yourself.
	RTTreeLayout new on: v elements edges: v edges.
	^ v
]

{ #category : #examples }
MiscVisualizations >> temp [
	<gtExample>
	| b |
	b := RTMondrian new.
b nodes: (1 to: 300).
b edges connectFrom: [ :value | value // 2 ].
b shape
bezierLineFollowing: [ :value | value // 2 ]; color: Color blue trans.
b edges notUseInLayout;
connectTo: [ :value | (value / 10) asInteger + (value \\ 10) ].
b layout cluster. ^b
]

{ #category : #examples }
MiscVisualizations >> tempFilePath [
	<gtExample>
	| b children |
	children := '/Users/mn/Developer/working-copies/logics/mk/microkanrenst/'
		asFileReference allChildren.
	b := RTMondrian new.
	b nodes: children.
	b edges connectFrom: #parent.
	b shape
		bezierLineFollowing: #parent;
		color: Color blue trans.
	b edges
		notUseInLayout;
		connectTo: [:el | el pathSegments last].
	b layout horizontalTree.
	^ b
]
