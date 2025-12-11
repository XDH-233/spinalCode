#!/usr/bin/env python3
"""
CRC计算测试脚本
"""

from HashTable.crc_calculator import CRC8, CRC16, CRC16_CCITT, CRC32

def test_crc_calculations():
    """测试CRC计算"""
    
    # 测试数据
    test_cases = [
        ("123456789", "CRC标准测试字符串"),
        ("Hello World", "普通字符串"),
        (b"\x01\x02\x03\x04", "二进制数据"),
    ]
    
    print("CRC计算测试:")
    print("=" * 60)
    
    for data, desc in test_cases:
        print(f"\n测试数据: {desc}")
        if isinstance(data, str):
            print(f"内容: {data}")
        else:
            print(f"内容: {data.hex()}")
        
        crc8 = CRC8.calculate(data)
        crc16 = CRC16.calculate(data)
        crc16_ccitt = CRC16_CCITT.calculate(data)
        crc32 = CRC32.calculate(data)
        
        print(f"CRC-8:       0x{crc8:02X} ({crc8})")
        print(f"CRC-16:      0x{crc16:04X} ({crc16})")
        print(f"CRC-16-CCITT:0x{crc16_ccitt:04X} ({crc16_ccitt})")
        print(f"CRC-32:      0x{crc32:08X} ({crc32})")
    
    # 验证已知的CRC值
    print("\n已知CRC值验证:")
    print("=" * 40)
    
    # "123456789" 的标准CRC值
    test_string = "123456789"
    print(f"测试字符串: {test_string}")
    
    # 验证CRC-8 (已知值应该是0xF4)
    expected_crc8 = 0xF4
    calculated_crc8 = CRC8.calculate(test_string)
    print(f"CRC-8:       0x{calculated_crc8:02X} {'✓' if calculated_crc8 == expected_crc8 else '✗'} (期望: 0x{expected_crc8:02X})")
    
    # 验证CRC-16 (已知值应该是0xBB3D)
    expected_crc16 = 0xBB3D
    calculated_crc16 = CRC16.calculate(test_string)
    print(f"CRC-16:      0x{calculated_crc16:04X} {'✓' if calculated_crc16 == expected_crc16 else '✗'} (期望: 0x{expected_crc16:04X})")
    
    # 验证CRC-16-CCITT (已知值应该是0x29B1)
    expected_crc16_ccitt = 0x29B1
    calculated_crc16_ccitt = CRC16_CCITT.calculate(test_string)
    print(f"CRC-16-CCITT:0x{calculated_crc16_ccitt:04X} {'✓' if calculated_crc16_ccitt == expected_crc16_ccitt else '✗'} (期望: 0x{expected_crc16_ccitt:04X})")
    
    # 验证CRC-32 (已知值应该是0xCBF43926)
    expected_crc32 = 0xCBF43926
    calculated_crc32 = CRC32.calculate(test_string)
    print(f"CRC-32:      0x{calculated_crc32:08X} {'✓' if calculated_crc32 == expected_crc32 else '✗'} (期望: 0x{expected_crc32:08X})")

def interactive_test():
    """交互式测试"""
    print("\n交互式CRC计算:")
    print("=" * 40)
    
    while True:
        try:
            user_input = input("\n请输入字符串 (或输入 'quit' 退出): ")
            if user_input.lower() == 'quit':
                break
            
            if not user_input:
                continue
            
            print(f"计算CRC值: '{user_input}'")
            print(f"CRC-8:       0x{CRC8.calculate(user_input):02X}")
            print(f"CRC-16:      0x{CRC16.calculate(user_input):04X}")
            print(f"CRC-16-CCITT:0x{CRC16_CCITT.calculate(user_input):04X}")
            print(f"CRC-32:      0x{CRC32.calculate(user_input):08X}")
            
        except KeyboardInterrupt:
            break
    
    print("\n测试结束!")

if __name__ == "__main__":
    test_crc_calculations()
    interactive_test()