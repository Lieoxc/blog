package appctl

import (
	"blog/cronTask"
	"blog/model"
	"strconv"

	"github.com/Lieoxc/zlog"
	"github.com/gin-gonic/gin"
	"github.com/zxysilent/utils"
	"go.uber.org/zap"
)

// CronTaskPage doc
// @Tags CronTask-定时任务
// @Summary 获取定时任务分页
// @Param pi query int true "分页数" default(1)
// @Param ps query int true "每页条数" default(5)
// @Success 200 {object} model.Reply{data=[]model.Tag} "返回数据"
// @Router /api/cron/page [get]
func CronTaskPage(ctx *gin.Context) {
	ipt := &model.Page{}
	ipt.Pi, _ = strconv.Atoi(ctx.Query("pi"))
	ipt.Ps, _ = strconv.Atoi(ctx.Query("ps"))
	ipt.Mult = ctx.Query("mult")
	if err := ipt.Stat(); err != nil {
		ctx.JSON(utils.ErrIpt("分页大小输入错误", err.Error()))
		return
	}
	count := model.CronTaskCount()
	if count < 1 {
		ctx.JSON(utils.ErrOpt("未查询到数据", " count < 1"))
		return
	}
	mods, err := model.CronTaskPage(ipt.Pi, ipt.Ps)
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

// CronTaskFunc doc
// @Tags CronTask-定时任务
// @Summary 获取所支持功能列表
// @Success 200 {object} model.Reply{data=[]string} "返回数据"
// @Router /api/cron/func [get]
func CronTaskFunc(ctx *gin.Context) {
	funcList := cronTask.GetAllCronFunsList()
	ctx.JSON(utils.Succ("succ", funcList))
}

// CronTaskAdd doc
// @Tags CronTask-定时任务
// @Summary 添加定时任务
// @Param token query string true "token"
// @Param body body model.CronTask true "请求数据"
// @Success 200 {object} model.Reply{data=string} "返回数据"
// @Router /adm/cron/add [post]
func CronTaskAdd(ctx *gin.Context) {
	ipt := &model.CronTask{}
	err := ctx.Bind(ipt)
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	err = model.CronTaskAdd(ipt)
	if err != nil {
		ctx.JSON(utils.Fail("添加失败", err.Error()))
		return
	}

	if ipt.Status == cronTask.TaskStart { //开始启动任务
		err = cronTask.StartJob(ipt)
		if err != nil {
			ctx.JSON(utils.Fail("启动定时任务失败", err.Error()))
			return
		}
	}
	ctx.JSON(utils.Succ("succ"))
}

// CronTaskEdit doc
// @Tags CronTask-定时任务
// @Summary 修改定时任务参数
// @Param token query string true "token"
// @Param body body model.Tag true "请求数据"
// @Success 200 {object} model.Reply{data=string} "返回数据"
// @Router /adm/cron/edit [post]
func CronTaskEdit(ctx *gin.Context) {
	ipt := &model.CronTask{}
	err := ctx.Bind(ipt)
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	//不过做什么修改，都先中止之前的任务
	err = cronTask.RmoveJob(ipt.Id)
	if err != nil {
		ctx.JSON(utils.Fail("停止定时任务失败", err.Error()))
		return
	}
	// 更新数据库
	err = model.CronTaskEdit(ipt)
	if err != nil {
		ctx.JSON(utils.Fail("修改失败", err.Error()))
		return
	}
	// 创建新的定时任务
	if ipt.Status == cronTask.TaskStart { //开始启动任务
		err = cronTask.StartJob(ipt)
		if err != nil {
			ctx.JSON(utils.Fail("启动定时任务失败", err.Error()))
			return
		}
	}
	ctx.JSON(utils.Succ("succ"))
}

// CronTaskDrop doc
// @Tags CronTask-定时任务
// @Summary 通过id删除定时任务，支持多选
// @Param id query []int true "id"
// @Param token query string true "token"
// @Success 200 {object} model.Reply{data=string} "返回数据"
// @Router /adm/cron/drop [post]
func CronTaskDrop(ctx *gin.Context) {
	ipt := &model.IptIds{}
	err := ctx.Bind(ipt)
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	zlog.GetLogger().Debug("delete id ", zap.Ints("id", ipt.IDs))
	//先终止定时任务
	for _, id := range ipt.IDs {
		err = cronTask.RmoveJob(id)
		if err != nil {
			ctx.JSON(utils.Fail("停止定时任务失败", err.Error()))
			return
		}
	}
	//然后更新数据库
	err = model.CronTaskDrop(ipt.IDs)
	if err != nil {
		ctx.JSON(utils.ErrOpt("删除失败", err.Error()))
		return
	}
	ctx.JSON(utils.Succ("succ"))
}
