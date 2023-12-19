import argparse

"""TODO: dic-full & 3d type

"""
    wadegiles -p taibei,gaoxiong
    >>>taipei,kaohsiung
    wadegiles -w taipei
    >>>taibei
    wadegiles -h
"""
pinyin_to_wade = {
    'a': 'a',
    'ai': 'ai',
    'an': 'an',
    'ang': 'ang',
    'ao': 'ao',
    'ba': 'pa',
    'bai': 'pai',
    'ban': 'pan',
    'bang': 'pang',
    'bao': 'pao',
    'bei': 'pei',
    'ben': 'pen',
    'beng': 'peng',
    'bi': 'pi',
    'bian': 'pien',
    'biao': 'piao',
    'bie': 'pieh',
    'bin': 'pin',
    'bing': 'ping',
    'bo': 'po',
    'bu': 'pu',
    'ca': 'ts\'a',
    'cai': 'ts\'ai',
    'can': 'ts\'an',
    'cang': 'ts\'ang',
    'cao': 'ts\'ao',
    'ce': 'ts\'e',
    'cen': 'ts\'en',
    'ceng': 'ts\'eng',
    'cha': 'ch\'a',
    'chai': 'ch\'ai',
    'chan': 'ch\'an',
    'chang': 'ch\'ang',
    'chao': 'ch\'ao',
    'che': 'ch\'e',
    'chen': 'ch\'en',
    'cheng': 'ch\'eng',
    'chi': 'ch\'ih',
    'chong': 'ch\'ung',
    'chou': 'ch\'ou',
    'chu': 'ch\'u',
    'chua': 'ch\'ua',
    'chuai': 'ch\'uai',
    'chuan': 'ch\'uan',
    'chuang': 'ch\'uang',
    'chui': 'ch\'ui',
    'chun': 'ch\'un',
    'chuo': 'ch\'o',
    'ci': 'tz\'u',
    'cong': 'ts\'ung',
    'cou': 'ts\'ou',
    'cu': 'ts\'u',
    'cuan': 'ts\'uan',
    'cui': 'ts\'ui',
    'cun': 'ts\'un',
    'cuo': 'ts\'o',
    'da': 'ta',
    'dai': 'tai',
    'dan': 'tan',
    'dang': 'tang',
    'dao': 'tao',
    'de': 'te',
    'dei': 'tei',
    'den': 'ten',
    'deng': 'teng',
    'di': 'ti',
    'dia': 'tia',
    'dian': 'tien',
    'diao': 'tiao',
    'die': 'tieh',
    'ding': 'ting',
    'diu': 'tiu',
    'dong': 'tung',
    'dou': 'tou',
    'du': 'tu',
    'duan': 'tuan',
    'dui': 'tui',
    'dun': 'tun',
    'duo': 'to',
    'e': 'o',
    'ei': 'ei',
    'en': 'ên',
    'eng': 'êng',
    'er': 'êrh',
    'fa': 'fa',
    'fan': 'fan',
    'fang': 'fang',
    'fei': 'fei',
    'fen': 'fen',
    'feng': 'feng',
    'fo': 'fo',
    'fou': 'fou',
    'fu': 'fu',
    'ga': 'ka',
    'gai': 'kai',
    'gan': 'kan',
    'gang': 'kang',
    'gao': 'kao',
    'ge': 'ko',
    'gei': 'kei',
    'gen': 'ken',
    'geng': 'keng',
    'gong': 'kung',
    'gou': 'kou',
    'gu': 'ku',
    'gua': 'kua',
    'guai': 'kuai',
    'guan': 'kuan',
    'guang': 'kuang',
    'gui': 'kuei',
    'gun': 'kun',
    'guo': 'kuo',
    'ha': 'ha',
    'hai': 'hai',
    'han': 'han',
    'hang': 'hang',
    'hao': 'hao',
    'he': 'ho',
        }

wade_to_pinyin = {v: k for k, v in pinyin_to_wade.items()}

def convert_to_pinyin(wade):
    pinyin = []
    wade = wade.split()
    for w in wade: 
        if w in wade_to_pinyin:
            pinyin.append(wade_to_pinyin[w])
        else:
            pinyin.append(w)
    return " ".join(pinyin)

def convert_to_wade(pinyin):
    wade = []
    pinyin = pinyin.split()
    for p in pinyin:
        if p in pinyin_to_wade:
            wade.append(pinyin_to_wade[p])
        else:
            wade.append(p)
    return " ".join(wade)

def main():
    parser = argparse.ArgumentParser(description='Convert Between Wade-Giles Pinyin to Pinyin')
    parser.add_argument('input',type=str, help='Input Text')
    parser.add_argument('-w', '--wade', action='store_true', help='Convert to Wade-Giles Pinyin')
    parser.add_argument('-p', '--pinyin', action='store_true', help='Convert to Pinyin')
    args = parser.parse_args()

    if args.wade:
        result = convert_to_wade(args.input)
    elif args.pinyin:
        result = convert_to_pinyin(args.input)
    else:
        parser.print_help()
        return
    print(result)

if __name__ == '__main__': 
    main()
