from setuptools import setup

setup(
    name='wade-giles',
    version='1.0',
    packages=['pinyin_converter'],
    package_dir={'pinyin_converter': 'pinyin-converter'},
    entry_points={
        'console_scripts': [
            'wade-giles = pinyin_converter.pinyin_converter:main'
        ]
    },
    install_requires=[
        'argparse'
    ],
)
