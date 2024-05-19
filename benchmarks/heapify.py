import time
import heapq

import utils

def main():
    for N in [1e2, 1e3, 1e4, 1e5, 1e6]:
        data = utils.get_array(int(N))
        mean_ms = _benchmark(data)
        print(N, "->", mean_ms)


def _benchmark(data: list[int]) -> float:
    # Warmup
    for _ in range(10):
        d = data.copy()
        heapq.heapify(d)
    
    # Benchmark
    results = []
    for _ in range(1000):
        d = data.copy()

        start = time.perf_counter_ns()
        heapq.heapify(d)
        stop = time.perf_counter_ns()
        
        start_ms, stop_ms = start / 1e6, stop / 1e6
        results.append(stop_ms - start_ms)

    return sum(results) / len(results)



if __name__ == "__main__":
    main()

