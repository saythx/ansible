#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import json
import urllib2
from elasticsearch import Elasticsearch

reload(sys)
sys.setdefaultencoding("utf8")


ES_IP = sys.argv[1]
ES_PORT = sys.argv[2]
def es_healthck():
  url = 'http://' + ES_IP + ':' + ES_PORT + '/_cluster/health?pretty=true'
  try:
    response =  urllib2.urlopen(urllib2.Request(url))
    data = response.read()
    if data:
      data = json.loads(data)
      es_status = data["status"]
      if es_status == "green":
        print 1
      else:
        print 0
  except BaseException as e:
    print 0

def es_searchck():
  if len(sys.argv) != 5:
    print "argvs error"
    sys.exit(0)
  INDEX_NAME = sys.argv[4]
  url = 'http://' + ES_IP + ':' + ES_PORT 
  es = Elasticsearch(url)
  data = {"query":{"term":{"details.name":"姚明"}}}
  try:
    es_reponse = es.search(index=INDEX_NAME,body=data)
    if es_reponse:
      print 1
  except BaseException as e:
    print 0

try:
  if sys.argv[3] == "es_healthck":
    es_healthck()
  elif sys.argv[3] == "es_searchck":
    es_searchck()
except BaseException as e:
  print 0
