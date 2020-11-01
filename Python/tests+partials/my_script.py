#!/usr/bin/env python
# coding: utf-8

# In[15]:


# setting target file variable in command line

import argparse
import pandas as pd
from types import SimpleNamespace

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description = 'test script for loading in variables')
    parser.add_argument('--census', help = "census SA1 level data in CSV format to manipulate")
    args = parser.parse_args()
    census1 = args.census


# In[10]:


print(pd.read_csv(census1))


# In[ ]:




