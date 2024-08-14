import ctypes
import pytest

# Load the shared library
lib = ctypes.CDLL('./libexample.so')

# Define the argument and return types of the C function
lib.add.argtypes = [ctypes.c_int, ctypes.c_int]
lib.add.restype = ctypes.c_int

def test_add():
    assert lib.add(2, 3) == 5
    assert lib.add(0, 0) == 0
    assert lib.add(-1, 1) == 0

if __name__ == "__main__":
    pytest.main()

