# Introduction
Python's heapq module rewritten in Mojo.

# How to use
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
if v:   # NOTE: Optional value (None if empty)
    print(v.take())
```

Currently, only `heapify`, `heappush` and `heappop` are implemented.

# Installation
 
### Option 1:
Download the `heapq.mojopkg` from release page and use it directly.

### Option 2:
Just download the `heapq.mojo` file from this repository.

# Performance
Mojo implementation tends to be faster, except for heappush, which shows performance degradation. See `benchmarks/` directory for more details.

# Personal note
I mostly wrote this mini-project to see how Mojo feels like.

I definitely like the tooling, like `mojo test`, especially for such new language. There are some sharp edges here and there but overall the feeling is very positive.

If you spot any issues, feel free to let me know!
