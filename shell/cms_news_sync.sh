#!/bin/bash
newsNum=$(mysql -h 172.19.7.134 -N -u root -p'!QAZxsw2134'  -e 'select id from cms.news order by id desc limit 1;' | sed '2p')
echo ${newsNum}
news_detailNum=$(mysql -h 172.19.7.134 -N  -u root -p'!QAZxsw2134'  -e 'select id from cms.news_detail order by id desc limit 1;' | sed '2p')
echo ${news_detailNum}
news_push_columnNum=$(mysql -h 172.19.7.134 -N  -u root -p'!QAZxsw2134'  -e 'select id from cms.news_push_column order by id desc limit 1;' | sed '2p')
echo ${news_push_columnNum}
mysqldump -h 10.1.11.69 --skip-add-drop-table -t -uroot -p'P1(7j+2%' cms news_push_column --where="id>${news_push_columnNum}">cms_news_push_column.sql
mysqldump -h 10.1.11.69 --skip-add-drop-table -t -uroot -p'P1(7j+2%' cms news_detail --where="id>${news_detailNum}">cms_news_detail.sql
mysqldump -h 10.1.11.69 --skip-add-drop-table -t -uroot -p'P1(7j+2%' cms news --where="id>${newsNum}">cms_news.sql
sed -i 's/piccms.greensr.suneee.com/web.suneee.weilian.cn/g' ./*.sql
sed -i 's/greensr.suneee.com/web.suneee.weilian.cn/g' ./*.sql
grep -r green cms_news.sql
mysql -h '172.19.7.134' -u'root' -p'!QAZxsw2134' -e 'use cms;source cms_news.sql;source cms_news_detail.sql;source cms_news_push_column.sql;'
