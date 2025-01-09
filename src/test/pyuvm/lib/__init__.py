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


def gaussian(mean, sigma):
    """
    Generate a Gaussian distribution indefinitely
    Args:
        mean (int/float): mean value
        sigma (int/float): Standard deviation
    .. deprecated:: 1.4.1
    """
    while True:
        yield random.gauss(mean, sigma)


def random_50_percent(mean=10, sigma=None):
    """50% duty cycle with random width
    Args:
        mean (int, optional): Average number of cycles on/off
        sigma (int, optional): Standard deviation of gaps.  mean/4 if sigma is None
    """
    if sigma is None:
        sigma = mean / 4.0
    for duration in gaussian(mean, sigma):
        yield int(abs(duration)), int(abs(duration))

def random_n_percent(n, mean=10, sigma=None): # 0 < n < 100
    if sigma is None:
        sigma = mean / 4.0
    on_duration = mean * (n / 100.0)
    off_duration = mean * ((100 - n) / 100.0)

    for on_time, off_time in zip(gaussian(on_duration, sigma), gaussian(off_duration, sigma)):
        yield int(abs(on_time)), int(abs(off_time))
