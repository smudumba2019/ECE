# -*- coding: utf-8 -*-
"""PS1_Code.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/14Qz9F0m3fIvcun6RajquR7E8IOfAXsJD
"""

# ECE 695 DEEP LEARNING 
# PROBLEM SET 1
# Written By: Sai V. Mudumba
# Date Created: 01/28/2021
# Date Last Modified: 01/31/2021

import random
import string

random.seed(0) # initialize the random number generator seed with 0

# ------------- create an empty array --------------
names = []
first_names = []
middle_names = []
last_names = []

# ------------ create a 5 letter random string, 30 of them -------
for i in range(0,30):
  temp_str = ""
  for j in range(0,5):
    letter = random.choice(string.ascii_lowercase) # generates a random string from a string of ascii lowercase letters 
    temp_str += letter # appends each letter to the string

  names.append(temp_str) # appends each string to the name arrays

first_names[0:10] = names[0:10]
middle_names[0:10] = names[10:20]
last_names[0:10] = names[20:30]

# ------------- print the arrays ------------------------
#print(first_names)
#print(middle_names)
#print(last_names)

# -------------- class People --------------
class People:
  def __init__(self, first_names, middle_names, last_names, write_first):
    self.first_names = first_names
    self.middle_names = middle_names
    self.last_names = last_names
    self.write_first = write_first

# ------------- Iterator method -----------------------
  def __iter__(self):
    self.n = 0
    return self
  def __next__(self):
    if self.write_first == "first_name_first": 
      while self.n < 10:
        print(self.first_names[self.n] + ' ' + self.middle_names[self.n] + ' ' + self.last_names[self.n]) 
        self.n += 1
      print("")
    elif self.write_first == "last_name_first": 
      while self.n < 10:
        print(self.last_names[self.n] + ' ' + self.first_names[self.n] + ' ' + self.middle_names[self.n]) 
        self.n += 1
      print("")
    elif self.write_first == "last_name_with_comma_first": 
      while self.n < 10:
        print(self.last_names[self.n] + ', ' + self.first_names[self.n] + ' ' + self.middle_names[self.n]) 
        self.n += 1 
      print("")

# ------------ sorted last names ------------------------
  def __call__(self):
    for i in range(0,10):
      sortedstr = ''.join(sorted(self.last_names[i]))
      print(sortedstr)
    return ""

# --------- subclass PeopleWithMoney ---------------------
class PeopleWithMoney(People):
  def __init__(self, first_names, middle_names, last_names, write_first, wealth):
    People.__init__(self, first_names, middle_names, last_names, write_first)
    self.wealth = [str(intgr) for intgr in wealth]


  def __iter__(self):
    self.n = 0
    return self

  def __next__(self):
    if self.write_first == "first_name_first":
      while self.n < 10:
        print(self.first_names[self.n] + ' ' + self.middle_names[self.n] + ' ' + self.last_names[self.n] + ' ' + self.wealth[self.n]) 
        self.n += 1
      print("")
  
  def __call__(self):
    idx = [i[0] for i in sorted(enumerate(wealth), key=lambda x:x[1])]
    for i in range(0,9):
      txt = self.first_names[idx[i]] + ' ' + self.middle_names[idx[i]] + ' ' + self.last_names[idx[i]] + ' ' + self.wealth[idx[i]]
      print(txt)
    i = idx[9]
    return self.first_names[i] + ' ' + self.middle_names[i] + ' ' + self.last_names[i] + ' ' + self.wealth[i]

PI1 = People(first_names, middle_names, last_names,"first_name_first")
PI2 = People(first_names, middle_names, last_names,"last_name_first")
PI3 = People(first_names, middle_names, last_names,"last_name_with_comma_first")

wealth = random.sample(range(0,1000),10)
PIW1 = PeopleWithMoney(first_names, middle_names, last_names, "first_name_first", wealth)

iter(PI1)
iter(PI2)
iter(PI3)

next(PI1)
next(PI2)
next(PI3)

print(PI1())

iter(PIW1)
next(PIW1)
print(PIW1())

