Class {
	#name : #MiscVisualizations,
	#superclass : #Object,
	#category : #RoassalPlayground
}

{ #category : #examples }
MiscVisualizations >> arclineViz [
	<gtExample>
	| v els e1 e2  |
	v := RTView new.
	els := RTEllipse new
		color: Color gray;
		borderColor: Color black;
		size: 20;
		elementsOn: #(A B).
	els @ RTDraggable.
	v addAll: els.
	els second translateBy: 100 @ 0.
	e1 := RTArcLine new
		distance: 10;
		filledNarrowArrowHead;
		color: Color black;
		edgeFrom: els first to: els second.
	e2 := RTArcLine new
		distance: 10;
		filledNarrowArrowHead;
		color: Color black;
		edgeFrom: els second to: els first.
	v
		add: e1;
		add: e2.
	^ v
]

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
MiscVisualizations >> catalan [
	<gtExample>
	| b p |
	p := RTPalette c6.
	b := RTCircularTreeMapBuilder new.
	b shape
		if: [ :aPoint | aPoint catalan odd ] fillColor: [ p first ];
		if: [ :aPoint | aPoint catalan even ] fillColor: [ p second ].
	b
		baseradius: 400;
		weight: [ :aPoint | aPoint catalan ].
	b
		explore: 0 @ 0
		using: [ :n | 
			n < (6 @ 6)
				ifTrue: [ (0 to: n y + 1) collect: [ :y | (n x + 1) @ y ] ]
				ifFalse: [ #() ] ].
	b build.
	^ b view
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

{ #category : #examples }
MiscVisualizations >> fibonacci [
	<gtExample>
	| b p |
	p := RTPalette c6.
	b := RTCircularTreeMapBuilder new.
	b shape
		if: [ :aPoint | aPoint fibonacci odd ] fillColor: [ p first ];
		if: [ :aPoint | aPoint fibonacci even ] fillColor: [ p second ].
	b
		baseradius: 400;
		weight: [ :aPoint | aPoint fibonacci + 1 ].
	b
		explore: 0
		using: [ :n | 
			n < 11
				ifTrue: [ Array with: n + 1 with: n + 2 ]
				ifFalse: [ "up to the first 10 Fibonacci numbers" Array new ] ].
	b build.
	^ b view
]

{ #category : #examples }
MiscVisualizations >> kmeans [
	"Viz taken from: https://gist.github.com/zeroflag/f30f3c4329c69d7edb2f"

	<gtExample>
	| randomPoint points kmeans cluster1 cluster2 cluster3 cluster1ds cluster2ds cluster3ds centroids |
	randomPoint := [ (0 to: 5) atRandom @ (0 to: 5) atRandom ].
	points := (1 to: 100)
		collect: [ :i | (500 atRandom / 100) @ (500 atRandom / 100) ].
	kmeans := [ :centroid1 :centroid2 :centroid3 | 
	cluster1 := Set new.
	cluster2 := Set new.
	cluster3 := Set new.
	points
		do: [ :each | 
			| nearest |
			nearest := {(cluster1 -> (each squaredDistanceTo: centroid1)).
			(cluster2 -> (each squaredDistanceTo: centroid2)).
			(cluster3 -> (each squaredDistanceTo: centroid3))}
				detectMin: #value.
			nearest key add: each ].
	cluster1ds := RTData new.
	cluster1ds dotShape color: Color red.
	cluster1ds
		points: cluster1;
		x: #x;
		y: #y.
	cluster2ds := RTData new.
	cluster2ds dotShape color: Color blue.
	cluster2ds
		points: cluster2;
		x: #x;
		y: #y.
	cluster3ds := RTData new.
	cluster3ds dotShape color: Color green.
	cluster3ds
		points: cluster3;
		x: #x;
		y: #y.
	centroids := RTData new
		points:
			{centroid1.
			centroid2.
			centroid3};
		x: #x;
		y: #y.
	centroids dotShape rectangle color: Color black.
	centroids dotShape size: 8.
	RTGrapher new
		add: cluster1ds;
		add: cluster2ds;
		add: cluster3ds;
		add: centroids;
		extent: 500 @ 500;
		"maxX: 5; maxY: 5;"
			build;
		view ].
	(1 to: 100)
		do: [ :i | 
			kmeans
				value: randomPoint value
				value: randomPoint value
				value: randomPoint value ]
		displayingProgress: [ :i | i asString , '/100' ].
	^ kmeans
		value: cluster1 average
		value: cluster2 average
		value: cluster3 average
]

{ #category : #examples }
MiscVisualizations >> pascal [
	<gtExample>
	| b p |
	p := RTPalette c6.
	b := RTCircularTreeMapBuilder new.
	b shape
		if: [ :aPoint | aPoint  binomial odd ]
			fillColor: [ p first ];
		if: [ :aPoint | aPoint  binomial even ]
			fillColor: [ p second ].
	b
		baseradius: 400;
		weight: [ :aPoint | aPoint binomial ].
	b
		explore: 0 @ 0
		using: [ :n | 
			n < (8 @ 8)
				ifTrue: [ Array with: n + (1 @ 0) with: n + (1 @ 1) ]
				ifFalse: [ #() ] ].
	b build.
	^ b view
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
MiscVisualizations >> stirlingII [
	<gtExample>
	| b p |
	p := RTPalette c6.
	b := RTCircularTreeMapBuilder new.
	b shape
		if: [ :aPoint | aPoint stirlingII odd ] fillColor: [ p first ];
		if: [ :aPoint | aPoint stirlingII even ] fillColor: [ p second ].
	b
		baseradius: 400;
		weight: #stirlingII .
	b
		explore: 0 @ 0
		using: [ :n | 
			n < (8 @ 8)
				ifTrue: [ Array with: n + (1 @ 0) with: n + (1 @ 1) ]
				ifFalse: [ #() ] ].
	b build.
	^ b view
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

{ #category : #examples }
MiscVisualizations >> testWertzKoch [
	<gtExample>
	^ WertzKoch new view
]

{ #category : #examples }
MiscVisualizations >> testWertzLindenmayer [
	<gtExample>
	^ WertzLindenmayer  new view
]

{ #category : #examples }
MiscVisualizations >> testWertzLindenmayerAlgae [
	<gtExample>
	^ WertzLindenmayerAlgae new view
]

{ #category : #examples }
MiscVisualizations >> testWertzLindenmayerBracketedAnotherShrub [
	<gtExample>
	^ WertzLindenmayerBracketedAnotherShrub new view
]

{ #category : #examples }
MiscVisualizations >> testWertzLindenmayerBracketedBinaryTree [
	<gtExample>
	^ WertzLindenmayerBracketedBinaryTree new view
]

{ #category : #examples }
MiscVisualizations >> testWertzLindenmayerBracketedGrass [
	<gtExample>
	^ WertzLindenmayerBracketedGrass new view
]

{ #category : #examples }
MiscVisualizations >> testWertzLindenmayerBracketedPlant [
	<gtExample>
	^ WertzLindenmayerBracketedPlant new view
]

{ #category : #examples }
MiscVisualizations >> testWertzLindenmayerBracketedShrub [
	<gtExample>
	^ WertzLindenmayerBracketedShrub  new view
]

{ #category : #examples }
MiscVisualizations >> testWertzLindenmayerDragon [
	<gtExample>
	^ WertzLindenmayerDragon new view
]

{ #category : #examples }
MiscVisualizations >> testWertzLindenmayerGosper [
	<gtExample>
	^ WertzLindenmayerGosper new view
]

{ #category : #examples }
MiscVisualizations >> testWertzLindenmayerKoch [
	<gtExample>
	^ WertzLindenmayerKoch new view
]

{ #category : #examples }
MiscVisualizations >> testWertzLindenmayerSierpinski [
	<gtExample>
	^ WertzLindenmayerSierpinski  new view
]

{ #category : #examples }
MiscVisualizations >> testWertzPolygon [
	<gtExample>
	^ WertzPolygon new view
]

{ #category : #examples }
MiscVisualizations >> testWertzSeashell [
	<gtExample>
	^ WertzSeashell new view
]

{ #category : #examples }
MiscVisualizations >> testWertzSeashellElegant [
	<gtExample>
	^ WertzSeashellElegant new view
]

{ #category : #examples }
MiscVisualizations >> testWertzSeashellVaryingAngle [
	<gtExample>
	^ WertzSeashellVaryingAngle  new view
]

{ #category : #examples }
MiscVisualizations >> testWertzSierpinski [
	<gtExample>
	^ WertzSierpinski  new view
]

{ #category : #examples }
MiscVisualizations >> testWertzSierpinskiCurve [
	<gtExample>
	^ WertzSierpinskiCurve new view
]

{ #category : #examples }
MiscVisualizations >> testWertzSpiral [
	<gtExample>
	^ WertzSpiral new view
]

{ #category : #examples }
MiscVisualizations >> testWertzTree1 [
	<gtExample>
	^ WertzTree1 new view
]

{ #category : #examples }
MiscVisualizations >> testWertzTree2 [
	<gtExample>
	^ WertzTree2 new view
]

{ #category : #examples }
MiscVisualizations >> testWertzTree3 [
	<gtExample>
	^ WertzTree3 new
		times: 8;
		angleLeft: 20;
		angleRight: 29;
		view
]

{ #category : #examples }
MiscVisualizations >> testWertzTree3_bis [
	<gtExample>
	^ WertzTree3 new times: 7;angleLeft: 20; angleRight: -25;view
]
