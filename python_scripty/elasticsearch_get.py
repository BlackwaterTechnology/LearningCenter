from urllib import request

with request.urlopen('http://172.19.6.50:9200/blog/article/2?pretty') as f:
    data = f.read()
    print(type(data))
    print('data:', data.decode('utf-8') )
    # print(type(data.decode('gbk')))