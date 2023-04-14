package analysis

import (
	"blog/model"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/zxysilent/utils"
)

// AnalysisAdd doc
// @Tags Analysis-解析记录
// @Summary 新增解析记录
// @Param token query string true "token"
// @Param body body model.AnalysisLog true "请求数据"
// @Success 200 {object} model.Reply{data=string} "返回数据"
// @Router /analysis/log [POSt]
func AnalysisAdd(ctx *gin.Context) {
	mod := &model.AnalysisLog{}
	err := ctx.Bind(mod)
	if err != nil {
		ctx.JSON(utils.ErrIpt("输入有误", err.Error()))
		return
	}
	mod.Time = time.Now()
	err = model.AddAnalysisLog(mod)
	if err != nil {
		ctx.JSON(utils.ErrOpt("操作失败"))
		return
	}
	ctx.JSON(utils.Succ("succ"))
}
