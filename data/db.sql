-- MySQL dump 10.13  Distrib 5.7.35, for Linux (x86_64)
--
-- Host: localhost    Database: blog
-- ------------------------------------------------------
-- Server version	5.7.35-0ubuntu0.18.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `blog`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `blog` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `blog`;

--
-- Table structure for table `cate`
--

DROP TABLE IF EXISTS `cate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '' COMMENT '分类名',
  `intro` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cate`
--

LOCK TABLES `cate` WRITE;
/*!40000 ALTER TABLE `cate` DISABLE KEYS */;
INSERT INTO `cate` VALUES (11,'代码','源码'),(12,'开发备忘录','记录一些开发过程中常用的操作（软件安装，配置等）'),(13,'数据结构与算法','一些数据结构与算法的知识'),(14,'localCache','一个高性能的本地缓存库（Goland）'),(15,'Goland源码','Goland源码分析');
/*!40000 ALTER TABLE `cate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cate_id` int(11) DEFAULT NULL COMMENT '分类Id',
  `kind` int(11) DEFAULT NULL COMMENT '类型1-文章，2-页面',
  `status` int(11) DEFAULT NULL COMMENT '状态1-草稿，2-已发布',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `path` varchar(255) DEFAULT NULL COMMENT '访问路径',
  `summary` text COMMENT '摘要',
  `markdown` mediumtext COMMENT 'markdown内容',
  `richtext` mediumtext COMMENT '富文本内容',
  `allow` tinyint(4) DEFAULT '1' COMMENT '允许评论',
  `created` datetime DEFAULT NULL COMMENT '创建时间',
  `updated` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_post_path` (`path`),
  KEY `create_time` (`created`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (3,0,2,2,'友链','links','','> 站内自用\n\n[⛈](/dashboard/)\n\n[⛏](/page/tool)\n\n\n> 业余小项目\n[优选基金](http://www.lxcong.cn/fund)\n','<blockquote>\n<p>站内自用</p>\n</blockquote>\n<p><a href=\"/dashboard/\" target=\"_blank\">⛈</a></p>\n<p><a href=\"/page/tool\" target=\"_blank\">⛏</a></p>\n<blockquote>\n<p>业余小项目<br />\n<a href=\"http://www.lxcong.cn/fund\" target=\"_blank\">优选基金</a></p>\n</blockquote>\n',0,'2017-04-07 10:31:06','2022-01-16 20:25:06'),(4,0,2,2,'关于','about','','### Leo\n\n- 本科-东莞理工学院\n\n- 爱好看书`&`运动`&`写代码`&`学习新东西\n\n\n### 工作|经历\n- 2018年7月 - 2019年10月：深圳市宏电技术有限公司 · 嵌入式软件开发\n- 2019年10月 - 至今：深圳市信锐网科技术有限公司 · C/Go 后台开发\n\n### 项目|经验\n\n\n### 略懂一二\n更新于 201711\n\n![alt](/static/upload/20171105/fqh3Mk2VZquY5emNBswEO501.png)\n![alt](/static/upload/20171105/vY8akon14vyh0lGBO77lrXFN.png)\n### 证书\n- 2020年 “华为杯”第十七届中国研究生数学建模竞赛·二等奖\n	- 说明：选题F,飞行器质心平衡供油策略优化研究，\n	- 负责：探讨思路、代码求解、论文编写\n	\n\n### 联系我？\n- QQ：394101651\n\n- Email： 394101651@qq.com\n\n- Github：https://github.com/Leo-xcli','<h3><a id=\"Leo_0\"></a>Leo</h3>\n<ul>\n<li>\n<p>本科-东莞理工学院</p>\n</li>\n<li>\n<p>爱好看书<code>&amp;</code>运动<code>&amp;</code>写代码<code>&amp;</code>学习新东西</p>\n</li>\n</ul>\n<h3><a id=\"_7\"></a>工作|经历</h3>\n<ul>\n<li>2018年7月 - 2019年10月：深圳市宏电技术有限公司 · 嵌入式软件开发</li>\n<li>2019年10月 - 至今：深圳市信锐网科技术有限公司 · C/Go 后台开发</li>\n</ul>\n<h3><a id=\"_11\"></a>项目|经验</h3>\n<h3><a id=\"_14\"></a>略懂一二</h3>\n<p>更新于 201711</p>\n<p><img src=\"/static/upload/20171105/fqh3Mk2VZquY5emNBswEO501.png\" alt=\"alt\" /><br />\n<img src=\"/static/upload/20171105/vY8akon14vyh0lGBO77lrXFN.png\" alt=\"alt\" /></p>\n<h3><a id=\"_19\"></a>证书</h3>\n<ul>\n<li>2020年 “华为杯”第十七届中国研究生数学建模竞赛·二等奖\n<ul>\n<li>说明：选题F,飞行器质心平衡供油策略优化研究，</li>\n<li>负责：探讨思路、代码求解、论文编写</li>\n</ul>\n</li>\n</ul>\n<h3><a id=\"_25\"></a>联系我？</h3>\n<ul>\n<li>\n<p>QQ：394101651</p>\n</li>\n<li>\n<p>Email： 394101651@qq.com</p>\n</li>\n<li>\n<p>Github：https://github.com/Leo-xcli</p>\n</li>\n</ul>\n',1,'2017-04-07 10:31:28','2022-01-15 13:05:18'),(68,0,2,2,'  ','tool','','<script>\nvar nums=[\'\'];\nfunction get(){\nvar idx=Math.floor(Math.random()*nums.length);\ndocument.getElementById(\'ctn\').innerHTML=nums[idx];\n}\n</script>\n\n<p id=\"ctn\">----</p>\n<button onclick=\"get()\">  ☠️  </button>','&lt;script&gt;\nvar nums=[\'\'];\nfunction get(){\nvar idx=Math.floor(Math.random()*nums.length);\ndocument.getElementById(\'ctn\').innerHTML=nums[idx];\n}\n&lt;/script&gt;\n<p>----</p>\n&lt;button onclick=\"get()\"&gt;  ☠️  &lt;/button&gt;',0,'2018-09-10 11:12:43','2022-01-09 14:30:03'),(77,11,1,2,'C语言实现hash表','hash','','```\n/********************************************************************************\n\n **** Copyright (C), 2021, xx xx xx xx info&tech Co., Ltd.                ****\n\n ********************************************************************************\n * File Name     : hash.c\n * Author        : lxc\n * Date          : 2021-11-03\n * Description   : .C file function description\n * Version       : 1.0\n * Function List :\n * \n * Record        :\n * 1.Date        : 2021-11-03\n *   Author      : lxc\n *   Modification: Created file\n\n ********************************************************************************/\n#include <math.h>\n#include <stdio.h>\n#include <stdlib.h>\n\ntypedef struct{\n	int key;\n	int val;\n}DataType; //基本数据进行封装\n\n//一个节点，用于存储一个hash值 所对应的数据(链式结构解决hash冲突)\ntypedef struct{\n	DataType data;\n	struct HashNode * next; //链式结构\n}HashNode;\n\ntypedef struct{\n	int size;\n	HashNode *table;\n}HashMap,*hashmap;\n\n#define INT_MIN 0\n//创建一个hash表，将一个int数组，构建为hash，size为长度\nHashMap* CreateHashMap(int *nums,int size)\n{\n	HashMap *hashmap = (HashMap*) malloc(sizeof(HashMap));\n	hashmap->size = 2 * size;\n	//hash表分配空间\n	hashmap->table = (HashNode*) malloc(sizeof(HashNode) * hashmap->size);\n	//初始化\n	int j = 0;\n	for (j=0;j<hashmap->size;j++){\n		hashmap->table[j].data.val = INT_MIN;\n		hashmap->table[j].next = NULL;\n	}\n	int i = 0;\n	while (i < size){\n		//根据value计算其在hashMap中的位置\n		int pos = abs(nums[i])%hashmap->size;\n		//\n		if(hashmap->table[pos].data.val == INT_MIN){\n			//未冲突\n			//数组索引为key\n			hashmap->table[pos].data.key = i;\n			//元素值为value\n			hashmap->table[pos].data.val = nums[i];\n		}else{\n			//产生冲突\n			HashNode * lnode = (HashNode*) malloc(sizeof(HashNode));\n			HashNode * hashnode;\n			//存储当前的值\n			lnode->data.key = i;\n			lnode->data.val = nums[i];\n			lnode->next = NULL;\n\n			//从冲突未知开始，遍历链表\n			hashnode = &(hashmap->table[pos]);\n			//hashnode 一直走到链表尾部\n			while(hashnode->next != NULL){\n				hashnode = hashnode->next;\n			}\n			//将当前结点连接到链表尾部\n			hashnode->next=lnode;\n		}\n		i++;\n	}\n	//处理完成，返回HashMap\n	return hashmap;\n}\nint get(HashMap hashmap,int value)\n{\n	int pos = abs(value)%hashmap.size;\n	HashNode * hashnode = &(hashmap.table[pos]);\n	while(hashnode!= NULL){\n		if(hashnode->data.val == value)\n			return hashnode->data.key;\n		else\n			hashnode = hashnode->next; \n	}\n	//未找到\n	return -1;\n}\nint put(HashMap hashmap,int key, int value)\n{	\n	//计算出hash值\n	int pos =abs(value)%hashmap.size;\n	HashNode *node = &(hashmap.table[pos]);\n	//无hash冲突\n	if(node->data.val == INT_MIN){\n		node->data.key = key;\n		node->data.val = value;\n	}else{\n		//hashnode 一直走到链表尾部\n		while(node->next != NULL){\n			node = node->next;\n		}\n		HashNode *hnode=(HashNode *)malloc(sizeof(HashNode));\n		hnode->data.key=key;\n		hnode->data.val=value;\n		hnode->next=NULL;\n		node->next=hnode;\n	}\n	return 1;\n}\nvoid printHashMap(HashMap *hashmap)\n{	\n	printf(\"===========PrintHashMap==========\\n\");\n	int i = 0;\n	HashNode *node;\n	while(i<hashmap->size){\n		node = &(hashmap->table[i]);\n		while(node != NULL){\n			if(node->data.val != INT_MIN){\n				//这个节点已经被用户使用了\n				printf(\"%10d\",node->data.val);\n			}else{\n				//这个节点是初始化节点\n				printf(\"        [ ]\");\n			}\n			//继续下一个节点\n			node = node->next;\n		}\n		printf(\"\\n---------------------------------\");\n		//开始检索下一个 hash值\n		i++;\n		printf(\"\\n\");\n	}\n	printf(\"===============End===============\\n\");\n}\nvoid destoryHashMap(HashMap *hashmap)\n{\n	int i = 0;\n	HashNode * node;\n	HashNode * temp;\n	while(i<hashmap->size){\n		temp = hashmap->table[i].next;\n		node = hashmap->table[i].next;\n		while (node != NULL)\n		{	\n			temp=node->next;\n			//逐个释放结点空间，防止内存溢出\n            free(node);\n            node = temp;\n		}\n		i++;\n	}\n	free(hashmap->table);\n    free(hashmap);\n    printf(\"Destory hashmap Success!\");\n}\nint main(int argc, char **argv)\n{\n		int nums[]={34,54,32,32,56,78};\n		//创建HashMap\n   	    HashMap *hashmap=CreateHashMap(nums,6);\n    	//printHashMap(hashmap);\n    	//查找元素\n    	printf(\"value:%d  his index:%d\\n\",78,get(*hashmap,78));\n\n		put(*hashmap,28,88);\n		printf(\"value:%d  his index:%d\\n\",88,get(*hashmap,88));\n		\n		printHashMap(hashmap);\n    	destoryHashMap(hashmap);\n    	getchar();\n		return 0;\n}\n\n\n```\n','<pre><code class=\"lang-\">/********************************************************************************\n\n **** Copyright (C), 2021, xx xx xx xx info&amp;tech Co., Ltd.                ****\n\n ********************************************************************************\n * File Name     : hash.c\n * Author        : lxc\n * Date          : 2021-11-03\n * Description   : .C file function description\n * Version       : 1.0\n * Function List :\n * \n * Record        :\n * 1.Date        : 2021-11-03\n *   Author      : lxc\n *   Modification: Created file\n\n ********************************************************************************/\n#include &lt;math.h&gt;\n#include &lt;stdio.h&gt;\n#include &lt;stdlib.h&gt;\n\ntypedef struct{\n	int key;\n	int val;\n}DataType; //基本数据进行封装\n\n//一个节点，用于存储一个hash值 所对应的数据(链式结构解决hash冲突)\ntypedef struct{\n	DataType data;\n	struct HashNode * next; //链式结构\n}HashNode;\n\ntypedef struct{\n	int size;\n	HashNode *table;\n}HashMap,*hashmap;\n\n#define INT_MIN 0\n//创建一个hash表，将一个int数组，构建为hash，size为长度\nHashMap* CreateHashMap(int *nums,int size)\n{\n	HashMap *hashmap = (HashMap*) malloc(sizeof(HashMap));\n	hashmap-&gt;size = 2 * size;\n	//hash表分配空间\n	hashmap-&gt;table = (HashNode*) malloc(sizeof(HashNode) * hashmap-&gt;size);\n	//初始化\n	int j = 0;\n	for (j=0;j&lt;hashmap-&gt;size;j++){\n		hashmap-&gt;table[j].data.val = INT_MIN;\n		hashmap-&gt;table[j].next = NULL;\n	}\n	int i = 0;\n	while (i &lt; size){\n		//根据value计算其在hashMap中的位置\n		int pos = abs(nums[i])%hashmap-&gt;size;\n		//\n		if(hashmap-&gt;table[pos].data.val == INT_MIN){\n			//未冲突\n			//数组索引为key\n			hashmap-&gt;table[pos].data.key = i;\n			//元素值为value\n			hashmap-&gt;table[pos].data.val = nums[i];\n		}else{\n			//产生冲突\n			HashNode * lnode = (HashNode*) malloc(sizeof(HashNode));\n			HashNode * hashnode;\n			//存储当前的值\n			lnode-&gt;data.key = i;\n			lnode-&gt;data.val = nums[i];\n			lnode-&gt;next = NULL;\n\n			//从冲突未知开始，遍历链表\n			hashnode = &amp;(hashmap-&gt;table[pos]);\n			//hashnode 一直走到链表尾部\n			while(hashnode-&gt;next != NULL){\n				hashnode = hashnode-&gt;next;\n			}\n			//将当前结点连接到链表尾部\n			hashnode-&gt;next=lnode;\n		}\n		i++;\n	}\n	//处理完成，返回HashMap\n	return hashmap;\n}\nint get(HashMap hashmap,int value)\n{\n	int pos = abs(value)%hashmap.size;\n	HashNode * hashnode = &amp;(hashmap.table[pos]);\n	while(hashnode!= NULL){\n		if(hashnode-&gt;data.val == value)\n			return hashnode-&gt;data.key;\n		else\n			hashnode = hashnode-&gt;next; \n	}\n	//未找到\n	return -1;\n}\nint put(HashMap hashmap,int key, int value)\n{	\n	//计算出hash值\n	int pos =abs(value)%hashmap.size;\n	HashNode *node = &amp;(hashmap.table[pos]);\n	//无hash冲突\n	if(node-&gt;data.val == INT_MIN){\n		node-&gt;data.key = key;\n		node-&gt;data.val = value;\n	}else{\n		//hashnode 一直走到链表尾部\n		while(node-&gt;next != NULL){\n			node = node-&gt;next;\n		}\n		HashNode *hnode=(HashNode *)malloc(sizeof(HashNode));\n		hnode-&gt;data.key=key;\n		hnode-&gt;data.val=value;\n		hnode-&gt;next=NULL;\n		node-&gt;next=hnode;\n	}\n	return 1;\n}\nvoid printHashMap(HashMap *hashmap)\n{	\n	printf(&quot;===========PrintHashMap==========\\n&quot;);\n	int i = 0;\n	HashNode *node;\n	while(i&lt;hashmap-&gt;size){\n		node = &amp;(hashmap-&gt;table[i]);\n		while(node != NULL){\n			if(node-&gt;data.val != INT_MIN){\n				//这个节点已经被用户使用了\n				printf(&quot;%10d&quot;,node-&gt;data.val);\n			}else{\n				//这个节点是初始化节点\n				printf(&quot;        [ ]&quot;);\n			}\n			//继续下一个节点\n			node = node-&gt;next;\n		}\n		printf(&quot;\\n---------------------------------&quot;);\n		//开始检索下一个 hash值\n		i++;\n		printf(&quot;\\n&quot;);\n	}\n	printf(&quot;===============End===============\\n&quot;);\n}\nvoid destoryHashMap(HashMap *hashmap)\n{\n	int i = 0;\n	HashNode * node;\n	HashNode * temp;\n	while(i&lt;hashmap-&gt;size){\n		temp = hashmap-&gt;table[i].next;\n		node = hashmap-&gt;table[i].next;\n		while (node != NULL)\n		{	\n			temp=node-&gt;next;\n			//逐个释放结点空间，防止内存溢出\n            free(node);\n            node = temp;\n		}\n		i++;\n	}\n	free(hashmap-&gt;table);\n    free(hashmap);\n    printf(&quot;Destory hashmap Success!&quot;);\n}\nint main(int argc, char **argv)\n{\n		int nums[]={34,54,32,32,56,78};\n		//创建HashMap\n   	    HashMap *hashmap=CreateHashMap(nums,6);\n    	//printHashMap(hashmap);\n    	//查找元素\n    	printf(&quot;value:%d  his index:%d\\n&quot;,78,get(*hashmap,78));\n\n		put(*hashmap,28,88);\n		printf(&quot;value:%d  his index:%d\\n&quot;,88,get(*hashmap,88));\n		\n		printHashMap(hashmap);\n    	destoryHashMap(hashmap);\n    	getchar();\n		return 0;\n}\n\n\n</code></pre>\n',1,'2022-01-09 22:52:36','2022-01-09 22:54:50'),(78,13,1,2,'hash冲突的解决方法','hash_collision ','','## hash冲突\n就是key 经过一个函数f(key)得到的结果的作为地址去存放当前的key value键值对(这个是hashmap的存值方式)，但是却发现算出来的地址上已经有数据占用了，就是说这个地方要挤一挤啦。这就是所谓的hash冲突\n## hash冲突解决方法\n### 开放定址法\n开放定址法，也称为再散列法。当关键字key的哈希地址p=H（key）出现冲突时，以p为基础，根据以下公式计算出新的哈希地址 N\n```\n/**\n* 说明：N 代表计算出来的新的哈希地址     TableSize为表长\n*/\nN = (H(key) + di) % TableSize       i=1,2,3.....n\n\n```\n根据 di 的计算公式不同又可分为 线性探测、平方探测、双散列\n\n- 线性探测：di = i     ->哈希地址p开始，逐个地往后查找空余的插槽，将新元素放入进去\n- 平方探测： di = \\pm i ^ 2  ->哈希地址p开始，以i的n次幂往前和往后查找空余的插槽，将新元素放入进去。注意平方探测这里是可以往前或往后查找的，而线性探测只能往后查找\n- 双散列：双散列所采用的公式为 di = i * H_2(key)  ->H_2(key)为新的hash函数\n\n### 拉链法\n 当产生hash冲突时，再出冲突的位置上形成一个链表，通过指针互相连接。当查找时，发现hash冲突时顺着链表一直往下找，直到链表的尾节点，找不到则返回空。如下图所示：\n![链地址法哈希冲突解决](http://lxcong.cn/FrWGdCE8KGRni2UJDTp7ki-4Lq8C)\n### 公共溢出区\n这种方法的基本思想是：将哈希表分为基本表和溢出表两部分，凡是和基本表发生冲突的元素，一律填入溢出表。\n### 再哈希法\n多写几个哈希函数，算出来一个hashcode重复的就用另一个哈希函数算，直到算出来不一样。\n','<div class=\"toc\"><ul><li><a href=\"#toc_hash_0\">hash冲突</a></li><li><a href=\"#toc_hash_2\">hash冲突解决方法</a><ul><li><a href=\"#toc__3\">开放定址法</a></li><li><a href=\"#toc__18\">拉链法</a></li><li><a href=\"#toc__21\">公共溢出区</a></li><li><a href=\"#toc__23\">再哈希法</a></li></ul></li></ul></div><h2><a id=\"toc_hash_0\"></a>hash冲突</h2>\n<p>就是key 经过一个函数f(key)得到的结果的作为地址去存放当前的key value键值对(这个是hashmap的存值方式)，但是却发现算出来的地址上已经有数据占用了，就是说这个地方要挤一挤啦。这就是所谓的hash冲突</p>\n<h2><a id=\"toc_hash_2\"></a>hash冲突解决方法</h2>\n<h3><a id=\"toc__3\"></a>开放定址法</h3>\n<p>开放定址法，也称为再散列法。当关键字key的哈希地址p=H（key）出现冲突时，以p为基础，根据以下公式计算出新的哈希地址 N</p>\n<pre><code class=\"lang-\">/**\n* 说明：N 代表计算出来的新的哈希地址     TableSize为表长\n*/\nN = (H(key) + di) % TableSize       i=1,2,3.....n\n\n</code></pre>\n<p>根据 di 的计算公式不同又可分为 线性探测、平方探测、双散列</p>\n<ul>\n<li>线性探测：di = i     -&gt;哈希地址p开始，逐个地往后查找空余的插槽，将新元素放入进去</li>\n<li>平方探测： di = \\pm i ^ 2  -&gt;哈希地址p开始，以i的n次幂往前和往后查找空余的插槽，将新元素放入进去。注意平方探测这里是可以往前或往后查找的，而线性探测只能往后查找</li>\n<li>双散列：双散列所采用的公式为 di = i * H_2(key)  -&gt;H_2(key)为新的hash函数</li>\n</ul>\n<h3><a id=\"toc__18\"></a>拉链法</h3>\n<p>当产生hash冲突时，再出冲突的位置上形成一个链表，通过指针互相连接。当查找时，发现hash冲突时顺着链表一直往下找，直到链表的尾节点，找不到则返回空。如下图所示：<br />\n<img src=\"http://lxcong.cn/FrWGdCE8KGRni2UJDTp7ki-4Lq8C\" alt=\"链地址法哈希冲突解决\" /></p>\n<h3><a id=\"toc__21\"></a>公共溢出区</h3>\n<p>这种方法的基本思想是：将哈希表分为基本表和溢出表两部分，凡是和基本表发生冲突的元素，一律填入溢出表。</p>\n<h3><a id=\"toc__23\"></a>再哈希法</h3>\n<p>多写几个哈希函数，算出来一个hashcode重复的就用另一个哈希函数算，直到算出来不一样。</p>\n',1,'2022-01-09 22:57:22','2022-01-09 23:04:29'),(79,15,1,2,'Go的unsafe.Pointer','unsafe','','## unsafe.Pointer\n在看Golang  slice底层实现时，看到了unsafe.Pointer这个类型，这个类型在源码中随处可见，map，channel，interface，slice 都有unsafe.Pointer的影子。因此要理解slice，map，channel的实现，就必须先了解unsafe.Pointer这个类型\n## unsafe.Pointer指针是什么\n其实就是一句话，就是C语言中那个牛逼到爆的什么都能指的不安全的指针。再确切一点是：void*\n\n- 在Golang中，指针的作用仅是操作其指向对象。不能进行类似于C/C++的指针运算（指针加减）\n- 指针类型不能进行转换，如int不能转换为int32。\n\n上述的两个限定主要是为了简化指针的使用，减少指针使用过程中出错的机率，提高代码的鲁棒性。但是在开发过程中，有时需要打破这些限制，对内存进行任意的读写，这里就需要unsafe.Pointer了。\n\nunsafe.Pointer的使用规则\n\n- Go语言常规的任何类型的指针都可以转化为unsafe.Pointer类型\n- unsafe.Pointer类型可以转化为Go语言常规的任何类型的指针\n- uintptr这个类型可以转化为unsafe.Pointer\n- unsafe.Pointer可以转化为uintptr\n## 最后总结一下Go的指针\n![](http://lxcong.cn/Fs50KqWhyroCS3ysPtiL1vQqDRXp)','<div class=\"toc\"><ul><li><a href=\"#toc_unsafePointer_0\">unsafe.Pointer</a></li><li><a href=\"#toc_unsafePointer_2\">unsafe.Pointer指针是什么</a></li><li><a href=\"#toc_Go_16\">最后总结一下Go的指针</a></li></ul></div><h2><a id=\"toc_unsafePointer_0\"></a>unsafe.Pointer</h2>\n<p>在看Golang  slice底层实现时，看到了unsafe.Pointer这个类型，这个类型在源码中随处可见，map，channel，interface，slice 都有unsafe.Pointer的影子。因此要理解slice，map，channel的实现，就必须先了解unsafe.Pointer这个类型</p>\n<h2><a id=\"toc_unsafePointer_2\"></a>unsafe.Pointer指针是什么</h2>\n<p>其实就是一句话，就是C语言中那个牛逼到爆的什么都能指的不安全的指针。再确切一点是：void*</p>\n<ul>\n<li>在Golang中，指针的作用仅是操作其指向对象。不能进行类似于C/C++的指针运算（指针加减）</li>\n<li>指针类型不能进行转换，如int不能转换为int32。</li>\n</ul>\n<p>上述的两个限定主要是为了简化指针的使用，减少指针使用过程中出错的机率，提高代码的鲁棒性。但是在开发过程中，有时需要打破这些限制，对内存进行任意的读写，这里就需要unsafe.Pointer了。</p>\n<p>unsafe.Pointer的使用规则</p>\n<ul>\n<li>Go语言常规的任何类型的指针都可以转化为unsafe.Pointer类型</li>\n<li>unsafe.Pointer类型可以转化为Go语言常规的任何类型的指针</li>\n<li>uintptr这个类型可以转化为unsafe.Pointer</li>\n<li>unsafe.Pointer可以转化为uintptr</li>\n</ul>\n<h2><a id=\"toc_Go_16\"></a>最后总结一下Go的指针</h2>\n<p><img src=\"http://lxcong.cn/Fs50KqWhyroCS3ysPtiL1vQqDRXp\" alt=\"\" /></p>\n',1,'2022-01-09 23:05:38','2022-01-09 23:05:38'),(80,15,1,2,'Go slice实现原理','slice','','## slice的结构\n```\ntype slice struct {\n    array unsafe.Pointer\n    len   int\n    cap   int\n}\n\n```\n## slice 创建\nmake 函数允许在运行期动态指定数组长度，绕开了数组类型必须使用编译期常量的限制。创建切片有两种形式，make 创建切片，空切片。\n```\n/* \nGo/src/runtime/slice.go\n*/\nfunc makeslice(et *_type, len, cap int) unsafe.Pointer {\n	// 根据切片的数据类型，获取切片的最大容量\n	mem, overflow := math.MulUintptr(et.size, uintptr(cap))\n	//判断是否合法\n	if overflow || mem > maxAlloc || len < 0 || len > cap {\n		mem, overflow := math.MulUintptr(et.size, uintptr(len))\n		if overflow || mem > maxAlloc || len < 0 {\n			panicmakeslicelen()\n		}\n		panicmakeslicecap()\n	}\n	// 根据切片的容量申请内存，返回切片的首地址\n	return mallocgc(mem, et, true)\n}\n```\n1. 创建切片时首先根据切片类型，以及传入的cap参数，计算最大所需内存。然后判断所申请内存是否达到最大限制；切片创建时，len大于cap，那么所申请内存大小则以len参数来计算。\n2. 校验通过后，最后就是申请内存，所申请内存大小为前面所计算得出的mem。返回内存首地址\n## nil切片和空切片\n**nil 切片**：被用在很多标准库和内置函数中，描述一个不存在的切片的时候，就需要用到 nil 切片。比如函数在发生异常的时候，返回的切片就是 nil 切片。nil 切片的指针指向 nil\n![](http://lxcong.cn/Fl5v2iR2cK2j0RrmocC8NqlX0J1t)\n\n**空切片**：一般会用来表示一个空的集合。比如数据库查询，一条结果也没有查到，那么就可以返回一个空切片\n![](http://lxcong.cn/FqxfxCOF335Q6RwnTon0frWmnyYA)\n\n## slice 扩容\n```\nfunc growslice(et *_type, old slice, cap int) slice {\n	if raceenabled {\n		callerpc := getcallerpc()\n		racereadrangepc(old.array, uintptr(old.len*int(et.size)), callerpc, funcPC(growslice))\n	}\n	if msanenabled {\n		msanread(old.array, uintptr(old.len*int(et.size)))\n	}\n	// 如果新要扩容的容量比原来的容量还要小，这代表要缩容了，那么可以直接报panic了。\n	if cap < old.cap {\n		panic(errorString(\"growslice: cap out of range\"))\n	}\n\n	if et.size == 0 {\n		// 如果当前切片的大小为0，还调用了扩容方法，那么就新生成一个新的容量的切片返回\n		return slice{unsafe.Pointer(&zerobase), old.len, cap}\n	}\n	//扩容的策略\n	newcap := old.cap\n	doublecap := newcap + newcap\n	if cap > doublecap {\n		newcap = cap\n	} else {\n		if old.cap < 1024 {\n			//2倍\n			newcap = doublecap\n		} else {\n			//每次尝试扩1/4\n			for 0 < newcap && newcap < cap {\n				newcap += newcap / 4\n			}\n			if newcap <= 0 {\n				newcap = cap\n			}\n		}\n	}\n\n	var overflow bool\n	// 计算新的切片的容量，长度。\n	var lenmem, newlenmem, capmem uintptr\n	// 针对不同的类型储存空间大小典型值\n	switch {\n	case et.size == 1:\n		lenmem = uintptr(old.len)\n		newlenmem = uintptr(cap)\n		capmem = roundupsize(uintptr(newcap))\n		overflow = uintptr(newcap) > maxAlloc\n		newcap = int(capmem)\n	case et.size == sys.PtrSize:\n		lenmem = uintptr(old.len) * sys.PtrSize\n		newlenmem = uintptr(cap) * sys.PtrSize\n		capmem = roundupsize(uintptr(newcap) * sys.PtrSize)\n		overflow = uintptr(newcap) > maxAlloc/sys.PtrSize\n		newcap = int(capmem / sys.PtrSize)\n	case isPowerOfTwo(et.size):\n		var shift uintptr\n		if sys.PtrSize == 8 {\n			// Mask shift for better code generation.\n			shift = uintptr(sys.Ctz64(uint64(et.size))) & 63\n		} else {\n			shift = uintptr(sys.Ctz32(uint32(et.size))) & 31\n		}\n		lenmem = uintptr(old.len) << shift\n		newlenmem = uintptr(cap) << shift\n		capmem = roundupsize(uintptr(newcap) << shift)\n		overflow = uintptr(newcap) > (maxAlloc >> shift)\n		newcap = int(capmem >> shift)\n	default:\n		lenmem = uintptr(old.len) * et.size\n		newlenmem = uintptr(cap) * et.size\n		capmem, overflow = math.MulUintptr(et.size, uintptr(newcap))\n		capmem = roundupsize(capmem)\n		newcap = int(capmem / et.size)\n	}\n\n	// 判断非法的值，保证容量是在增加，并且容量不超过最大容量\n	if overflow || capmem > maxAlloc {\n		panic(errorString(\"growslice: cap out of range\"))\n	}\n\n	var p unsafe.Pointer\n	if et.ptrdata == 0 {\n		p = mallocgc(capmem, nil, false)\n		// The append() that calls growslice is going to overwrite from old.len to cap (which will be the new length).\n		// Only clear the part that will not be overwritten.\n		memclrNoHeapPointers(add(p, newlenmem), capmem-newlenmem)\n	} else {\n		// Note: can\'t use rawmem (which avoids zeroing of memory), because then GC can scan uninitialized memory.\n		p = mallocgc(capmem, et, true)\n		if lenmem > 0 && writeBarrier.enabled {\n			// Only shade the pointers in old.array since we know the destination slice p\n			// only contains nil pointers because it has been cleared during alloc.\n			bulkBarrierPreWriteSrcOnly(uintptr(p), uintptr(old.array), lenmem-et.size+et.ptrdata)\n		}\n	}\n	memmove(p, old.array, lenmem)\n\n	return slice{p, old.len, newcap}\n}\n```\n\n\n\n\n\n','<div class=\"toc\"><ul><li><a href=\"#toc_slice_0\">slice的结构</a></li><li><a href=\"#toc_slice__9\">slice 创建</a></li><li><a href=\"#toc_nil_32\">nil切片和空切片</a></li><li><a href=\"#toc_slice__39\">slice 扩容</a></li></ul></div><h2><a id=\"toc_slice_0\"></a>slice的结构</h2>\n<pre><code class=\"lang-\">type slice struct {\n    array unsafe.Pointer\n    len   int\n    cap   int\n}\n\n</code></pre>\n<h2><a id=\"toc_slice__9\"></a>slice 创建</h2>\n<p>make 函数允许在运行期动态指定数组长度，绕开了数组类型必须使用编译期常量的限制。创建切片有两种形式，make 创建切片，空切片。</p>\n<pre><code class=\"lang-\">/* \nGo/src/runtime/slice.go\n*/\nfunc makeslice(et *_type, len, cap int) unsafe.Pointer {\n	// 根据切片的数据类型，获取切片的最大容量\n	mem, overflow := math.MulUintptr(et.size, uintptr(cap))\n	//判断是否合法\n	if overflow || mem &gt; maxAlloc || len &lt; 0 || len &gt; cap {\n		mem, overflow := math.MulUintptr(et.size, uintptr(len))\n		if overflow || mem &gt; maxAlloc || len &lt; 0 {\n			panicmakeslicelen()\n		}\n		panicmakeslicecap()\n	}\n	// 根据切片的容量申请内存，返回切片的首地址\n	return mallocgc(mem, et, true)\n}\n</code></pre>\n<ol>\n<li>创建切片时首先根据切片类型，以及传入的cap参数，计算最大所需内存。然后判断所申请内存是否达到最大限制；切片创建时，len大于cap，那么所申请内存大小则以len参数来计算。</li>\n<li>校验通过后，最后就是申请内存，所申请内存大小为前面所计算得出的mem。返回内存首地址</li>\n</ol>\n<h2><a id=\"toc_nil_32\"></a>nil切片和空切片</h2>\n<p><strong>nil 切片</strong>：被用在很多标准库和内置函数中，描述一个不存在的切片的时候，就需要用到 nil 切片。比如函数在发生异常的时候，返回的切片就是 nil 切片。nil 切片的指针指向 nil<br />\n<img src=\"http://lxcong.cn/Fl5v2iR2cK2j0RrmocC8NqlX0J1t\" alt=\"\" /></p>\n<p><strong>空切片</strong>：一般会用来表示一个空的集合。比如数据库查询，一条结果也没有查到，那么就可以返回一个空切片<br />\n<img src=\"http://lxcong.cn/FqxfxCOF335Q6RwnTon0frWmnyYA\" alt=\"\" /></p>\n<h2><a id=\"toc_slice__39\"></a>slice 扩容</h2>\n<pre><code class=\"lang-\">func growslice(et *_type, old slice, cap int) slice {\n	if raceenabled {\n		callerpc := getcallerpc()\n		racereadrangepc(old.array, uintptr(old.len*int(et.size)), callerpc, funcPC(growslice))\n	}\n	if msanenabled {\n		msanread(old.array, uintptr(old.len*int(et.size)))\n	}\n	// 如果新要扩容的容量比原来的容量还要小，这代表要缩容了，那么可以直接报panic了。\n	if cap &lt; old.cap {\n		panic(errorString(&quot;growslice: cap out of range&quot;))\n	}\n\n	if et.size == 0 {\n		// 如果当前切片的大小为0，还调用了扩容方法，那么就新生成一个新的容量的切片返回\n		return slice{unsafe.Pointer(&amp;zerobase), old.len, cap}\n	}\n	//扩容的策略\n	newcap := old.cap\n	doublecap := newcap + newcap\n	if cap &gt; doublecap {\n		newcap = cap\n	} else {\n		if old.cap &lt; 1024 {\n			//2倍\n			newcap = doublecap\n		} else {\n			//每次尝试扩1/4\n			for 0 &lt; newcap &amp;&amp; newcap &lt; cap {\n				newcap += newcap / 4\n			}\n			if newcap &lt;= 0 {\n				newcap = cap\n			}\n		}\n	}\n\n	var overflow bool\n	// 计算新的切片的容量，长度。\n	var lenmem, newlenmem, capmem uintptr\n	// 针对不同的类型储存空间大小典型值\n	switch {\n	case et.size == 1:\n		lenmem = uintptr(old.len)\n		newlenmem = uintptr(cap)\n		capmem = roundupsize(uintptr(newcap))\n		overflow = uintptr(newcap) &gt; maxAlloc\n		newcap = int(capmem)\n	case et.size == sys.PtrSize:\n		lenmem = uintptr(old.len) * sys.PtrSize\n		newlenmem = uintptr(cap) * sys.PtrSize\n		capmem = roundupsize(uintptr(newcap) * sys.PtrSize)\n		overflow = uintptr(newcap) &gt; maxAlloc/sys.PtrSize\n		newcap = int(capmem / sys.PtrSize)\n	case isPowerOfTwo(et.size):\n		var shift uintptr\n		if sys.PtrSize == 8 {\n			// Mask shift for better code generation.\n			shift = uintptr(sys.Ctz64(uint64(et.size))) &amp; 63\n		} else {\n			shift = uintptr(sys.Ctz32(uint32(et.size))) &amp; 31\n		}\n		lenmem = uintptr(old.len) &lt;&lt; shift\n		newlenmem = uintptr(cap) &lt;&lt; shift\n		capmem = roundupsize(uintptr(newcap) &lt;&lt; shift)\n		overflow = uintptr(newcap) &gt; (maxAlloc &gt;&gt; shift)\n		newcap = int(capmem &gt;&gt; shift)\n	default:\n		lenmem = uintptr(old.len) * et.size\n		newlenmem = uintptr(cap) * et.size\n		capmem, overflow = math.MulUintptr(et.size, uintptr(newcap))\n		capmem = roundupsize(capmem)\n		newcap = int(capmem / et.size)\n	}\n\n	// 判断非法的值，保证容量是在增加，并且容量不超过最大容量\n	if overflow || capmem &gt; maxAlloc {\n		panic(errorString(&quot;growslice: cap out of range&quot;))\n	}\n\n	var p unsafe.Pointer\n	if et.ptrdata == 0 {\n		p = mallocgc(capmem, nil, false)\n		// The append() that calls growslice is going to overwrite from old.len to cap (which will be the new length).\n		// Only clear the part that will not be overwritten.\n		memclrNoHeapPointers(add(p, newlenmem), capmem-newlenmem)\n	} else {\n		// Note: can\'t use rawmem (which avoids zeroing of memory), because then GC can scan uninitialized memory.\n		p = mallocgc(capmem, et, true)\n		if lenmem &gt; 0 &amp;&amp; writeBarrier.enabled {\n			// Only shade the pointers in old.array since we know the destination slice p\n			// only contains nil pointers because it has been cleared during alloc.\n			bulkBarrierPreWriteSrcOnly(uintptr(p), uintptr(old.array), lenmem-et.size+et.ptrdata)\n		}\n	}\n	memmove(p, old.array, lenmem)\n\n	return slice{p, old.len, newcap}\n}\n</code></pre>\n',1,'2022-01-09 23:08:32','2022-01-15 13:49:14'),(81,12,1,2,'性能问题分析工具','tool_linux','','# GDB\n\n# Valgrind\n分析程序性能及程序中的内存泄露错误\n#### 常用的参数\n```\n--leak-check=full \n--undef-value-errors=no\n--num-callers=50        如果valgrind显示的调用堆栈不够深,可以使用这个参数\n```\n* 跑内存泄露\n```\n1. 后台运行：\nvalgrind --leak-check=full --error-limit=no --tool=memcheck --run-libc-freeres=no --show-reachable=yes --log-file=/tmp/wns_hostapd.log /wns/sbin/wns_hostapd &\n2. 运行一段时间后可以直接使用kill -SIGINT 进程号 中断进程。(不要使用kill -9 PID，该命令会将历史记录全部删除，即覆盖率和内存泄漏记录都会被删)\n\n3.然后查看log文件，第一项为0即无内存泄露。\n```\n\n# Asan\nGCC集成的内存检测工具\n* 使用方法\n\n\n\n# Strace\nstrace可以用来追踪系统调用\n#### 比较常用的参数:\n```\n-f ：除了跟踪当前进程外，还跟踪其子进程。\n-o file ：将输出信息写到文件file中，而不是显示到标准错误输出（stderr）。\n-p pid ：绑定到一个由pid对应的正在运行的进程。此参数常用来调试后台进程。\n-c : 统计每一个系统调用消耗的时间, 调用的次数和出错的次数\n-e : 过滤输出项,比如说,你只想观察某些系统调用\n-x : 以十六进制形式输出非标准字符串,这个比-xx稍微好用一些\n-s : 用于指定输出字符串的最大长度,这个选项非常有用.\n```\n* 示例： -p指定进程id, -t显示时间戳, -f监控线程, -e用于限定系统调用.  2>&1用于将标准错误重定向到标准输出,方便grep搜寻满足条件的行.\n```shell\nstrace -p `pidof device_handler` -t -f -e recvmsg,sendmsg 2>&1\n``` \n# uptime\n平均负载\n# top\n监控每个进程cpu用量\n# sar \n* sar -u 查看cpu信息\n* sar -r 查看内存\n# mpstat\n查看所有cpu核信息\n* mpstat -P ALL 1  //查看所有cpu核信息\n# dmesg\n查看内核日志信息\n# pidstat\n每个进程cpu用量分解\n示例：\n```shell\n//定时1s 刷新一次 device_handler进程的内存使用情况(-r) CPU 使用情况(-u) 磁盘使用情况(-d)  \npidstat -r -u -d  -p `pidof device_handler`  1 \n```\n![微信图片_20220210200323.png](/static/upload/202202/104qidni759x.png)\n|  指标 |  说明 |\n| ------------ | ------------ |\n| UID |  用户ID |\n| PID | 进程ID  |\n|磁盘使用情况\n| kB_rd/s  |  每秒发出的写请求数据大小,单位是 KB |\n|  kB_ccwr/s | 每秒取消的写请求数据大小,单位是 KB |\n| iodelay | 块IO延迟,包括等待同步块IO和换入块IO结束的时间,单位是时钟周期|\n|内存使用情况\n|VSZ| 虚拟内所占用\n|RSS| 物理内存占用\n|%MEM | 内存占用百分比\n|CPU使用情况\n|%usr| 进程在用户空间占用cpu的百分比\n|%system| 进程在内核空间占用cpu的百分比\n|%CPU| 进程占用cpu的百分比\n\n# iostat\n```shell\niostat -d -x -k 1 10 //统计io详细信息\n```\n# perf\ncpu剖析和跟踪，性能计数分析\n* perf top -p pid -e cpu-clock    //跟踪进程内部函数级cpu使用情况\n\n说明\n* uptime,vmstat,mpstat,top,pidstat只能查询到cpu及负载的的使用情况\n* perf可以跟着到进程内部具体函数耗时情况，并且可以指定内核函数进行统计，指哪打哪。','<div class=\"toc\"><ul><li><a href=\"#toc_toc_GDB_0\">GDB</a></li><li><a href=\"#toc_toc_Valgrind_2\">Valgrind</a><ul><li><a href=\"#toc_toc__4\">常用的参数</a></li></ul></li><li><a href=\"#toc_toc_Asan_19\">Asan</a></li><li><a href=\"#toc_toc_Strace_25\">Strace</a><ul><li><a href=\"#toc_toc__27\">比较常用的参数:</a></li></ul></li><li><a href=\"#toc_toc_uptime_41\">uptime</a></li><li><a href=\"#toc_toc_top_43\">top</a></li><li><a href=\"#toc_toc_sar_45\">sar</a></li><li><a href=\"#toc_toc_mpstat_48\">mpstat</a></li><li><a href=\"#toc_toc_dmesg_51\">dmesg</a></li><li><a href=\"#toc_toc_pidstat_53\">pidstat</a></li><li><a href=\"#toc_toc_iostat_78\">iostat</a></li><li><a href=\"#toc_toc_perf_82\">perf</a></li></ul></div><div class=\"toc\"><ul><li><a href=\"#toc_GDB_0\">GDB</a></li><li><a href=\"#toc_Valgrind_2\">Valgrind</a><ul><li><a href=\"#toc__4\">常用的参数</a></li></ul></li><li><a href=\"#toc_Asan_19\">Asan</a></li><li><a href=\"#toc_Strace_25\">Strace</a><ul><li><a href=\"#toc__27\">比较常用的参数:</a></li></ul></li><li><a href=\"#toc_uptime_41\">uptime</a></li><li><a href=\"#toc_top_43\">top</a></li><li><a href=\"#toc_sar_45\">sar</a></li><li><a href=\"#toc_mpstat_48\">mpstat</a></li><li><a href=\"#toc_dmesg_51\">dmesg</a></li><li><a href=\"#toc_pidstat_53\">pidstat</a></li><li><a href=\"#toc_iostat_78\">iostat</a></li><li><a href=\"#toc_perf_82\">perf</a></li></ul></div><h1><a id=\"toc_toc_GDB_0\"></a>GDB</h1>\n<h1><a id=\"toc_toc_Valgrind_2\"></a>Valgrind</h1>\n<p>分析程序性能及程序中的内存泄露错误</p>\n<h4><a id=\"toc_toc__4\"></a>常用的参数</h4>\n<pre><code class=\"lang-\">--leak-check=full \n--undef-value-errors=no\n--num-callers=50        如果valgrind显示的调用堆栈不够深,可以使用这个参数\n</code></pre>\n<ul>\n<li>跑内存泄露</li>\n</ul>\n<pre><code class=\"lang-\">1. 后台运行：\nvalgrind --leak-check=full --error-limit=no --tool=memcheck --run-libc-freeres=no --show-reachable=yes --log-file=/tmp/wns_hostapd.log /wns/sbin/wns_hostapd &amp;\n2. 运行一段时间后可以直接使用kill -SIGINT 进程号 中断进程。(不要使用kill -9 PID，该命令会将历史记录全部删除，即覆盖率和内存泄漏记录都会被删)\n\n3.然后查看log文件，第一项为0即无内存泄露。\n</code></pre>\n<h1><a id=\"toc_toc_Asan_19\"></a>Asan</h1>\n<p>GCC集成的内存检测工具</p>\n<ul>\n<li>使用方法</li>\n</ul>\n<h1><a id=\"toc_toc_Strace_25\"></a>Strace</h1>\n<p>strace可以用来追踪系统调用</p>\n<h4><a id=\"toc_toc__27\"></a>比较常用的参数:</h4>\n<pre><code class=\"lang-\">-f ：除了跟踪当前进程外，还跟踪其子进程。\n-o file ：将输出信息写到文件file中，而不是显示到标准错误输出（stderr）。\n-p pid ：绑定到一个由pid对应的正在运行的进程。此参数常用来调试后台进程。\n-c : 统计每一个系统调用消耗的时间, 调用的次数和出错的次数\n-e : 过滤输出项,比如说,你只想观察某些系统调用\n-x : 以十六进制形式输出非标准字符串,这个比-xx稍微好用一些\n-s : 用于指定输出字符串的最大长度,这个选项非常有用.\n</code></pre>\n<ul>\n<li>示例： -p指定进程id, -t显示时间戳, -f监控线程, -e用于限定系统调用.  2&gt;&amp;1用于将标准错误重定向到标准输出,方便grep搜寻满足条件的行.</li>\n</ul>\n<pre><div class=\"hljs\"><code class=\"lang-shell\">strace -p `pidof device_handler` -t -f -e recvmsg,sendmsg 2&gt;&amp;1\n</code></div></pre>\n<h1><a id=\"toc_toc_uptime_41\"></a>uptime</h1>\n<p>平均负载</p>\n<h1><a id=\"toc_toc_top_43\"></a>top</h1>\n<p>监控每个进程cpu用量</p>\n<h1><a id=\"toc_toc_sar_45\"></a>sar</h1>\n<ul>\n<li>sar -u 查看cpu信息</li>\n<li>sar -r 查看内存</li>\n</ul>\n<h1><a id=\"toc_toc_mpstat_48\"></a>mpstat</h1>\n<p>查看所有cpu核信息</p>\n<ul>\n<li>mpstat -P ALL 1  //查看所有cpu核信息</li>\n</ul>\n<h1><a id=\"toc_toc_dmesg_51\"></a>dmesg</h1>\n<p>查看内核日志信息</p>\n<h1><a id=\"toc_toc_pidstat_53\"></a>pidstat</h1>\n<p>每个进程cpu用量分解<br />\n示例：</p>\n<pre><div class=\"hljs\"><code class=\"lang-shell\">//定时1s 刷新一次 device_handler进程的内存使用情况(-r) CPU 使用情况(-u) 磁盘使用情况(-d)  \npidstat -r -u -d  -p `pidof device_handler`  1 \n</code></div></pre>\n<p><img src=\"/static/upload/202202/104qidni759x.png\" alt=\"微信图片_20220210200323.png\" /></p>\n<table>\n<thead>\n<tr>\n<th>指标</th>\n<th>说明</th>\n</tr>\n</thead>\n<tbody>\n<tr>\n<td>UID</td>\n<td>用户ID</td>\n</tr>\n<tr>\n<td>PID</td>\n<td>进程ID</td>\n</tr>\n<tr>\n<td>磁盘使用情况</td>\n<td></td>\n</tr>\n<tr>\n<td>kB_rd/s</td>\n<td>每秒发出的写请求数据大小,单位是 KB</td>\n</tr>\n<tr>\n<td>kB_ccwr/s</td>\n<td>每秒取消的写请求数据大小,单位是 KB</td>\n</tr>\n<tr>\n<td>iodelay</td>\n<td>块IO延迟,包括等待同步块IO和换入块IO结束的时间,单位是时钟周期</td>\n</tr>\n<tr>\n<td>内存使用情况</td>\n<td></td>\n</tr>\n<tr>\n<td>VSZ</td>\n<td>虚拟内所占用</td>\n</tr>\n<tr>\n<td>RSS</td>\n<td>物理内存占用</td>\n</tr>\n<tr>\n<td>%MEM</td>\n<td>内存占用百分比</td>\n</tr>\n<tr>\n<td>CPU使用情况</td>\n<td></td>\n</tr>\n<tr>\n<td>%usr</td>\n<td>进程在用户空间占用cpu的百分比</td>\n</tr>\n<tr>\n<td>%system</td>\n<td>进程在内核空间占用cpu的百分比</td>\n</tr>\n<tr>\n<td>%CPU</td>\n<td>进程占用cpu的百分比</td>\n</tr>\n</tbody>\n</table>\n<h1><a id=\"toc_toc_iostat_78\"></a>iostat</h1>\n<pre><div class=\"hljs\"><code class=\"lang-shell\">iostat -d -x -k 1 10 //统计io详细信息\n</code></div></pre>\n<h1><a id=\"toc_toc_perf_82\"></a>perf</h1>\n<p>cpu剖析和跟踪，性能计数分析</p>\n<ul>\n<li>perf top -p pid -e cpu-clock    //跟踪进程内部函数级cpu使用情况</li>\n</ul>\n<p>说明</p>\n<ul>\n<li>uptime,vmstat,mpstat,top,pidstat只能查询到cpu及负载的的使用情况</li>\n<li>perf可以跟着到进程内部具体函数耗时情况，并且可以指定内核函数进行统计，指哪打哪。</li>\n</ul>\n',0,'2022-02-10 19:40:19','2022-02-10 21:12:55');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_tag`
