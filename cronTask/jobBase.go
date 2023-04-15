package cronTask

import (
	"blog/cronTask/worker"
	"blog/model"

	"github.com/Lieoxc/zlog"
	"github.com/robfig/cron/v3"
	"go.uber.org/zap"
)

const (
	TaskStop   = 1
	TaskStart  = 2
	timeFormat = "2006-01-02 15:04:05"
)

var (
	crontab *cron.Cron
	jobList map[string]JobsExec
)

// 需要将定义的struct 添加到字典中；
// 字典 key 可以配置到 自动任务 调用目标 中；
func initJob() {
	jobList = map[string]JobsExec{
		"OpenAICheck": worker.OpenAICheck{},
		"ExamplesOne": worker.ExamplesOne{},
		// ...
	}
}
func setup() {
	zlog.GetLogger().Info(" [INFO] JobCore Starting...")

	crontab = cron.New()
	jobList := make([]model.CronTask, 0)
	err := model.CronTaskGetList(TaskStart, &jobList)
	if err != nil {
		zlog.GetLogger().Info("[ERROR] JobCore init error", zap.Error(err))
		return
	}

	err = model.RemoveAllEntryID()
	if err != nil {
		zlog.GetLogger().Info("[ERROR] JobCore RemoveAllEntryID error", zap.Error(err))
		return
	}
	for i := 0; i < len(jobList); i++ {
		j := &ExecJob{}
		j.InvokeTarget = jobList[i].CallFunc
		j.CronExpression = jobList[i].Content
		j.JobId = jobList[i].Id
		j.Name = jobList[i].Name
		j.Args = jobList[i].Name
		jobList[i].EntryId, err = AddJob(crontab, j)
		if err != nil {
			zlog.GetLogger().Info("AddJob error", zap.Error(err))
			continue
		}
		model.CronTaskEdit(&jobList[i])
	}

	// 其中任务
	crontab.Start()
	zlog.GetLogger().Info("JobCore start success.")
	// 关闭任务
	defer crontab.Stop()
	select {}
}

func GetAllCronFunsList() []string {
	funcList := make([]string, 0, len(jobList))
	for FuncKey := range jobList {
		funcList = append(funcList, FuncKey)
	}
	return funcList
}

// 初始化
func Init() {
	initJob()
	go setup()
}
