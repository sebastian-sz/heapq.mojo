
import time

import heapq
import utils_ as utils


fn main() raises:
    for N in List[Float32](1e2, 1e3, 1e4, 1e5, 1e6):
        var data = utils.get_array(int(N[]))
        var mean_ms = _bench(data)
        print(N[], "->", mean_ms)

fn _bench(data: List[Int]) -> Float32:
    # Warmup
    for _ in range(10):
        var d = List[Int](data)
        heapq.heapify(d)
    
    # Benchmark
    var results = List[Float64]()
    for _ in range(1000):
        var d = List[Int](data)

        var start = time.now()
        heapq.heapify(d)
        var stop = time.now()

        var start_ms = start / 1e6
        var stop_ms = stop / 1e6
        results.append(stop_ms - start_ms)
    
    return utils.sum(results) / len(results)

