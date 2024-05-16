# Introduction
This directory contains the micro-benchmark code, to compare the performance of
heapq operations in Mojo vs Python.

# How to run:
Build the package from the root of this repo and copy it here:

`rm -f heapq.mojopkg && cd .. && make build && mv heapq.mojopkg benchmarks/ && cd benchmarks/`

From then you can just run the corresponding `.py` and `.mojo` files, e.g:
`python3 heapify.py` or `mojo heapify.mojo`

# Results
TL;DR: The mojo implementation tends to be around order of magnitude faster, except for heappush, in which the performance degrades significantly. 

I suspect that the issue could be in Mojo's `List.append` method which, as of writing this document, is faster in Python (see benchmark for `append` below).

### Heapify

| N          | Python (ms) | Mojo (ms) | Speedup |
|------------|--------------|-----------|---------|
| 100        | 0.0021       | 0.0003    | 0.87    |
| 1 000      | 0.0246       | 0.0028    | 0.89    |
| 10 000     | 0.3065       | 0.0568    | 0.81    |
| 100 000    | 3.2284       | 0.7947    | 0.75    |
| 1 000 000  | 32.0393      | 7.6560    | 0.76    |

### Heappop
| N          | Python (ms) | Mojo (ms) | Speedup |
|------------|--------------|-----------|---------|
| 100        | 0.00023      | 0.00006   | 0.73    |
| 1 000      | 0.00052      | 0.00010   | 0.80    |
| 10 000     | 0.00044      | 0.00017   | 0.62    |
| 100 000    | 0.00053      | 0.00052   | 0.03    |
| 1 000 000  | 0.00379      | 0.00168   | 0.56    |

### Heappush
Heappush shows biggest performance divergence, I suspect due to List.append operation. Please see the benchmark on append below.
| N          | Python (ms) | Mojo (ms) | Speedup |
|------------|--------------|-----------|---------|
| 100        | 0.0005       | 0.0002    | 0.68    |
| 1 000      | 0.0003       | 0.0006    | -1.06   |
| 10 000     | 0.0007       | 0.0045    | -5.42   |
| 100 000    | 0.0006       | 0.0450    | -80.49  |
| 1 000 000  | 0.6097       | 0.6799    | -0.12   |

### Append
| N          | Python (ms) | Mojo (ms) | Speedup |
|------------|--------------|-----------|---------|
| 100        | 0.0001       | 0.0002    | -0.26   |
| 1 000      | 0.0001       | 0.0006    | -4.03   |
| 10 000     | 0.0002       | 0.0041    | -17.39  |
| 100 000    | 0.0002       | 0.0420    | -202.62 |
| 1 000 000  | 0.6009       | 0.6622    | -0.10   |


# Note on benchmark code
I specifically did not use the Mojo's benchmark module as I wanted these comparison's to be as similar as possible.