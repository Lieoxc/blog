package utils

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"time"

	"github.com/Lieoxc/zlog"
	"go.uber.org/zap"
)

type Email struct {
	To      string `json:"to"`      // 邮件发送给谁
	Subject string `json:"subject"` // 邮件标题
	Body    string `json:"body"`    // 邮件内容
}

func CallEmailSend(email Email) error {

	url := fmt.Sprintf("http://127.0.0.1:3001/email/sendEmail")
	dataStr, _ := json.Marshal(email)
	req, err := http.NewRequest("POST", url, bytes.NewBuffer(dataStr))
	if err != nil {
		zlog.GetLogger().Error("call  EmailSend err:", zap.Any("err:", err))
		return err
	}
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		zlog.GetLogger().Error("do  EmailSend err:", zap.Any("err:", err))
		return err
	}
	defer resp.Body.Close()
	return nil
}

func GetEndTime() (string, error) {
	log := zlog.GetLogger()
	now := time.Now()                              // 获取当前时间
	loc, err := time.LoadLocation("Asia/Shanghai") // 加载本地时区信息
	if err != nil {
		log.Error("加载时区信息出错：", zap.Any("err:", err))
		return "", err
	}
	localTime := now.In(loc) // 将时间转换为本地时区的时间

	dateStr := localTime.Format("2006-01-02") // 格式化时间为"YYYY-MM-DD"字符串
	return dateStr, nil
}
