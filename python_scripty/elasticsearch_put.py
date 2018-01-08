import urllib.request
import urllib.parse
import datetime
import json

# DATA = {
#     "article" : "Index and Query a Document",
#     "post_date" : datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
#     "content" : "Let’s now put something into our customer index. We’ll index a simple customer document into the customer index, with an ID of 1 as follows"
# }
DATA={
  "article": "application json"
}
data=json.dumps(DATA)
print(type(data))
data = urllib.parse.urlencode( data )
data = data.encode('utf-8')
print(type(data))
req = urllib.request.Request(url='http://172.19.6.50:9200/blog/article/5',data=data, method='PUT',headers={'Content-Type':'application/json'})
with urllib.request.urlopen(req) as f:
    pass
print(f.status)
print(f.reason)