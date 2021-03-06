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
    
Once the NEURON program launches, it will open several windows and control dialogs. 
1. Find the small window with buttons for SINGLE, DOUBLE, and ALPHA. Click one of the buttons to select the synapse model type
2. Find the **RunControl** panel and push **Init & Run** to run the simulation and see results on the graph.
3. In the upper left corner of the graph window, click the square to show a menu and then select View > View = Plot to zoom into the plotted results


### NEURON+Python in Spyder
Coming soon!
