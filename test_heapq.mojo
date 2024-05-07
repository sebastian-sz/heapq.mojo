# MIT License

# Copyright (c) 2024 Sebastian Szymański

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.


from testing import assert_equal

import heapq

# TODO: tests cannot be fn?
# https://github.com/modularml/mojo/blob/00528f4c44f799966b3da0a866a00e24370c4b59/stdlib/test/collections/test_array.mojo
def main():
    """Run all tests."""
    test_heapq_push_on_empty()
    test_heapq_push_greater()
    test_heapq_push_smaller()
    test_heapq_push_multiple()


def test_heapq_push_on_empty():
    # given
    var heap = List[Int]()

    # when
    heapq.heappush(heap, 1)

    # then
    assert_equal(len(heap), 1)
    assert_equal(heap[0], 1)


def test_heapq_push_greater():
    # given
    var heap = List[Int]()

    # when
    heapq.heappush(heap, 1)
    heapq.heappush(heap, 2)

    # then
    assert_equal(len(heap), 2)
    assert_equal(heap[0], 1)


def test_heapq_push_smaller():
    # given
    var heap = List[Int]()

    # when
    heapq.heappush(heap, 2)
    heapq.heappush(heap, 1)

    # then
    assert_equal(len(heap), 2)
    assert_equal(heap[0], 1)

def test_heapq_push_multiple():
    # given
    var heap = List[Int]()
    var expected_heap = List[Int](2,4,3,6,5,7)  # Run the below pushes "by hand"

    # when
    heapq.heappush(heap, 5)
    heapq.heappush(heap, 6)
    heapq.heappush(heap, 7)
    heapq.heappush(heap, 4)
    heapq.heappush(heap, 3)
    heapq.heappush(heap, 2)

    # then
    assert_equal(len(heap), len(expected_heap))
    for idx in range(len(heap)):
        assert_equal(heap[idx], expected_heap[idx])
