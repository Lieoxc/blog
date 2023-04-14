package model

// Tag 标签
type CronTask struct {
	Id       int    `xorm:"INT(11) PK AUTOINCR comment('主键')" json:"id"`    //主键
	Name     string `xorm:"UNIQUE VARCHAR(255) comment('标签名')" json:"name"` //标签名
	Content  string `xorm:"VARCHAR(255) comment('cron表达式')" json:"content"` //cron表达式
	CallFunc string `xorm:"VARCHAR(255) comment('执行函数')" json:"callFunc"`   //执行函数
	Status   string `xorm:"VARCHAR(255) comment('状态')" json:"status"`       //状态
}

// CronTask 标签分页总数
func CronTaskCount() int {
	mod := &CronTask{}
	sess := db.NewSession()
	defer sess.Close()
	count, _ := sess.Count(mod)
	return int(count)
}

// CronTask 标签分页
func CronTaskPage(pi int, ps int, cols ...string) ([]CronTask, error) {
	mods := make([]CronTask, 0, ps)
	sess := db.NewSession()
	defer sess.Close()
	if len(cols) > 0 {
		sess.Cols(cols...)
	}
	err := sess.Desc("Id").Limit(ps, (pi-1)*ps).Find(&mods)
	return mods, err
}

// CronTaskAdd 添加标签
func CronTaskAdd(mod *CronTask) error {
	sess := db.NewSession()
	defer sess.Close()
	sess.Begin()
	if _, err := sess.InsertOne(mod); err != nil {
		sess.Rollback()
		return err
	}
	sess.Commit()
	return nil
}

// CronTaskEdit 编辑定时任务
func CronTaskEdit(mod *CronTask, cols ...string) error {
	sess := db.NewSession()
	defer sess.Close()
	sess.Begin()
	if _, err := sess.ID(mod.Id).Cols(cols...).Update(mod); err != nil {
		sess.Rollback()
		return err
	}
	sess.Commit()
	return nil
}

// CronTaskDrop 删除定时任务
func CronTaskDrop(ids []int) error {
	sess := db.NewSession()
	defer sess.Close()
	sess.Begin()
	if _, err := sess.In("id", ids).Delete(&CronTask{}); err != nil {
		sess.Rollback()
		return err
	}
	sess.Commit()
	return nil
}
