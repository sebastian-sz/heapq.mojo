import time

import heapq
import utils_ as utils


fn main() raises:
    for N in List[Float32](1e2, 1e3, 1e4, 1e5, 1e6):
        var data = utils.get_array(int(N[]))
        var mean = _bench(data)
        print(N[], "->", mean)


fn _bench(data_: List[Int]) -> Float32:
    var data = List[Int](data_)  # Explicit copy
    heapq.heapify(data)

    # Warmup
    for _ in range(10):
        var d = List[Int](data)

        # Note on `reserve` below
        d.reserve(len(d) + 1)

        _ = heapq.heappush(d, -4099)

    # Benchmark
    var results = List[Float64]()
    for _ in range(1000):
        var d = List[Int](data)

        # Notice that we also must call `reserve`. When we copy Mojo List
        # it has exactly `len(data)` capacity, meaning if we append a single
        # element (which takes place in heappush) it will reallocate
        # and move all the data inside it. This will account for ~99% of the
        # time spent and not exactly what we want to benchmark.
        d.reserve(len(d) + 1)

        var start = time.now()
        heapq.heappush(d, -4099)
        var stop = time.now()

        var start_ms = start / 1e6
        var stop_ms = stop / 1e6
        results.append(stop_ms - start_ms)

    return utils.sum(results) / len(results)
