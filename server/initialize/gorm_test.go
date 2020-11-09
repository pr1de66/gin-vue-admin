package initialize

import (
	"fmt"
	conf "gin-vue-admin/config"
	"gin-vue-admin/global"
	"gin-vue-admin/gva/init_data"
	"gin-vue-admin/model"
	"gin-vue-admin/utils"

	//"gin-vue-admin/utils"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"testing"
)

type Result struct {
	Cnt int
}

func TestGormPostgreSql(t *testing.T) {
	dbConfig := conf.Postgresql{
		Host:                 "10.180.8.52",
		Port:                 "5432",
		Config:               "sslmode=disable TimeZone=Asia/Shanghai",
		Dbname:               "putong-moderationlog",
		Username:             "putong",
		Password:             "123456",
		MaxIdleConns:         10,
		MaxOpenConns:         10,
		PreferSimpleProtocol: false,
		Logger:               true,
	}

	dsn := fmt.Sprintf("host=%v user=%v password=%v dbname=%v port=%v %v", dbConfig.Host, dbConfig.Username, dbConfig.Password, dbConfig.Dbname, dbConfig.Port, dbConfig.Config)
	postgresConfig := postgres.Config{
		DSN:                  dsn,                           // DSN data source name
		PreferSimpleProtocol: dbConfig.PreferSimpleProtocol, // 禁用隐式 prepared statement
	}
	gormConfig := config(dbConfig.Logger)

	db, err := gorm.Open(postgres.New(postgresConfig), gormConfig)
	if err != nil {
		panic(err)
	}
	global.DB = db
	var res Result
	db.Raw("select count(1) from audit_log").Scan(&res)
	fmt.Println(res.Cnt)

	//err = db.AutoMigrate(
	//	model.SysUser{},
	//	model.SysAuthority{},
	//	model.SysApi{},
	//	model.SysBaseMenu{},
	//	model.SysBaseMenuParameter{},
	//	model.JwtBlacklist{},
	//	model.SysWorkflow{},
	//	model.SysWorkflowStepInfo{},
	//	model.SysDictionary{},
	//	model.SysDictionaryDetail{},
	//	model.ExaFileUploadAndDownload{},
	//	model.ExaFile{},
	//	model.ExaFileChunk{},
	//	model.ExaSimpleUploader{},
	//	model.ExaCustomer{},
	//	model.SysOperationRecord{},
	//)
	//if err != nil {
	//	panic(err)
	//}
	//

	err = init_data.InitSysApi()
	err = init_data.InitSysUser()
	err = init_data.InitExaCustomer()
	err = init_data.InitCasbinModel()
	err = init_data.InitSysAuthority()
	err = init_data.InitSysBaseMenus()
	err = init_data.InitAuthorityMenu()
	err = init_data.InitSysDictionary()
	err = init_data.InitSysAuthorityMenus()
	err = init_data.InitSysDataAuthorityId()
	err = init_data.InitSysDictionaryDetail()
	err = init_data.InitExaFileUploadAndDownload()
	//if err != nil {
	//	panic(err)
	//}

	u := model.SysUser{
		Username: "admin",
		Password: "123456",
	}
	u.Password = utils.MD5V([]byte(u.Password))
	//global.LOG.Info(u.Username)
	//global.LOG.Info(u.Password)
	err = global.DB.Where("username = ? AND password = ?", u.Username, u.Password).Preload("Authority").First(&u).Error

	if err != nil {

		panic(err)
	}

	fmt.Println(u)


	if err = global.DB.Where("uuid = ?", u.UUID).First(&u).Error; err != nil {
		fmt.Println(err.Error())
		fmt.Println(u)

	}

}
