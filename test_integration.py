import ctypes
import pytest

# Load the shared library
lib = ctypes.CDLL('./libexample.so')

# Define the argument and return types of the C functions
lib.add.argtypes = [ctypes.c_int, ctypes.c_int]
lib.add.restype = ctypes.c_int

lib.sum_array.argtypes = [ctypes.POINTER(ctypes.c_int), ctypes.c_int]
lib.sum_array.restype = ctypes.c_int

def test_add():
    assert lib.add(2, 3) == 5
    assert lib.add(0, 0) == 0
    assert lib.add(-1, 1) == 0

def test_sum_array():
    arr = (ctypes.c_int * 3)(1, 2, 3)
    assert lib.sum_array(arr, 3) == 8
    
    arr = (ctypes.c_int * 4)(-1, 1, -2, 2)
    assert lib.sum_array(arr, 4) == 0
    
    arr = (ctypes.c_int * 5)(0, 0, 0, 0, 0)
    assert lib.sum_array(arr, 5) == 0

if __name__ == "__main__":
    pytest.main()

