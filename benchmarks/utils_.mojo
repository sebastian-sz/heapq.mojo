from python import Python

fn get_array(N: Int) raises -> List[Int]:
    """Get Python-equivalent array of random ints."""
    var random = Python.import_module("random")
    random.seed(42)
    
    var data = List[Int]()
    data.reserve(N)
    for _ in range(N):
        var number: Int = int(random.randint(-1 * 4096, 4096))
        data.append(number)
    return data


fn sum(arr: List[Float64]) -> Float64:
    var result = 0.0
    for e in arr:
        result += e[]
    return result