# roassal-visualizations

This repository collects some visualizations using the [Roassal](http://agilevisualization.com/) 
engine, all in *pure Smalltalk* lying on the [Pharo](http://pharo.org/) platform.

Before running the visualization it is mandatory to install __Roassal2__ from the `Catalog`.

This repository can be cloned and loaded with `Iceberg` and it contains the package `RoassalPlayground` which contains:

## Hierarchical visualizations

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
![expandeable filetree viz](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/fibonacci.svg)

### Parity of the Pascal triangle [A007318](https://oeis.org/A007318)
![expandeable filetree viz](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/pascal.svg)

### Parity of the Catalan triangle [A009766](https://oeis.org/A009766)
![expandeable filetree viz](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/catalan.svg)

### Parity of the Stirling (II kind) triangle [A008277](https://oeis.org/A008277)
![expandeable filetree viz](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/stirlingII.svg)


