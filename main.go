package main

import (
	"blog/conf"
	"blog/cronTask"
	"blog/model"
	"blog/router"
	"os"
	"os/signal"
	"syscall"

	"github.com/Lieoxc/zlog"
)

// @Title Blog’s 接口文档
// @Version 1.0
// @Description token传递方式包括[get/post]token、[header]Authorization
// @Description /api/* 公共访问
// @Description /adm/* 必须传入 token
// @Host 127.0.0.1:3000
// @BasePath /
func main() {
	zlog.NewLogger(zlog.SetDevelopment(true))
	conf.Init()
	model.Init()
	cronTask.Init()
	quit := make(chan os.Signal)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM, syscall.SIGKILL)
	zlog.GetLogger().Info("app running")
	go router.RunApp()
	<-quit
	model.Close()
	zlog.GetLogger().Info("app quitted")
}
