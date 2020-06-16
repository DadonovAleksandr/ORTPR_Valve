repl = [
  ['DataOut.', 'OutParam.'],
  ['DataIn.', 'InParam.'],
  ['Cmd_SetRepair', 'Cmd_SetRem'],
  ['Cmd_SetMan', 'Cmd_SetRuch'],
  ['FM_Man', 'FM_Ruch'],
  ['FM_Repair', 'FM_Rem']
]

# std import:
import os
import sys
import glob
from pprint import pprint
from functools import *
from typing import *
from copy import *


def GetFileContent(fileName, encoding='utf-8-sig'):
  """ возвращает строку с текстовым содержимым файла (в нужной кодировке) """
  try:
    with open(fileName, 'r', encoding=encoding) as f:
      return str(f.read())
  except IOError:
    return ''

def WriteTextToFile(fileName, text, encoding='utf-8-sig'):
  with open(fileName, 'w', encoding=encoding) as f:
      f.write(text)

def ReplaceText(text, replaceArray):
  for i in replaceArray:
    text = text.replace(i[0], i[1], 10000)
  return text

def GetFileList(searchMask='*.vsd.st'):
  ''' получить список файлов '''
  r = []
  for ff in glob.glob(searchMask):
    r = r + [ff]
  return r

print(GetFileList())

for f in GetFileList():
  t = GetFileContent(f)
  t2 = ReplaceText(t, repl)
  #if t != t2:
  WriteTextToFile(f+'.fix', t2)
  print(t2)
