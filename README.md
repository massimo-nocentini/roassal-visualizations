# roassal-visualizations

This repository collects some visualizations using the [Roassal](http://agilevisualization.com/) 
engine, all in *pure Smalltalk* lying on the [Pharo](http://pharo.org/) platform.

Before running the visualization it is mandatory to install __Roassal2__ from the `Catalog`.

This repository can be cloned and loaded with `Iceberg` and it contains the package `RoassalPlayground` which contains:
- the class `DocumapsVisualizations` and, in turn, that class defines the (main) method `documaps` which declares the pragma `gtExample`; as usual, its visualization can be shown by clicking on the green little arrow on its left and it has the following characteristics:
  - it decouples the domain model from the visualization code so that we can reuse the code by plugging in blocks that can access a domain model. In my example I use FileReference objects: (i) a root directory and (ii) a block that given a FileReference object returns a collection of its children (using the hack you sent to me) which is invoked recursively;
  - it expands the tree according to a desired depth although for deep level the viz is quite slow. I lack some details on the rendering process, in particular I use for now a hack to center the camera for the initial view that can be surely improved;
  - it supports the recursive expansion on dynamically added nodes;
  - it uses few interactions such as transitions and pretty node shapes using padding.
  
![expandeable filetree viz](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/expandeable-filetree.png)

A visualization of the sequence of Fibonacci numbers:
![expandeable filetree viz](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/fibonacci.svg)

A visualization of the sequence of the Pascal triangle:
![expandeable filetree viz](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/pascal.svg)

A visualization of the sequence of the Catalan numbers:
![expandeable filetree viz](https://github.com/massimo-nocentini/roassal-visualizations/blob/master/catalan.svg)


