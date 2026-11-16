
import math


def one_hot2bin(one_hot:int):
    oht_width = one_hot.bit_length()
    index_width = math.ceil(math.log2(oht_width))
    print(f"btm:{one_hot:b}")
    print(oht_width)
    print(index_width)
    ret = 0
    for ret_bit_id in range(0, index_width):
        b = None
        print(f"ret_bit_id:{ret_bit_id}")
        for bool_bit_id in range(0, oht_width):
            if (bool_bit_id >> ret_bit_id) & 1:
                print(f"bool_bit_id:{bool_bit_id}")
                tmp_bit = ((1 << bool_bit_id) & one_hot) >> bool_bit_id
                if b is None:
                    b = tmp_bit
                else:
                    b = b | tmp_bit
        ret = ret | (b << ret_bit_id)
    print(f"ret:{ret}")

one_hot2bin(1 << 0)