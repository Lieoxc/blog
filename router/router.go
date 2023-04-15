package router

import (
	"blog/conf"
	"blog/control/analysis"
	"blog/control/appctl"
	"blog/middleware"

	"github.com/Lieoxc/zlog"
	"github.com/gin-contrib/multitemplate"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

func createMyRender() multitemplate.Renderer {
	p := multitemplate.NewRenderer()
	p.AddFromFiles("dashboard", "webui/dist/index.html")

	p.AddFromFilesFuncs("index", funcMap, "webui/views/index.html",
		"webui/views/tpl-footer.html", "webui/views/tpl-linker.html", "webui/views/tpl-naver.html", "webui/views/tpl-script.html")

	p.AddFromFilesFuncs("page", funcMap, "webui/views/page.html",
		"webui/views/tpl-footer.html", "webui/views/tpl-linker.html", "webui/views/tpl-naver.html", "webui/views/tpl-script.html")

	p.AddFromFilesFuncs("archive", funcMap, "webui/views/archive.html",
		"webui/views/tpl-footer.html", "webui/views/tpl-linker.html", "webui/views/tpl-naver.html", "webui/views/tpl-script.html")

	p.AddFromFilesFuncs("post", funcMap, "webui/views/post.html",
		"webui/views/tpl-footer.html", "webui/views/tpl-linker.html", "webui/views/tpl-naver.html", "webui/views/tpl-script.html")

	p.AddFromFilesFuncs("tags", funcMap, "webui/views/tags.html",
		"webui/views/tpl-footer.html", "webui/views/tpl-linker.html", "webui/views/tpl-naver.html", "webui/views/tpl-script.html")

	p.AddFromFilesFuncs("post-cate", funcMap, "webui/views/post-cate.html",
		"webui/views/tpl-footer.html", "webui/views/tpl-linker.html", "webui/views/tpl-naver.html", "webui/views/tpl-script.html")

	p.AddFromFilesFuncs("post-tag", funcMap, "webui/views/post-tag.html",
		"webui/views/tpl-footer.html", "webui/views/tpl-linker.html", "webui/views/tpl-naver.html", "webui/views/tpl-script.html")

	return p
}

// RunApp 入口
func RunApp() {
	gin.SetMode(conf.App.Mode)

	engine := gin.Default()
	engine.SetFuncMap(funcMap)

	engine.HTMLRender = createMyRender() //自定义模板渲染

	engine.Use(middleware.Logger())
	engine.Use(gin.Recovery())
	engine.Use(middleware.Cors())

	RegDocs(engine) // 注册文档

	engine.Static("/dist", "./webui/dist")           // 静态目录 - 后端专用
	engine.Static("/static", "./webui/static")       // 静态目录
	engine.Static("/webui", "./webui")               // 静态目录
	engine.StaticFile("/favicon.ico", "favicon.ico") // ico
	// 后台登录
	engine.GET("/login.html", func(c *gin.Context) {
		// 302 临时重定向
		c.HTML(200, "dashboard", nil)
	})

	// -- 页面 -- start
	engine.GET("/", appctl.ViewIndex)              // 首页
	engine.GET("/archives", appctl.ViewArchives)   // 归档
	engine.GET("/tags", appctl.ViewTags)           // 标签
	engine.GET("/tag/:tag", appctl.ViewTagPost)    // 具体某个标签
	engine.GET("/cate/:cate", appctl.ViewCatePost) // 分类
	engine.GET("/about", appctl.ViewAbout)         // 关于
	engine.GET("/links", appctl.ViewLinks)         // 友链
	engine.GET("/page/:html", appctl.ViewPage)     // 具体某个页面
	engine.GET("/post/:html", appctl.ViewPost)     // 具体某个文章

	engine.POST("/analysis/log", analysis.AnalysisAdd) // 插入小红书解析记录

	//-- 页面 -- end
	api := engine.Group("/api") // api/
	apiRouter(api)              // 注册分组路由

	//adm := engine.Group("/adm", middleware.MidAuth()) // adm/ 需要登陆才能访问
	adm := engine.Group("/adm") // adm/ 需要登陆才能访问
	admRouter(adm)              // 注册分组路由

	err := engine.Run(conf.App.Addr)
	if err != nil {
		zlog.GetLogger().Fatal("run error :", zap.Error(err))
	}
}
