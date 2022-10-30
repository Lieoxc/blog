package appctl

import (
	"blog/model"
	"strconv"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/zxysilent/utils"
)

// PostGet doc
// @Tags post-文章
// @Summary 通过id获取单条文章
// @Param id query int true "id"
// @Success 200 {object} model.Reply{data=model.Post} "返回数据"
// @Router /api/post/get [get]
func PostGet(ctx *gin.Context) {
	ipt := &model.IptId{}
	var err error
	ipt.Id, err = strconv.Atoi(ctx.Query("id"))
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	mod, has := model.PostGet(ipt.Id)
	if !has {
		ctx.JSON(utils.ErrOpt("未查询到文章"))
		return
	}
	ctx.JSON(utils.Succ("succ", mod))
}

// PostPage doc
// @Tags post-文章
// @Summary 获取文章分页
// @Param cate_id path int true "分类id" default(1)
// @Param pi query int true "分页数" default(1)
// @Param ps query int true "每页条数" default(5)
// @Success 200 {object} model.Reply{data=[]model.Post} "返回数据"
// @Router /api/post/page [get]
func PostPage(ctx *gin.Context) {
	cateId, err := strconv.Atoi(ctx.Query("cate_id"))
	if err != nil {
		ctx.JSON(utils.ErrIpt("数据输入错误", err.Error()))
		return
	}
	ipt := &model.Page{}
	ipt.Pi, _ = strconv.Atoi(ctx.Query("pi"))
	ipt.Ps, _ = strconv.Atoi(ctx.Query("ps"))
	ipt.Mult = ctx.Query("mult")
	if err = ipt.Stat(); err != nil {
		ctx.JSON(utils.ErrIpt("分页大小输入错误", err.Error()))
		return
	}
	count := model.PostCount(cateId, model.PostKindPost)
	if count < 1 {
		ctx.JSON(utils.ErrOpt("未查询到数据", " count < 1"))
		return
	}
	mods, err := model.PostPage(cateId, model.PostKindPost, ipt.Pi, ipt.Ps, "id", "title", "path", "created", "summary", "updated", "status")
	if err != nil {
		ctx.JSON(utils.ErrOpt("查询数据错误", err.Error()))
		return
	}
	if len(mods) < 1 {
		ctx.JSON(utils.ErrOpt("未查询到数据", "len(mods) < 1"))
		return
	}
	ctx.JSON(utils.Page("succ", mods, int(count)))
}

// PostAdd doc
// @Tags post-文章
// @Summary 添加文章
// @Param token query string true "token"
// @Param body body model.Post true "请求数据"
// @Success 200 {object} model.Reply{data=string} "返回数据"
// @Router /adm/post/add [post]
func PostAdd(ctx *gin.Context) {
	ipt := &model.Post{}
	err := ctx.Bind(ipt)
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	if model.PostExist(ipt.Path) {
		ctx.JSON(utils.ErrIpt("当前访问路径已经存在,请重新输入"))
		return
	}
	if strings.Contains(ipt.Richtext, "<!--more-->") {
		ipt.Summary = strings.Split(ipt.Richtext, "<!--more-->")[0]
	}
	ipt.Richtext = getTocHTML(ipt.Richtext)
	ipt.Updated = ipt.Created
	err = model.PostAdd(ipt)
	if err != nil {
		ctx.JSON(utils.Fail("添加失败", err.Error()))
		return
	}
	//添加标签
	tagPosts := make([]model.PostTag, 0, len(ipt.Tags))
	for _, itm := range ipt.Tags {
		tagPosts = append(tagPosts, model.PostTag{
			TagId:  itm.Id,
			PostId: ipt.Id,
		})
	}
	model.TagPostAdds(&tagPosts)
	ctx.JSON(utils.Succ("succ"))
}

// PostEdit doc
// @Tags post-文章
// @Summary 修改文章
// @Param token query string true "token"
// @Param body body model.Post true "请求数据"
// @Success 200 {object} model.Reply{data=string} "返回数据"
// @Router /adm/post/edit [post]
func PostEdit(ctx *gin.Context) {
	ipt := &model.Post{}
	err := ctx.Bind(ipt)
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	mod, has := model.PostGet(ipt.Id)
	if !has {
		ctx.JSON(utils.ErrOpt("未查询到文章"))
		return
	}
	ipt.Updated = time.Now()
	if strings.Contains(ipt.Richtext, "<!--more-->") {
		ipt.Summary = strings.Split(ipt.Richtext, "<!--more-->")[0]
	}
	ipt.Richtext = getTocHTML(ipt.Richtext)
	err = model.PostEdit(ipt, "cate_id", "kind", "status", "title", "path", "summary", "markdown", "richtext", "allow", "created", "updated")
	if err != nil {
		ctx.JSON(utils.Fail("修改失败", err.Error()))
		return
	}
	// 处理变动标签
	old := mod.Tags
	new := ipt.Tags
	add := make([]int, 0, 4)
	del := make([]int, 0, 4)
	for _, item := range old {
		if !inOf(item.Id, new) {
			del = append(del, item.Id)
		}
	}
	for _, item := range new {
		if !inOf(item.Id, old) {
			add = append(add, item.Id)
		}
	}
	tagAdds := make([]model.PostTag, 0, len(add))
	for _, itm := range add {
		tagAdds = append(tagAdds, model.PostTag{
			TagId:  itm,
			PostId: ipt.Id,
		})
	}
	// 删除标签
	model.PostTagDrops(ipt.Id, del)
	// 添加标签
	model.TagPostAdds(&tagAdds)
	ctx.JSON(utils.Succ("succ"))
}

// PostDrop doc
// @Tags post-文章
// @Summary 通过id删除单条文章
// @Param id query int true "id"
// @Param token query string true "token"
// @Success 200 {object} model.Reply{data=string} "返回数据"
// @Router /adm/post/drop [post]
func PostDrop(ctx *gin.Context) {
	ipt := &model.IptId{}
	err := ctx.Bind(ipt)
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}

	err = model.PostDrop(ipt.Id)
	if err != nil {
		ctx.JSON(utils.ErrOpt("删除失败", err.Error()))
		return
	}
	// 删除 文章对应的标签信息
	model.PostTagDrop(ipt.Id)
	ctx.JSON(utils.Succ("succ"))
}
