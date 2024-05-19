# Introduction
This directory contains the micro-benchmark code, to compare the performance of
heapq operations in Mojo vs Python.

I tried to make the benchmarks as similar / fair as possible.

# How to run:
Build the package from the root of this repo and copy it here:

`rm -f heapq.mojopkg && cd .. && make build && mv heapq.mojopkg benchmarks/ && cd benchmarks/`

From then you can just run the corresponding `.py` and `.mojo` files, e.g:
`python3 heapify.py` or `mojo heapify.mojo`

# Results
The mojo implementation tends to be around order of magnitude faster, compared to Python's equivalent implementation.

The benchmark for `heappush` might not be 100% fair, as there isn't a `reserve` equivalent for a Python list. See my explanation in the results for more info.

Below, the detailed results, measured on Ubuntu 22.04 and Mojo 24.3:

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
Heappush imo is the most difficult to compare **fairly** with Python.

Running `heappush` will call `.append` internally. This operation might cause memory reallocation. If we do not run `.reserve` on a Mojo List, the benchmark will unfairly favor Python, as Mojo's heappush will spend 99% time running reallocation **every time**.  
This operation is expensive, but in a real-world scenario, we expect this to happen rarely.

Contrary, if I do run `.reserve` in Mojo, the benchmark will unfairly treat Python, as Mojo has a guarantee that no reallocation happens, which I cannot guarantee for Python.  
Python doesn't have an option to preallocate, reserve, force or disable a list reallocation.

I decided to keep `.reserve` in `benchmarks/heappush.mojo` as it's closer to a real-world scenario, where the reallocations happen rarely. My advice, however, is to remember that this benchmark isn't 100% fair (I can't guarantee no realloc in Python) and take these numbers with a grain of salt. 

That being said, I think it's safe to assume that Mojo generally should also be faster for `heappush` as well.

| N          | Python (ms) | Mojo (ms) | Speedup |
|------------|--------------|-----------|---------|
| 100        | 0.00051      | 0.00006   | 0.88    |
| 1,000      | 0.00029      | 0.00007   | 0.77    |
| 10,000     | 0.00070      | 0.00009   | 0.87    |
| 100,000    | 0.00055      | 0.00038   | 0.31    |
| 1,000,000  | 0.60975      | 0.00157   | 1.00    |
