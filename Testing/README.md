# Testing

## Overview

This is a testing playground for devs. While developers are building the project, it's a good idea for them to test their code and visualize it as they go along but it might take too long to run the large scale code all at once. This folder is set up akin to a unit test and serves the same purpose. Here, developers can run some code and attempt to see if it would work with the rest of the service. All the developers need to do is paste the code into `testing.qmd` and then run using `quarto preview`. From there, they'll be able to see what the code would look like if it were to be run on the production build.

Alternatively developers are also able to run the entire project and maintain the same build locally as they go. From there, they can rebuild the site everytime they make changes and have the most accurate update on what everything looks like. This is akin to integration testing and also occurs prior to pushing to production pipeline.
