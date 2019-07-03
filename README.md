# roassal-visualizations

This repository collects some visualizations using the [Roassal](http://agilevisualization.com/) 
engine, all in *pure Smalltalk* lying on the [Pharo](http://pharo.org/) platform.

Before running the visualization it is mandatory to install __Roassal2__ from the `Catalog`.

## References and further pointers

In addition to the main references cited in the previous section, here we collect pointers to stuff that we desire to
explore and/or reproduce for the sake of understanding:

- *Mr. Voronyj joins Roassal* (talk, [part 1](https://www.youtube.com/watch?v=IUpndOXOsnY) and [part 2](https://www.youtube.com/watch?v=XsF3YaC1m_w)), slides available ([link](http://esug.org/data/ESUG2014/2%20tuesday/1500-1530%20Mr.%20Voronyj%20joins%20Roassal/PresVoronyjDiagram.pdf)) and a dedicate place is available ([link](http://natalia.tymch.uk/RTVoronyjDiagram/));
- something related to the previous point is here ([link](http://lists.pharo.org/pipermail/pharo-dev_lists.pharo.org/2014-August/099437.html)), whose suggests the video ([link](https://www.youtube.com/watch?v=CuimMwuZiGA&feature=youtu.be));
- Serge Stinckwich collects interesting gists ([link](https://gist.github.com/SergeStinckwich?direction=desc&sort=updated)) together with nice viz ([link](https://www.youtube.com/watch?v=tadvdsSC98w) for example).

More in general, I thread to be read ([link](https://www.reddit.com/r/smalltalk/comments/723kqr/what_do_you_do_with_pharosqueak/)) and a open search on youtube about Roassal ([link](https://www.youtube.com/results?search_query=roassal)).

## Hierarchical visualizations

This repository can be cloned and loaded with `Iceberg` and it contains the package `RoassalPlayground` which contains:

### Expandeable tree
- the class `DocumapsVisualizations` and, in turn, that class defines the (main) method `documaps` which declares the pragma `gtExample`; as usual, its visualization can be shown by clicking on the green little arrow on its left and it has the following characteristics:
  - it decouples the domain model from the visualization code so that we can reuse the code by plugging in blocks that can access a domain model. In my example I use FileReference objects: (i) a root directory and (ii) a block that given a FileReference object returns a collection of its children (using the hack you sent to me) which is invoked recursively;
  - it expands the tree according to a desired depth although for deep level the viz is quite slow. I lack some details on the rendering process, in particular I use for now a hack to center the camera for the initial view that can be surely improved;
  - it supports the recursive expansion on dynamically added nodes;
  - it uses few interactions such as transitions and pretty node shapes using padding.
  
![expandeable filetree viz](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/filetree.svg)

### Regression tree
Each box denotes a population of subjects where (i) its width is proportional to the number of subject in the corresponding
population and (ii) its height is proportial to the Residual Sum of Squares wrt the response variable. The following screenshot shows the interactive env during a sequence of consecutive *grow* moves:

![regression tree viz](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/regression-tree-during-grow-moves.png)

## Combinatorial visualizations

### Parity of Fibonacci numbers [A000045](https://oeis.org/A000045)
![parity of Fibonacci numbers](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/fibonacci.svg)

### Parity of the Pascal triangle [A007318](https://oeis.org/A007318)
![Parity of the Pascal triangle](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/pascal.svg)

### Parity of the Catalan triangle [A009766](https://oeis.org/A009766)
![Parity of the Catalan triangle](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/catalan.svg)

### Parity of the Stirling (II kind) triangle [A008277](https://oeis.org/A008277)
![Parity of the Stirling (II kind) triangle](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/stirlingII.svg)

## Fractals

### A ternary tree
Taken from https://ericclack.blogspot.com/2014/03/smalltalk-fractal-trees.html and generated using `BitBltPen` objects:
![Fractal tree](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/fractal-tree.png)
