package appctl

import (
	"blog/model"
	"strconv"

	"github.com/gin-gonic/gin"
	"github.com/zxysilent/utils"
)

// CateGet doc
// @Tags cate-分类
// @Summary 通过id获取单条分类
// @Param id query int true "id"
// @Success 200 {object} model.Reply{data=model.Cate} "返回数据"
// @Router /api/cate/get [get]
func CateGet(ctx *gin.Context) {
	ipt := &model.IptId{}
	var err error
	ipt.Id, err = strconv.Atoi(ctx.Query("id"))
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	mod, has := model.CateGet(ipt.Id)
	if !has {
		ctx.JSON(utils.ErrOpt("未查询到分类"))
		return
	}
	ctx.JSON(utils.Succ("succ", mod))
}

// CateAll doc
// @Tags cate-分类
// @Summary 获取所有分类
// @Success 200 {object} model.Reply{data=[]model.Cate} "返回数据"
// @Router /api/cate/all [get]
func CateAll(ctx *gin.Context) {
	mods, err := model.CateAll()
	if err != nil {
		ctx.JSON(utils.ErrOpt("未查询到分类", err.Error()))
		return
	}
	ctx.JSON(utils.Succ("succ", mods))
}

// CatePage doc
// @Tags cate-分类
// @Summary 获取分类分页
// @Param pi query int true "分页数" default(1)
// @Param ps query int true "每页条数" default(5)
// @Success 200 {object} model.Reply{data=[]model.Cate} "返回数据"
// @Router /api/cate/page [get]
func CatePage(ctx *gin.Context) {
	ipt := &model.Page{}
	ipt.Pi, _ = strconv.Atoi(ctx.Query("pi"))
	ipt.Ps, _ = strconv.Atoi(ctx.Query("ps"))
	ipt.Mult = ctx.Query("mult")
	if err := ipt.Stat(); err != nil {
		ctx.JSON(utils.ErrIpt("分页大小输入错误", err.Error()))
		return
	}
	count := model.CateCount()
	if count < 1 {
		ctx.JSON(utils.ErrOpt("未查询到数据", " count < 1"))
		return
	}
	mods, err := model.CatePage(ipt.Pi, ipt.Ps)
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

// CateAdd doc
// @Tags cate-分类
// @Summary 添加分类
// @Param token query string true "token"
// @Param body body model.Cate true "请求数据"
// @Success 200 {object} model.Reply{data=string} "返回数据"
// @Router /adm/cate/add [post]
func CateAdd(ctx *gin.Context) {
	ipt := &model.Cate{}
	err := ctx.Bind(ipt)
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	err = model.CateAdd(ipt)
	if err != nil {
		ctx.JSON(utils.Fail("添加失败", err.Error()))
		return
	}
	ctx.JSON(utils.Succ("succ"))
}

// CateEdit doc
// @Tags cate-分类
// @Summary 修改分类
// @Param token query string true "token"
// @Param body body model.Cate true "请求数据"
// @Success 200 {object} model.Reply{data=string} "返回数据"
// @Router /adm/cate/edit [post]
func CateEdit(ctx *gin.Context) {
	ipt := &model.Cate{}
	err := ctx.Bind(ipt)
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	err = model.CateEdit(ipt)
	if err != nil {
		ctx.JSON(utils.Fail("修改失败", err.Error()))
		return
	}
	ctx.JSON(utils.Succ("succ"))
}

// CateDrop doc
// @Tags cate-分类
// @Summary 通过id删除单条分类
// @Param id query int true "id"
// @Param token query string true "token"
// @Success 200 {object} model.Reply{data=string} "返回数据"
// @Router /adm/cate/drop [post]
func CateDrop(ctx *gin.Context) {
	ipt := &model.IptId{}
	err := ctx.Bind(ipt)
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	err = model.CateDrop(ipt.Id)
	if err != nil {
		ctx.JSON(utils.ErrOpt("删除失败", err.Error()))
		return
	}
	ctx.JSON(utils.Succ("succ"))
}
