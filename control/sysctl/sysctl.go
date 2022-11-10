package sysctl

import (
	"blog/model"
	_ "image/gif"
	_ "image/png"
	"runtime"

	"github.com/gin-gonic/gin"
	"github.com/zxysilent/utils"
	_ "golang.org/x/image/bmp"
)

// StatusGoinfo doc
// @Tags status-状态信息
// @Summary 获取服务器go信息
// @Param token query string true "token"
// @Success 200 {object} model.Reply{data=model.Goinfo} "返回数据"
// @Router /adm/status/goinfo [get]
func StatusGoinfo(ctx *gin.Context) {
	mod := model.Goinfo{
		ARCH:    runtime.GOARCH,
		OS:      runtime.GOOS,
		Version: runtime.Version(),
		NumCPU:  runtime.NumCPU(),
	}
	ctx.JSON(utils.Succ("系统信息", mod))
}

// StatusApp doc
// @Tags status-状态信息
// @Summary 获取服务器go信息
// @Param token query string true "token"
// @Success 200 {object} model.Reply{data=model.State} "返回数据"
// @Router /adm/status/app [get]
func StatusAppinfo(ctx *gin.Context) {
	if mod, has := model.Collect(); has {
		ctx.JSON(utils.Succ(`统计信息`, mod))
		return
	}
	ctx.JSON(utils.Fail(`未查询到统计信息`))
}

// UploadImage doc
// @Tags ctrl-系统相关
// @Summary 上传图片并裁剪
// @Accept  mpfd
// @Param token query string true "token"
// @Param file formData file true "file"
// @Router /adm/upload/image [post]
func UploadFile(c *gin.Context) {
	file, fileHeader, _ := c.Request.FormFile("file")

	fileSize := fileHeader.Size
	url, code := model.UpLoadFile(file, fileSize)
	if code == 500 {
		c.JSON(utils.ErrIpt("文件上传失败,请重试"))
		return
	}
	c.JSON(utils.Succ("上传成功", url))

}