--

DROP TABLE IF EXISTS `post_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `post_tag` (`post_id`,`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=464 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_tag`
--

LOCK TABLES `post_tag` WRITE;
/*!40000 ALTER TABLE `post_tag` DISABLE KEYS */;
INSERT INTO `post_tag` VALUES (55,8,1),(52,10,6),(253,13,11),(50,14,6),(43,19,1),(44,19,2),(45,19,4),(46,19,6),(48,19,9),(54,22,2),(427,30,3),(116,31,1),(443,33,1),(78,35,4),(79,35,10),(441,36,11),(424,37,12),(425,37,13),(147,38,14),(157,39,2),(158,39,15),(155,40,16),(202,41,17),(185,43,1),(186,43,3),(259,44,3),(260,44,4),(434,47,1),(435,47,2),(436,47,4),(426,48,1),(372,51,4),(373,52,2),(374,52,4),(428,53,2),(433,57,2),(439,59,2),(438,60,2),(376,61,2),(401,66,19),(412,67,12),(413,67,20),(456,71,3),(457,75,2),(459,75,21),(461,76,2),(460,76,21),(462,77,23),(463,78,23);
/*!40000 ALTER TABLE `post_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict`
--

DROP TABLE IF EXISTS `sys_dict`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_dict` (
  `key` varchar(64) NOT NULL COMMENT '唯一Key',
  `value` varchar(255) DEFAULT NULL COMMENT '值',
  `inner` tinyint(4) DEFAULT NULL COMMENT '内部禁止删除',
  `intro` varchar(255) DEFAULT NULL COMMENT '说明',
  PRIMARY KEY (`key`),
  UNIQUE KEY `UQE_sys_dict_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict`
--

LOCK TABLES `sys_dict` WRITE;
/*!40000 ALTER TABLE `sys_dict` DISABLE KEYS */;
INSERT INTO `sys_dict` VALUES ('tmp-mod','{\"begin\":\"2021-08-08 19:18\",\"end\":\"2021-08-08 19:18\",\"span\":0.3}',0,'');
/*!40000 ALTER TABLE `sys_dict` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_global`
--

DROP TABLE IF EXISTS `sys_global`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_global` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_url` varchar(255) DEFAULT NULL COMMENT '网站地址',
  `logo_url` varchar(255) DEFAULT NULL COMMENT 'Logo地址',
  `title` varchar(255) DEFAULT NULL COMMENT '网站标题',
  `keywords` varchar(255) DEFAULT NULL COMMENT '网站关键词',
  `description` varchar(255) DEFAULT NULL COMMENT '网站描述',
  `favicon_url` varchar(255) DEFAULT NULL COMMENT 'Favicon地址',
  `beian_miit` varchar(255) DEFAULT NULL COMMENT 'ICP备案',
  `beian_nism` varchar(255) DEFAULT NULL COMMENT '公安备案',
  `copyright` varchar(255) DEFAULT NULL COMMENT '版权',
  `site_js` varchar(512) DEFAULT NULL COMMENT '全局js',
  `site_css` varchar(512) DEFAULT NULL COMMENT '全局css',
  `page_size` int(11) DEFAULT '6' COMMENT '分页大小',
  `comment` varchar(1024) DEFAULT NULL COMMENT '评论脚本',
  `github_url` varchar(255) DEFAULT NULL COMMENT 'githu地址',
  `weibo_url` varchar(255) DEFAULT NULL COMMENT '微博地址',
  `analytic` varchar(1024) DEFAULT NULL COMMENT '统计脚本',
  `author` varchar(255) DEFAULT NULL COMMENT '网站作者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_global`
--

LOCK TABLES `sys_global` WRITE;
/*!40000 ALTER TABLE `sys_global` DISABLE KEYS */;
INSERT INTO `sys_global` VALUES (1,'http://www.lxcong.cn','/static/logo.png','Leo个人中心','Leo，Go','Leo blog;','/favicon.ico','粤ICP备2021082088号-1','','','console.log(\"http://www.lxcong.cn\")','',6,'{\"clientID\": \"e6bdff5f3dede023614a\",\"clientSecret\": \"c0590b5ff13925e4fc1b5f0400fea4df70d0f6cf\",\"repo\": \"blogComment\",\"owner\": \"Leo-xcli\",\"admin\":[\"Leo-xcli\"],\"distractionFreeMode\":true,\"githubUserName\":\"Leo-xcli\"}','https://github.com/Leo-xcli','','<script async src=\"//busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js\"></script> ','Leo-xcli');
/*!40000 ALTER TABLE `sys_global` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `num` varchar(255) DEFAULT NULL COMMENT '账号',
  `passwd` varchar(255) DEFAULT NULL COMMENT '密码',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(255) DEFAULT NULL COMMENT '电话',
  `ecount` int(11) DEFAULT '0' COMMENT '错误次数',
  `ltime` datetime DEFAULT NULL COMMENT '上次登录时间',
  `ctime` datetime DEFAULT NULL COMMENT '创建时间',
  `openid_qq` varchar(64) DEFAULT NULL COMMENT 'qq_openid',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UQE_sys_user_num` (`num`),
  UNIQUE KEY `UQE_sys_user_openid_qq` (`openid_qq`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'admin','admin','87ce8c098c313bddda31d837e052c3','394101651@qq.com','13559775072',2,'2022-01-09 22:27:38','2021-04-06 17:47:16',NULL);
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '标签名',
  `intro` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (23,'C语言','C语言相关代码');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-13 13:15:20
