package worker

import (
	"blog/conf"
	"blog/cronTask/utils"
	"bytes"
	"encoding/base64"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"time"

	"github.com/Lieoxc/zlog"
	"go.uber.org/zap"
)

const (
	emailRecver = "394101651@qq.com"
)

type dailyNewsResq struct {
	Success bool `json:"success"`
	Data    struct {
		FileName string `json:"fileName"`
	} `json:"data"`
}

// 新添加的job 必须按照以下格式定义，并实现Exec函数
type DailyNews struct {
}

func (t DailyNews) Exec(arg interface{}) error {
	str := time.Now().Format(timeFormat) + " [INFO] JobCore ExamplesOne exec success"
	// TODO: 这里需要注意 Examples 传入参数是 string 所以 arg.(string)；请根据对应的类型进行转化；
	zlog.GetLogger().Info(str)
	fileName, err := getDailyNews()
	if err != nil {
		zlog.GetLogger().Error("getDailyNews error : ", zap.Error(err))
		return err
	}
	err = sendDailyNewsEmail(fileName, emailRecver)
	if err != nil {
		zlog.GetLogger().Error("sendDailyNewsEmail error : ", zap.Error(err))
		return err
	}
	return nil
}
func getDailyNews() (string, error) {
	client := &http.Client{
		Timeout: time.Second * 10,
	}
	// 发送HTTP请求
	url := fmt.Sprintf("http://%s/dailyNews/list", "127.0.0.1:3001")
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		zlog.GetLogger().Error("NewRequest error : ", zap.Any("err", err))
		return "", err
	}
	resp, err := client.Do(req)
	if err != nil {
		zlog.GetLogger().Error("do NewRequest", zap.Any("err", err))
		return "", err
	}
	defer resp.Body.Close()
	// 读取 HTTP 响应
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		zlog.GetLogger().Error("read body error", zap.Any("err", err))
		return "", err
	}
	// 处理 HTTP 响应
	responSt := &dailyNewsResq{}
	err = json.Unmarshal(body, &responSt)
	if err != nil {
		zlog.GetLogger().Error("Unmarshal response err:", zap.Any("err:", err))
		return "", err
	}
	zlog.GetLogger().Info("dailyNews respon :", zap.String("fileName:", responSt.Data.FileName))
	return responSt.Data.FileName, nil
}

func sendDailyNewsEmail(fileName, addr string) error {
	email := utils.Email{}
	email.To = addr
	email.Subject = "你需要知道的隔夜全球要闻"
	fullPath := conf.App.DailyNewsPath + fileName
	// 读取图片文件并转换为 base64 编码
	imgBytes, err := ioutil.ReadFile(fullPath)
	if err != nil {
		fmt.Println("读取图片文件失败：", err)
		return err
	}
	imgBase64 := base64.StdEncoding.EncodeToString(imgBytes)

	// 构造图片的 HTML 标签
	imgSrc := "data:image/png;base64," + imgBase64
	imgTag := "<img src='" + imgSrc + "'/>"
	// 将图片标签添加到邮件正文中
	var body bytes.Buffer
	body.WriteString(imgTag)
	email.Body = string(body.Bytes())

	err = utils.CallEmailSend(email)
	if err != nil {
		zlog.GetLogger().Error("callEmailSend err:", zap.Any("err:", err))
		return err
	}
	return nil
}
