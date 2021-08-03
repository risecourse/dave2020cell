# dave2020cell
 [Dave et al 2020](https://link.springer.com/chapter/10.1007%2F978-981-15-7486-3_10) Single CA1 Pyramidal cell model

## Usage
To run this model, first compile the ion channel and synapse mechanisms.

1. Open a bash terminal (from within the NEURON Application)
2. `cd` into the model code folder
3. Type the command to compile the mechanisms:
* On Mac and Linux: `nrnivmodl`
* On Windows: `mknrndll`

### Stand-alone NEURON program
To launch the program from stand-alone NEURON software, in a bash terminal, enter:
    `nrngui mosinit66.hoc`
    
Once the NEURON program launches, it will open several windows and control dialogs. Find the _RunControl_ and push _Init & Run_ to run the simulation and see results on the graph.


### NEURON+Python in Spyder
Coming soon!
