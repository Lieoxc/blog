package cronTask

import (
	"blog/model"
	"fmt"

	"github.com/Lieoxc/zlog"
	"github.com/robfig/cron/v3"
	"go.uber.org/zap"
)

// 添加任务 AddJob(invokeTarget string, jobId int, jobName string, cronExpression string)
func AddJob(c *cron.Cron, job Job) (int, error) {
	if job == nil {
		fmt.Println("unknown")
		return 0, nil
	}
	return job.addJob(c)
}

func StartJob(task *model.CronTask) error {
	if task.Status != 2 {
		zlog.GetLogger().Info("任务未开启，无法启动", zap.Int("id", task.Id))
	}
	j := &ExecJob{}
	j.InvokeTarget = task.CallFunc
	j.CronExpression = task.Content
	j.JobId = task.Id
	j.Name = task.Name
	j.Args = task.Name
	var err error
	task.EntryId, err = AddJob(crontab, j)
	if err != nil {
		zlog.GetLogger().Info("AddJob error", zap.Error(err), zap.Int("id", task.Id))
		return err
	}
	model.CronTaskEdit(task)
	return nil
}
