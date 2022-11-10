package middleware

import (
	"blog/conf"
	"blog/internal/token"

	"github.com/gin-gonic/gin"
	"github.com/zxysilent/utils"
)

// midAuth 登录认证中间件
func MidAuth() gin.HandlerFunc {
	return func(ctx *gin.Context) {
		tokenRaw := ctx.Request.FormValue(conf.App.TokenKey) // query/form 查找 token
		if tokenRaw == "" {
			tokenRaw = ctx.Request.Header.Get("Authorization")
			if tokenRaw == "" {
				ctx.JSON(utils.ErrToken("请重新登陆", "token为空"))
				ctx.Abort()
				return
			}
		}
		auth := token.Auth{}
		err := auth.Decode(tokenRaw, conf.App.TokenSecret)
		if err != nil {
			ctx.JSON(utils.ErrToken("请重新登陆", err.Error()))
			ctx.Abort()
			return
		}
		// 验证通过，保存信息
		ctx.Set("auth", auth)
		ctx.Set("uid", auth.Id)
		ctx.Set("rid", auth.RoleId)
		// 后续流程
		ctx.Next()
	}
}
