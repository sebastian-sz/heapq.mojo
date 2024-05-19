# Introduction
Python's heapq module rewritten in Mojo.

# Quickstart
The usage is meant to mimic Python as much as possible:

```mojo
import heapq

var heap = List[Int](3,2,1)

# Transform the list in-place
heapq.heapify(heap)

# Push to the heap
heapq.heappush(heap, -1)

# Pop from the heap 
var v = heapq.heappop(heap)
if v:   # NOTE: Optional value (None if heap's empty)
    print(v.take())
```

Currently, only `heapify`, `heappush` and `heappop` are implemented.

The only major difference compared to Python is that `heappop` won't raise an exception on empty heap. Rather, an [optional](https://docs.modular.com/mojo/stdlib/collections/optional/) is returned, that is `None` if the list is empty.

# Installation
This is a single-file module, so the installation should be trivial:

* Option A: pull the repo, build the `heapq.mojopkg` (`make build`) and use that.
* Option B: download `heapq.mojo` and use the file directly.

If all goes well, you should be able to `import heapq` in mojo.

# Performance
Mojo implementation is faster Python, usually by the order of ~10x. For detailed analysis, please see [benchmarks/](benchmarks/) directory.

# Compatibility
As of writing this repository, the Mojo language is rapidly evolving. I'm using the `24.3` version and will try to keep this compatible. If something isn't working don't hestitate to open an issue.

# Motivation
I wrote this mini-project as I think that it's the best way get familiar with a new language. There are [existing implementations of a priority queue in Mojo](https://github.com/dimitrilw/toybox/blob/7d354dc53d435d58173e7c355882264d00478d06/toybox/heap.mojo#L10), but I did it for practice anyway. It was really enjoyable to work with the tooling (mojo test, mojo format, mojo package) despite how new and young the language is.

Mojo's philosophy is to be compatible / similar to Python, so I kept the Python's approach to heapq - operate directly on an array. I think this is an interesting alternative to having a class (although, given these functions, a class could be easily added).

The only thing I wish for would be a proper CI/CD pipeline that would run the tests/formatting on each PR. Currently, there is no official way to install Mojo in a separate environment (e.g. Docker). I could probably try to replicate the [solution from Mojo's stdlib](https://github.com/modularml/mojo/blob/bf73717d79fbb79b4b2bf586b3a40072308b6184/.github/workflows/examples.yml#L43-L48), or use deprecated features, but I'd rather wait till something stable comes out.
