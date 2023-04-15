package cronTask

import (
	"blog/model"
	"time"

	"github.com/Lieoxc/zlog"
	"github.com/robfig/cron/v3"
	"go.uber.org/zap"
)

func RmoveJob(id int) error {
	task, err := model.CronTaskGet(id)
	if err != nil {
		zlog.GetLogger().Error(" [ERROR] RmoveJob error:", zap.Error(err), zap.Int("id", id))
		return err
	}
	cn := Remove(crontab, task.EntryId)
	//等待 crontab 卸载完成
	select {
	case res := <-cn:
		if res {
			task.EntryId = 0
			model.CronTaskEdit(&task, "entry_id")
			return err
		}
	case <-time.After(time.Second * 1):
		zlog.GetLogger().Info(" RmoveJob 操作超时", zap.Error(err), zap.Int("id", id))
		return nil
	}
	return nil
}

// 移除任务
func Remove(c *cron.Cron, entryID int) chan bool {
	ch := make(chan bool)
	go func() {
		c.Remove(cron.EntryID(entryID))
		zlog.GetLogger().Error("JobCore Remove success", zap.Int("entryID", entryID))
		ch <- true
	}()
	return ch
}
