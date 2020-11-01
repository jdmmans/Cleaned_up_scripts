```python
import numpy as np ## load in numpy
import pandas as pd ## loading in panda commands
import fnmatch
```


```python
## loading in and preliminary manipulation
census = pd.read_csv('C:/Users/Julius/Downloads/census_religion.csv') ## test file location
census.set_index('SA1_7DIGITCODE_2016', inplace = True) ## replace default index number with the SA1 7 digit code
census = census.loc[census['Tot_P'] > 100] ## filter out all total populations below 100 , replaced prior has_people check
del census['Tot_P'] ## delete total population category
```


```python
## Creation of sub groupings for census output
census_filter = [col for col in census if col.endswith('_P')] ## only keep m+f data rather than having male and female only categories
filtered = fnmatch.filter(census_filter, '*Tot_P') ## find all overall category summary variables
census_filtered = census[[x for x in census_filter if x not in filtered]] ## only keep distinct categories
census_binned = census[[x for x in census_filter if x in filtered]] ## only keep overall categories
```


```python
## creating a CSV
census_binned.to_csv('C:/Users/Julius/Downloads/census_religion_binned.csv', sep=',')
census_filtered.to_csv('C:/Users/Julius/Downloads/census_religion_filtered.csv', sep=',')
```


```python
## Generating SA2 level data
## SA1 7 digit is a # State identifier then #### SA2 identifier then ## Sa1 identifier

## Load is new file due to avoid issue with slices and the like
census_filtered = pd.read_csv('C:/Users/Julius/Downloads/census_religion_filtered.csv')

# get list version of SA1 digits from census filtered, convert to string to allow taking specific characters
dfb = [str(i) for i in list(census_filtered['SA1_7DIGITCODE_2016'])] ## Make the SA1 into a list

# State identifier for each SA1 # test variable to check that the SA2 assignment was accurate
#State = [w[0] for w in dfb]

# SA2 identifier for each SA1
SA2 = [w[1:5] for w in dfb]

# SA1 idemtifier # test variable to check that the SA2 assignment was accurate
#SA1 = [w[5:7] for w in dfb]

# add in SA2 identifier to each line 
census_filtered['SA2'] = SA2

# delete SA1 column
del census_filtered['SA1_7DIGITCODE_2016']

# create filtered SA2 data from SA1
SA2_religious_filtered = census_filtered.groupby('SA2').sum()

# create variable for population in SA2
total_pop_SA2 = SA2_religious_filtered.sum(axis=1)
SA2_religious_filtered['tot_p'] = total_pop_SA2
print(SA2_religious_filtered)
```


```python
## use data to produce stats
secularism = list(SA2_religious_filtered['SB_OSB_NRA_NR_P']/SA2_religious_filtered['tot_p']) ## create % of population that is secular
SA2_religious_filtered['secularism'] = secularism ## join secular % to dataframe
SA2_religious_filtered2 = SA2_religious_filtered[(SA2_religious_filtered['secularism'] > 0.5)] ## select rows which have above 50% secularism
secular_SA2s = SA2_religious_filtered2.index ## take the index of items to get relevant SA2
```


```python
print(secular_SA2s)
```
