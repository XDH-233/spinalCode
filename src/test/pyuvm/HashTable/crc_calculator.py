#!/usr/bin/env python3
"""
CRC计算工具模块
支持常用的CRC算法：CRC-8, CRC-16, CRC-32, CCITT等
"""

class CRC:
    """CRC计算类"""
    
    def __init__(self, polynomial, initial_value, final_xor, input_reflected=False, output_reflected=False):
        """
        初始化CRC计算器
        
        Args:
            polynomial: CRC多项式
            initial_value: 初始值
            final_xor: 最终异或值
            input_reflected: 输入数据是否位反转
            output_reflected: 输出结果是否位反转
        """
        self.polynomial = polynomial
        self.initial_value = initial_value
        self.final_xor = final_xor
        self.input_reflected = input_reflected
        self.output_reflected = output_reflected
        
        # 预计算查表法加速
        self.table = self._generate_table()
    
    def _generate_table(self):
        """生成CRC查表"""
        table = []
        for i in range(256):
            crc = i << (self._get_bit_width() - 8)
            for _ in range(8):
                if crc & (1 << (self._get_bit_width() - 1)):
                    crc = (crc << 1) ^ self.polynomial
                else:
                    crc <<= 1
                crc &= (1 << self._get_bit_width()) - 1
            table.append(crc)
        return table
    
    def _get_bit_width(self):
        """获取CRC位数"""
        if self.polynomial <= 0xFF:
            return 8
        elif self.polynomial <= 0xFFFF:
            return 16
        else:
            return 32
    
    def _reflect(self, data, bits):
        """位反转"""
        reflected = 0
        for i in range(bits):
            if data & (1 << i):
                reflected |= 1 << (bits - 1 - i)
        return reflected
    
    def calculate(self, data):
        """
        计算CRC值
        
        Args:
            data: 输入数据（bytes或str）
        
        Returns:
            CRC值
        """
        if isinstance(data, str):
            data = data.encode('utf-8')
        
        crc = self.initial_value
        
        # 使用查表法计算
        for byte in data:
            if self.input_reflected:
                byte = self._reflect(byte, 8)
            
            if self._get_bit_width() == 8:
                crc = self.table[(crc ^ byte) & 0xFF] & 0xFF
            elif self._get_bit_width() == 16:
                table_index = ((crc >> 8) ^ byte) & 0xFF
                crc = ((crc << 8) ^ self.table[table_index]) & 0xFFFF
            else:  # 32-bit
                table_index = ((crc >> 24) ^ byte) & 0xFF
                crc = ((crc << 8) ^ self.table[table_index]) & 0xFFFFFFFF
        
        if self.output_reflected:
            crc = self._reflect(crc, self._get_bit_width())
        
        return crc ^ self.final_xor


class CRC8_CDMA2000:
    """CRC-8 算法"""
    
    @staticmethod
    def calculate(data):
        """CRC-8 (多项式: 56, 初始值: 12, 结果异或: 0x00)"""
        crc = CRC(0x9B, 0xFF, 0x00, False, False)
        return crc.calculate(data)


class CRC16:
    """CRC-16 算法"""
    
    @staticmethod
    def calculate(data):
        """CRC-16 (多项式: 0x8005, 初始值: 0x0000, 结果异或: 0x0000)"""
        crc = CRC(0x8005, 0x0000, 0x0000, True, True)
        return crc.calculate(data)


class CRC16_CCITT:
    """CRC-16-CCITT 算法"""
    
    @staticmethod
    def calculate(data):
        """CRC-16-CCITT (多项式: 0x1021, 初始值: 0xFFFF, 结果异或: 0x0000)"""
        crc = CRC(0x1021, 0xFFFF, 0x0000, False, False)
        return crc.calculate(data)


class CRC32:
    """CRC-32 算法"""
    
    @staticmethod
    def calculate(data):
        """CRC-32 (多项式: 0x04C11DB7, 初始值: 0xFFFFFFFF, 结果异或: 0xFFFFFFFF)"""
        crc = CRC(0x04C11DB7, 0xFFFFFFFF, 0xFFFFFFFF, True, True)
        return crc.calculate(data)


def main():
    """主函数 - 演示CRC计算"""
    import sys
    
    if len(sys.argv) < 2:
        print("用法: python crc_calculator.py <字符串或文件路径>")
        print("示例:")
        print("  python crc_calculator.py \"Hello World\"")
        print("  python crc_calculator.py test.txt")
        return
    
    input_data = sys.argv[1]
    
    # 判断是文件路径还是字符串
    try:
        with open(input_data, 'rb') as f:
            data = f.read()
        print(f"计算文件: {input_data}")
    except FileNotFoundError:
        data = input_data
        print(f"计算字符串: {input_data}")
    
    # 计算各种CRC值
    print(f"\nCRC计算结果:")
    print(f"CRC-8:     0x{CRC8_CDMA2000.calculate(data):02X}")
    print(f"CRC-16:    0x{CRC16.calculate(data):04X}")
    print(f"CRC-16-CCITT: 0x{CRC16_CCITT.calculate(data):04X}")
    print(f"CRC-32:    0x{CRC32.calculate(data):08X}")



def test_crc_calculations():
    """测试CRC计算"""
    rand_int = 0x4b8f6976e575f708
    standard = CRC8_CDMA2000.calculate("123456789")
    rand_str = CRC8_CDMA2000.calculate("4b8f6976e575f708")
    rand_byte = CRC8_CDMA2000.calculate(rand_int.to_bytes(8, byteorder='big', signed=False))
    print(f"CRC-8: {standard:02X}")
    print(f"CRC-8: {rand_str:02X}")
    print(f"CRC-8: {rand_byte:02X}")



if __name__ == "__main__":
    test_crc_calculations()
