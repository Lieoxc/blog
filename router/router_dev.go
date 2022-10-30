//go:build !prod
// +build !prod

package router

import (

	// docs
	_ "blog/docs"

	"github.com/gin-gonic/gin"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
	"github.com/zxysilent/logs"
)

func init() {
	logs.SetLevel(logs.DEBUG)
	logs.SetCallInfo(true)
	logs.SetConsole(true)
}

// RegDocs 注册文档
// dev[开发] 模式需要文档
func RegDocs(engine *gin.Engine) {
	//docUrl := ginSwagger.URL("/swagger/doc.json")
	engine.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
}
