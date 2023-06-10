package worker

import (
	"blog/conf"
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
	"time"

	"github.com/Lieoxc/zlog"
	"go.uber.org/zap"
)

var (
	startTime = "2023-04-01"
	proxyStr  = "http://127.0.0.1:10809"

	timeFormat = "2006-01-02 15:04:05"
)

type Email struct {
	To      string `json:"to"`      // 邮件发送给谁
	Subject string `json:"subject"` // 邮件标题
	Body    string `json:"body"`    // 邮件内容
}

type BalanceSt struct {
	TotalUsage float64 `json:"total_usage"`
}

type OpenAICheck struct {
}

func (t OpenAICheck) Exec(arg interface{}) error {
	zlog.GetLogger().Info("xxxxxxxxxxxxxxxxx OpenAICheck ")
	apikeys := getApiKeys()
	keyValueMap := make(map[string]float64, len(apikeys))
	for _, key := range apikeys {
		value, err := getAPIUsage(key)
		if err != nil {
			return err
		}
		keyValueMap[key] = value

	}
	sendEmail(keyValueMap, "394101651@qq.com")
	// str := time.Now().Format(timeFormat) + " [INFO] JobCore ExamplesOne exec success"
	// // TODO: 这里需要注意 Examples 传入参数是 string 所以 arg.(string)；请根据对应的类型进行转化；
	// fmt.Println(str, arg.(string))
	return nil
}
func getApiKeys() []string {
	return []string{
		"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",
		"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",
		"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",
		"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",
		"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",
		"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",
		"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",
		"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",
	}
}
func getAPIUsage(apiKey string) (float64, error) {

	endTime, err := getEndTime()
	if err != nil {
		zlog.GetLogger().Error("getEndTime err:", zap.Any("err:", err))
		return 0, err
	}
	params := url.Values{}
	params.Add("start_date", startTime)
	params.Add("end_date", endTime)
	// 创建 HTTP 请求
	httpUrl := "https://api.openai.com/v1/dashboard/billing/usage?" + params.Encode()
	req, err := http.NewRequest("GET", httpUrl, nil)
	if err != nil {
		zlog.GetLogger().Error("Error creating HTTP request:", zap.Any("err:", err))
		return 0, err
	}
	headers := http.Header{}
	headers.Set("content-type", "application/json")
	headers.Set("authorization", "Bearer "+apiKey)
	req.Header = headers

	// 设置 HTTP 代理
	proxyURL, err := url.Parse(proxyStr)
	if err != nil {
		zlog.GetLogger().Error("Error parsing proxy URL:", zap.Any("err:", err))
		return 0, err
	}
	transport := &http.Transport{Proxy: http.ProxyURL(proxyURL)}
	// 创建 HTTP 客户端
	client := &http.Client{Transport: transport}
	resp, err := client.Do(req)
	if err != nil {
		zlog.GetLogger().Error("Error sending HTTP request:", zap.Any("err:", err))
		return 0, err
	}
	defer resp.Body.Close()
	// 读取 HTTP 响应
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		zlog.GetLogger().Error("Error reading HTTP response:", zap.Any("err:", err))
		return 0, err
	}
	// 处理 HTTP 响应
	balance := &BalanceSt{}
	err = json.Unmarshal(body, &balance)
	if err != nil {
		zlog.GetLogger().Error("Unmarshal response err:", zap.Any("err:", err))
		return 0, err
	}
	zlog.GetLogger().Info("balance value:", zap.Float64("usage:", balance.TotalUsage))
	return balance.TotalUsage, nil
}

func sendEmail(keyValueMap map[string]float64, addr string) error {
	email := Email{}
	email.To = addr
	email.Subject = "OpenAI API-KEY使用报告"
	//body := fmt.Sprintf("<html><body><h4>使用报告</h1><p>API-KEY:%s.<br>总用量：%.2f <br>余额：%.2f </p></body></html>", key, value/100, 5.00-value/100)
	body := "<html><body><h4>使用报告</h4>"
	argStr := ""
	for apiKey, value := range keyValueMap {
		argStr += fmt.Sprintf("<p>API-KEY:<br> %s <br>总用量：%.2f <br>余额：%.2f </p>", apiKey, value/100, 5.00-value/100)
	}
	endstr := "</body></html>"
	email.Body = body + argStr + endstr
	err := callEmailSend(email)
	if err != nil {
		zlog.GetLogger().Error("callEmailSend err:", zap.Any("err:", err))
		return err
	}
	return nil
}

func callEmailSend(email Email) error {

	url := fmt.Sprintf("http://%s/email/sendEmail", conf.App.Addr)
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

func getEndTime() (string, error) {
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
