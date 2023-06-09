package conf

import (
	"fmt"
	"io/ioutil"

	"github.com/Lieoxc/zlog"
	"go.uber.org/zap"
	"gopkg.in/yaml.v2"
)

const (
	dev  = "debug" //开发模式
	prod = "prod"  //线上模式
)

type appcfg struct {
	Title        string `yaml:"title"`          //
	Intro        string `yaml:"intro"`          //
	Mode         string `yaml:"mode"`           //
	Addr         string `yaml:"addr"`           //
	Srv          string `yaml:"srv"`            //
	TokenKey     string `yaml:"token_key"`      //token关键词
	TokenExp     int    `yaml:"token_exp"`      //过期时间 h
	TokenKeep    bool   `yaml:"token_keep"`     //保持在线
	TokenSso     bool   `yaml:"token_sso"`      //单点登录
	TokenSecret  string `yaml:"token_secret"`   //加密私钥
	ImageCut     bool   `yaml:"image_cut"`      //图片裁剪
	ImageWidth   int    `yaml:"image_width"`    //图片宽度
	ImageHeight  int    `yaml:"image_height"`   //图片高度
	PageMin      int    `yaml:"page_min"`       //最小分页大小
	PageMax      int    `yaml:"page_max"`       //最大分页大小
	DbHost       string `yaml:"db_host"`        //数据库地址
	DbPort       int    `yaml:"db_port"`        //数据库端口
	DbUser       string `yaml:"db_user"`        //数据库账号
	DbPasswd     string `yaml:"db_passwd"`      //数据库密码
	DbName       string `yaml:"db_name"`        //数据库名称
	DbParams     string `yaml:"db_params"`      //数据库参数
	OrmIdle      int    `yaml:"orm_idle"`       //
	OrmOpen      int    `yaml:"orm_open"`       //
	OrmShow      bool   `yaml:"orm_show"`       //显示sql
	OrmSync      bool   `yaml:"orm_sync"`       //同步表结构
	OrmCacheUse  bool   `yaml:"orm_cache_use"`  //是否使用缓存
	OrmCacheSize int    `yaml:"orm_cache_size"` //缓存数量
	OrmHijackLog bool   `yaml:"orm_hijack_log"` //劫持日志

	Zone       int    `yaml:"Zone"`       //七牛云区域
	AccessKey  string `yaml:"AccessKey"`  //AccessKey
	SecretKey  string `yaml:"SecretKey"`  //SecretKey
	Bucket     string `yaml:"Bucket"`     //Bucket
	QiniuSever string `yaml:"QiniuSever"` //QiniuSever

	Author struct {
		Name    string `yaml:"name"`
		Website string `yaml:"website"`
	} `yaml:"author"`
	DailyNewsPath string `yaml:"daily_news_path"` //全球要闻图片路径
}

func (app *appcfg) IsProd() bool {
	return app.Mode == prod
}
func (app *appcfg) IsDev() bool {
	return app.Mode == dev
}

// mb4 most bytes 4
// uid:pass@tcp(host:port)/dbname?charset=utf8mb4&parseTime=true&loc=Local
// 用户名:密码@tcp(主机:端口)/数据库名称?charset=utf8mb4&parseTime=true&loc=Local
const _dsn = "%s:%s@tcp(%s:%d)/%s?%s"

// MySQL链接字符串
func (app *appcfg) Dsn() string {
	return fmt.Sprintf(_dsn, app.DbUser, app.DbPasswd, app.DbHost, app.DbPort, app.DbName, app.DbParams)
}

var (
	App       *appcfg              //运行配置实体
	defConfig = "./conf/conf.yaml" //配置文件路径，方便测试
)

func Init() {
	var err error
	App, err = initCfg()
	if err != nil {
		zlog.GetLogger().Fatal("config init error : ", zap.Error(err))
	}

	zlog.GetLogger().Debug("conf init")
}

func initCfg() (*appcfg, error) {
	app := &appcfg{}

	// 读取 YAML 格式的配置文件内容
	yamlContent, err := ioutil.ReadFile(defConfig)
	if err != nil {
		zlog.GetLogger().Fatal("failed to read config.yml:", zap.Error(err))
	}

	// 解析 YAML 格式的配置文件内容到 app 结构体中

	err = yaml.Unmarshal(yamlContent, &app)
	if err != nil {
		zlog.GetLogger().Fatal("failed to unmarshal config:", zap.Error(err))
	}
	return app, nil
}
