package appctl

import (
	"blog/model"
	"fmt"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/zxysilent/utils"
)

// ------------------------------------------------------ 主页面 ------------------------------------------------------
// ViewIndex 主页面
func ViewIndex(ctx *gin.Context) {
	pi, _ := strconv.Atoi(ctx.Query("page"))
	if pi == 0 {
		pi = 1
	}
	ps := model.Gcfg().PageSize
	mods, _ := model.PostPage(-1, model.PostKindPost, pi, ps, "id", "title", "path", "updated", "summary")
	total := model.PostCount(-1, model.PostKindPost)
	naver := model.Naver{}
	if pi > 1 {
		naver.Prev = "/?page=" + strconv.Itoa(pi-1)
	}
	if total > (pi * ps) {
		naver.Next = "/?page=" + strconv.Itoa(pi+1)
	}
	ctx.HTML(http.StatusOK, "index", gin.H{
		"Posts":  mods,
		"Naver":  naver,
		"global": model.Gcfg(),
		"appcss": "/static/css/app.css",
		"appjs":  "/static/js/app.js",
	})
}

// ------------------------------------------------------ 文章页面 ------------------------------------------------------
// ViewPost 文章页面
func ViewPost(ctx *gin.Context) {
	paths := strings.Split(ctx.Param("html"), ".")
	if len(paths) == 2 {
		mod, naver, has := model.PostPath(paths[0])
		if !has {
			ctx.HTML(302, "/", nil)
			return
		}
		if paths[1] == "html" {
			mod.Richtext = regImg.ReplaceAllString(mod.Richtext, `<img class="lazy-load" src="data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==" data-src="$1" alt="$2">`)
			ctx.HTML(http.StatusOK, "post", map[string]interface{}{
				"Post":   mod,
				"Show":   mod.Status == 2,
				"Naver":  naver,
				"global": model.Gcfg(),
				"appcss": "/static/css/app.css",
				"appjs":  "/static/js/app.js",
			})
			return
		}
		ctx.JSON(utils.Succ("", mod))
		return
	}
	ctx.Redirect(302, "/404")
}

// ------------------------------------------------------ 单个页面 ------------------------------------------------------
// ViewAbout 关于页面
func ViewAbout(ctx *gin.Context) {
	RenderPage("about", ctx)
}

// ViewLinks 友链页面
func ViewLinks(ctx *gin.Context) {
	RenderPage("links", ctx)
}

// ViewPage 其它页面
func ViewPage(ctx *gin.Context) {
	paths := strings.Split(ctx.Param("html"), ".")
	fmt.Println(paths)
	if len(paths) == 2 {
		RenderPage(paths[0], ctx)
		return
	}
	ctx.Redirect(302, "/404")
}

// ------------------------------------------------------ 归档页面 ------------------------------------------------------
// ViewArchives 归档页面
func ViewArchives(ctx *gin.Context) {
	archives, err := model.PostArchive()
	if err != nil {
		ctx.Redirect(302, "/")
		return
	}
	ctx.HTML(http.StatusOK, "archive", map[string]interface{}{
		"Archives": archives,
		"global":   model.Gcfg(),
		"appcss":   "/static/css/app.css",
		"appjs":    "/static/js/app.js",
	})
}

// ------------------------------------------------------ 分类页面 ------------------------------------------------------
// ViewCatePost 分类文章列表
func ViewCatePost(ctx *gin.Context) {
	cate := ctx.Param("cate")
	if cate == "" {
		ctx.Redirect(302, "/")
		return
	}
	mod, has := model.CateGet(cate)
	if !has {
		ctx.Redirect(302, "/")
		return
	}
	pi, _ := strconv.Atoi(ctx.GetString("page"))
	if pi == 0 {
		pi = 1
	}
	ps := model.Gcfg().PageSize
	mods, err := model.PostPage(mod.Id, model.PostKindPost, pi, ps,
		"id", "title", "path", "created", "summary", "updated", "status")
	if err != nil || len(mods) < 1 {
		ctx.Redirect(302, "/")
		return
	}
	total := model.PostCount(mod.Id, model.PostKindPost)
	naver := model.Naver{}
	if pi > 1 {
		naver.Prev = "/cate/" + mod.Name + "?page=1"
	}
	if total > (pi * ps) {
		naver.Next = "/cate/" + mod.Name + "?page=" + strconv.Itoa(pi+1)
	}
	ctx.HTML(http.StatusOK, "post-cate.html", map[string]interface{}{
		"Cate":      mod,
		"CatePosts": mods,
		"Naver":     naver,
		"global":    model.Gcfg(),
		"appcss":    "/static/css/app.css",
		"appjs":     "/static/js/app.js",
	})
}

// ------------------------------------------------------ 标签页面 ------------------------------------------------------
// ViewTags 标签页面
func ViewTags(ctx *gin.Context) {
	mods, err := model.TagStateAll()
	if err != nil {
		ctx.Redirect(302, "/")
		return
	}

	ctx.HTML(http.StatusOK, "tags", map[string]interface{}{
		"Tags":   mods,
		"global": model.Gcfg(),
		"appcss": "/static/css/app.css",
		"appjs":  "/static/js/app.js",
	})
}

// ViewTagPost 标签下的文章列表
func ViewTagPost(ctx *gin.Context) {
	tag := ctx.Param("tag")
	if tag == "" {
		ctx.Redirect(302, "/tags")
		return
	}
	mod, has := model.TagGet(tag)
	if !has {
		ctx.Redirect(302, "/tags")
		return
	}
	pi, _ := strconv.Atoi(ctx.GetString("page"))
	if pi == 0 {
		pi = 1
	}
	ps := model.Gcfg().PageSize
	mods, err := model.TagPostPage(mod.Id, pi, ps)
	if err != nil || len(mods) < 1 {
		ctx.Redirect(302, "/tags")
		return
	}
	total := model.TagPostCount(mod.Id)
	naver := model.Naver{}
	if pi > 1 {
		naver.Prev = "/tag/" + mod.Name + "?page=1"
	}
	if total > (pi * ps) {
		naver.Next = "/tag/" + mod.Name + "?page=" + strconv.Itoa(pi+1)
	}
	ctx.HTML(http.StatusOK, "post-tag", map[string]interface{}{
		"Tag":      mod,
		"TagPosts": mods,
		"Naver":    naver,
		"global":   model.Gcfg(),
		"appcss":   "/static/css/app.css",
		"appjs":    "/static/js/app.js",
	})
}
