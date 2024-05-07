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

"""Defines the heapq functionalities, which mimic the Python module.

```mojo
from heapq import heapify

var heap = List[Int](5,2,3,6,7)
heapify(heap)
print(heap)
```
"""

trait Comparable:
    """An element which can be greater or smaller than another element."""
    
    fn __lt__(self, other: Self) -> Bool:
        """Implements < (less than) operator."""
        pass
    
    fn __gt__(self, other: Self) -> Bool:
        """Implements > (greater than) operator."""
        pass

trait OrderedCollectionElement(CollectionElement, Comparable):
    """An Element which can exist in a collection with some specified order."""
    pass


fn heappush[T: OrderedCollectionElement](inout array: List[T], value: T):
    """
    Pushes the element onto the heap, maintaining structure and order properties.

    Parameters
    ----------
    array: A reference to the List.
        This List resembles the heap and will be updated in-place.
    value: 
        Value to be pushed.

    Examples
    ----------
    var heap = List[Int]()
    heapq.heappush(heap, 1)
    heapq.heappush(heap, 2)
    heapq.heappush(heap, 3)
    """
    array.append(value)

    var index  = len(array) - 1
    var parent_index = (index - 1) // 2

    while (index > 0 and value < array[parent_index]):
        array[index], array[parent_index] = array[parent_index], array[index]
        
        index = parent_index
        parent_index = (index - 1) // 2
