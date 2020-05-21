# drake_docker



A basic RStudio server image enabled with [Drake] for R.

A number of data connectors have been included like:  
 - `RPostgreSQL` for connecting to PostgreSQL databases
 - `Hmisc` for importing from MS Access databases (on linux)
 - `fst` for saving and accessing fst datasets
 - `XLConnect` for advanced usage with MS Excel docs
 
The docker image does include a number of useful linux tools like  
 - `openssh-client` allowing you to transfer files to the container over ssh
 - `mdbtools` to support `Hmisc` in accessing MS Access files
 - `p7zip-full` to allow use with `.7z` files
 - `libzmq3-dev` [ZeroMQ](http://zeromq.org/) to support [`clustermq`](https://github.com/mschubert/clustermq) for parallelisation.
 
