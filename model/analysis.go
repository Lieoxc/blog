package model

import "time"

// Wallpaper 分类
type AnalysisLog struct {
	Id     int       `xorm:"INT(11) PK AUTOINCR comment('主键')" json:"id"` //主键
	Msg    string    `xorm:"VARCHAR(255) comment('类型')" json:"msg"`       //解析链接
	Time   time.Time `xorm:"DATETIME comment('穿件时间')" json:"time"`        //创建时间
	Result bool      `xorm:"tinyint(1) comment('主键')" json:"result"`      //解析结果
}

// CatePage 分类分页
func AddAnalysisLog(mod *AnalysisLog) error {
	sess := db.NewSession()
	defer sess.Close()
	sess.Begin()
	if _, err := sess.Cols("msg", "time", "result").Insert(mod); err != nil {
		sess.Rollback()
		return err
	}
	sess.Commit()
	return nil
}
