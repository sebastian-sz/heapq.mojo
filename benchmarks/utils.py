import random

def get_array(size: int) -> list[int]:
    """A sequence of random integers."""
    random.seed(42)
    return [random.randint(-1 * 4096, 4096) for _ in range(size)]