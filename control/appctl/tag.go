package appctl

import (
	"blog/model"
	"strconv"

	"github.com/Lieoxc/zlog"
	"github.com/gin-gonic/gin"
	"github.com/zxysilent/utils"
	"go.uber.org/zap"
)

// TagGet doc
// @Tags tag-标签
// @Summary 通过id获取单条标签
// @Param id query int true "id"
// @Success 200 {object} model.Reply{data=model.Tag} "返回数据"
// @Router /api/tag/get [get]
func TagGet(ctx *gin.Context) {
	ipt := &model.IptId{}
	var err error
	ipt.Id, err = strconv.Atoi(ctx.Query("id"))
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	mod, has := model.TagGet(ipt.Id)
	if !has {
		ctx.JSON(utils.ErrOpt("未查询到标签"))
		return
	}
	ctx.JSON(utils.Succ("succ", mod))
}

// TagAll doc
// @Tags tag-标签
// @Summary 获取所有标签
// @Success 200 {object} model.Reply{data=[]model.Tag} "返回数据"
// @Router /api/tag/all [get]
func TagAll(ctx *gin.Context) {
	mods, err := model.TagAll()
	if err != nil {
		ctx.JSON(utils.ErrOpt("未查询到标签", err.Error()))
		return
	}
	ctx.JSON(utils.Succ("succ", mods))
}

// TagPage doc
// @Tags tag-标签
// @Summary 获取标签分页
// @Param pi query int true "分页数" default(1)
// @Param ps query int true "每页条数" default(5)
// @Success 200 {object} model.Reply{data=[]model.Tag} "返回数据"
// @Router /api/tag/page [get]
func TagPage(ctx *gin.Context) {
	ipt := &model.Page{}
	ipt.Pi, _ = strconv.Atoi(ctx.Query("pi"))
	ipt.Ps, _ = strconv.Atoi(ctx.Query("ps"))
	ipt.Mult = ctx.Query("mult")
	if err := ipt.Stat(); err != nil {
		ctx.JSON(utils.ErrIpt("分页大小输入错误", err.Error()))
		return
	}
	count := model.TagCount()
	if count < 1 {
		ctx.JSON(utils.ErrOpt("未查询到数据", " count < 1"))
		return
	}
	mods, err := model.TagPage(ipt.Pi, ipt.Ps)
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

// TagAdd doc
// @Tags tag-标签
// @Summary 添加标签
// @Param token query string true "token"
// @Param body body model.Tag true "请求数据"
// @Success 200 {object} model.Reply{data=string} "返回数据"
// @Router /adm/tag/add [post]
func TagAdd(ctx *gin.Context) {
	ipt := &model.Tag{}
	err := ctx.Bind(ipt)
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	err = model.TagAdd(ipt)
	if err != nil {
		ctx.JSON(utils.Fail("添加失败", err.Error()))
		return
	}
	ctx.JSON(utils.Succ("succ"))
}

// TagEdit doc
// @Tags tag-标签
// @Summary 修改标签
// @Param token query string true "token"
// @Param body body model.Tag true "请求数据"
// @Success 200 {object} model.Reply{data=string} "返回数据"
// @Router /adm/tag/edit [post]
func TagEdit(ctx *gin.Context) {
	ipt := &model.Tag{}
	err := ctx.Bind(ipt)
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	err = model.TagEdit(ipt)
	if err != nil {
		ctx.JSON(utils.Fail("修改失败", err.Error()))
		return
	}
	ctx.JSON(utils.Succ("succ"))
}

// TagDrop doc
// @Tags tag-标签
// @Summary 通过id删除单条标签
// @Param id query int true "id"
// @Param token query string true "token"
// @Success 200 {object} model.Reply{data=string} "返回数据"
// @Router /adm/tag/drop [post]
func TagDrop(ctx *gin.Context) {
	ipt := &model.IptId{}
	err := ctx.Bind(ipt)
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	zlog.GetLogger().Debug("run id ", zap.Int("id", ipt.Id))
	err = model.TagDrop(ipt.Id)
	if err != nil {
		ctx.JSON(utils.ErrOpt("删除失败", err.Error()))
		return
	}
	ctx.JSON(utils.Succ("succ"))
}
