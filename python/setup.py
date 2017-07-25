#!/usr/bin/env python
from setuptools import setup, find_packages
from os import path

here = path.abspath(path.dirname(__file__))

long_description = "DataJoint schemas and analysis for visual stimuli."


setup(
    name='stimline',
    version='0.1.0.dev1',
    description="data processing chain for MICrONS project team ninai",
    long_description=long_description,
    author='Fabian Sinz, Dimitri Yatsenko, Jiakun Fu',
    athor_email='jiakun.fu.bcm@gmail.com',
    license="GNU LGPL",
    url='https://github.com/cajal/stimuli',
    keywords='neuroscientific data processing',
    packages=find_packages(exclude=['contrib', 'docs', 'tests*']),
    install_requires=['numpy','sh','matplotlib','pandas','seaborn','scipy','imageio'],
    classifiers=[
        'Development Status :: 1 - Beta',
        'Intended Audience :: Science/Research',
        'Programming Language :: Python :: 3 :: Only',
        'License :: OSI Approved :: GNU LGPL',
        'Topic :: Database :: Front-Ends',
    ],
)

