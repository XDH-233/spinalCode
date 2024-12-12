import random

def random_data():
    r"""
    Random bytes
    """
    while True:
        yield random.randrange(256)



def get_bytes(nbytes: int, generator):
    """
    Get *nbytes* bytes from *generator*
    """
    return bytes(next(generator) for i in range(nbytes))