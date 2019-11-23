Class {
	#name : #EUFERVizTest,
	#superclass : #TestCase,
	#category : #'Roassal2-Tests-Learning'
}

{ #category : #accessing }
EUFERVizTest >> firstProse [
	| dict text transformer |
	"Architecturally, the school has a Catholic character. Atop the Main Building's gold dome is a 
golden statue of the Virgin Mary. Immediately in front of the Main Building and facing it, is a copper statue of Christ with arms upraised with the legend ""Venite Ad Me Omnes"". Next to the Main Building is the Basilica of the Sacred Heart. Immediately behind the basilica is the Grotto, a Marian place of prayer and reflection. It is a replica of the grotto at Lourdes, France where the Virgin Mary reputedly appeared to Saint Bernadette Soubirous in 1858. At the end of the main drive (and in a direct line that connects through 3 statues and the Gold Dome), is a simple, modern stone statue of Mary."
	dict := NeoJSONReader
		fromString:
			'/Users/mn/Developer/working-copies/uni/EU-FER/EU-FER-Narratives/src/spacy/out.json'
				asFileReference contents.
	text := dict at: #text.
	transformer := [ :each | 
	each
		at: 'text'
		put: (text copyFrom: (each at: #start) + 1 to: (each at: #end)) ].
	"Adjusting desired subfields."
	(dict at: #ents) do: transformer.
	(dict at: #sents) do: transformer.
	(dict at: #tokens) do: transformer.
	^ dict
]

{ #category : #accessing }
EUFERVizTest >> firstViz [
	<gtExample>
	| v s es data tokens |
	data := self firstProse.
	tokens := data at: #tokens.
	v := RTView new.
	s := (RTRoundedBox new
		borderRadius: 5;
		borderColor: Color black;
		borderWidth: 0.5;
		yourself) + (RTLabel new text: [ :aDict | aDict at: #text ]).
	s allOfSameSize.
	es := s elementsOn: tokens.
	es @ RTDraggableChildren
		@ (RTPopup new text: [ :each | each at: #tagDecoded ]).
	RTEdgeBuilder new
		view: v;
		shape:
			(RTLine new
				attachPoint: RTShorterDistanceAttachPoint new;
				yourself) + (RTSimpleArrowHead new attachPoint: RTShorterDistanceAttachPoint new;
				yourself);
		elements: es;
		label: [ :from :to | (to at: #depDecoded) ifNil: [ to at: #dep ] ];
		connectFrom: [ :aDict | tokens at: (aDict at: #head) + 1 ].
	v addAll: es.
	v @ RTDraggableView.
	"RTRectanglePackLayout on: es."
	RTClusterLayout on: es.
	^ v
]
