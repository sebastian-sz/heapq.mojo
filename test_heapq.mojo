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


from testing import assert_equal, assert_false, assert_true
from testing.testing import Testable

import heapq


# Utility for list comparison
trait _TestableCollectionElement(Testable, CollectionElement):
    pass


def _assert_list_equal[
    T: _TestableCollectionElement
](lhs: List[T], rhs: List[T]):
    assert_equal(len(lhs), len(rhs), "Lists have different sizes.")
    for i in range(len(lhs)):
        assert_equal(lhs[i], rhs[i], "List mismatch at index " + str(i))


def test_heapq_push_on_empty():
    # given
    var heap = List[Int]()

    # when
    heapq.heappush(heap, 1)

    # then
    _assert_list_equal(heap, List[Int](1))


def test_heapq_push_greater():
    # given
    var heap = List[Int]()

    # when
    heapq.heappush(heap, 1)
    heapq.heappush(heap, 2)

    # then
    _assert_list_equal(heap, List[Int](1, 2))


def test_heapq_push_smaller():
    # given
    var heap = List[Int]()

    # when
    heapq.heappush(heap, 2)
    heapq.heappush(heap, 1)

    # then
    _assert_list_equal(heap, List[Int](1, 2))


def test_heapq_push_multiple():
    # given
    var heap = List[Int]()

    # when
    heapq.heappush(heap, 5)
    heapq.heappush(heap, 6)
    heapq.heappush(heap, 7)
    heapq.heappush(heap, 4)
    heapq.heappush(heap, 3)
    heapq.heappush(heap, 2)

    # then
    _assert_list_equal(
        heap, List[Int](2, 4, 3, 6, 5, 7)  # Run the above pushes "by hand"
    )


def test_heappop_empty_heap():
    # given
    var heap = List[Int]()

    # when
    var value = heapq.heappop(heap)

    # then
    assert_false(value)


def test_heappop_only_root():
    # given
    var heap = List[Int](1)

    # when
    var popped = heapq.heappop(heap)

    # then
    assert_true(popped)
    assert_equal(popped.take(), 1)  # take unwraps <optional>


def test_heappop_node_with_one_child():
    # given
    var heap = List[Int](1, 2)

    # when
    var popped = heapq.heappop(heap)

    # then
    assert_true(popped)
    assert_equal(popped.take(), 1)
    _assert_list_equal(heap, List[Int](2))


def test_heappop_node_with_two_children():
    # given
    var heap = List[Int](1, 2, 3)

    # when
    var popped = heapq.heappop(heap)

    # then
    assert_true(popped)
    assert_equal(popped.take(), 1)
    _assert_list_equal(heap, List[Int](2, 3))


def test_heappop_duplicate_values():
    # given
    var heap = List[Int](2, 2, 3, 3)

    # when
    var popped = heapq.heappop(heap)

    # then
    assert_true(popped)
    assert_equal(popped.take(), 2)
    _assert_list_equal(heap, List[Int](2, 3, 3))


def test_heappop_multiple_swaps():
    # given

    var heap = List[Int](1, 2, 3, 4, 5, 6, 7)

    # popping 1 puts 7 as root ("7,2,3,4,5,6"), 7 has 2 children: 2 and 3
    # 7 gets swapped with 2    ("2,7,3,4,5,6"), 7 has 2 children: 4 and 5
    # 7 gets swapped with 4    ("2,4,3,7,5,6"), heap is balanced -> end.
    var expected = List[Int](2, 4, 3, 7, 5, 6)

    # when
    var popped = heapq.heappop(heap)

    # then
    assert_true(popped)
    assert_equal(popped.take(), 1)
    _assert_list_equal(heap, expected)
