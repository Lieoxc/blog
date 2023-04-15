package model

// Tag 标签
type CronTask struct {
	Id       int    `xorm:"INT(11) PK AUTOINCR comment('主键')" json:"id"`              //主键
	Name     string `xorm:"UNIQUE VARCHAR(255) comment('标签名')" json:"name"`           //标签名
	Content  string `xorm:"VARCHAR(255) comment('cron表达式')" json:"content"`           //cron表达式
	CallFunc string `xorm:"VARCHAR(255) comment('执行函数')" json:"callFunc"`             //执行函数
	Status   int    `xorm:"INT(11) DEFAULT 2 comment('状态, 1:停用 2:启用')" json:"status"` //状态  1停用， 2启用
	EntryId  int    `xorm:"INT(11) DEFAULT 0 comment('错误次数')"`                        //cron任务的运行ID 不需要上传给前端
}

// CronTask 标签分页总数
func CronTaskCount() int {
	count, _ := db.Count(&CronTask{})
	return int(count)
}

// CronTask 标签分页
func CronTaskGet(id int) (CronTask, error) {
	mod := CronTask{}
	exist, err := db.Where("id = ?", id).Get(&mod)
	if !exist {
		return CronTask{}, nil
	}
	return mod, err
}

// CronTask 标签分页
func CronTaskPage(pi int, ps int, cols ...string) ([]CronTask, error) {
	mods := make([]CronTask, 0, ps)
	if len(cols) > 0 {
		db.Cols(cols...)
	}
	err := db.Desc("Id").Limit(ps, (pi-1)*ps).Find(&mods)
	return mods, err
}

// CronTaskAdd 添加标签
func CronTaskAdd(mod *CronTask) error {
	if _, err := db.InsertOne(mod); err != nil {
		return err
	}
	return nil
}

// CronTaskEdit 编辑定时任务
func CronTaskEdit(mod *CronTask, cols ...string) error {
	if _, err := db.ID(mod.Id).Cols(cols...).Update(mod); err != nil {
		return err
	}
	return nil
}

// CronTaskDrop 删除定时任务
func CronTaskDrop(ids []int) error {
	if _, err := db.In("id", ids).Delete(&CronTask{}); err != nil {
		return err
	}
	return nil
}

func CronTaskGetList(status int, list interface{}) error {
	return db.Where("status = ?", status).Find(list)
}

func RemoveAllEntryID() error {
	_, err := db.Where("entry_id > ?", 0).Cols("entry_id").Update(&CronTask{EntryId: 0})
	if err != nil {
		return err
	}
	return nil
}
