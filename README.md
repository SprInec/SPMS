## 简介

主要功能页面：

1. **员工信息管理**：
    - 添加、编辑和删除员工信息。
    - 查看员工详情，包括基本信息、联系方式、工作经历等。
    - 上传和管理员工照片和证件。
2. **考勤管理**：
    - 记录和管理员工的考勤信息，包括打卡记录、迟到早退等。
    - 生成考勤报表和统计分析，如当天考勤状态一览表等。
3. **薪资管理**：
    - 设置员工薪资结构，包括基本工资、津贴、奖金等。
    - 支持薪资统一管理，可以便捷修改员工薪资情况。
4. **招聘与录用**：
    - 发布招聘信息，管理招聘流程和应聘者信息。
    - 一键应聘，应聘者可便捷应聘心仪岗位。
6. **福利管理**：
    - 管理员工福利和待遇，如健康保险、福利金、节日福利等。
    - 提供员工福利修改和查看功能。
7. **绩效评估**：
    - 综合考量以下指标：
        - 所教课程本学期平均成绩，最高分，最低分
        - 学期初绩效目标
        - 所带学生反馈与评价
        - 同事反馈与评价
        - 任课组长评价
        - 本学期教师本人回顾总结
    - 构建评分模型
    - 使用AI给出综合评价
    - 使用AI为该教师制定发展计划
    - 采用卡片问答式收集法
    - 生成全面美观的绩效评估表
    - 支持导出为PDF格式
8. **员工反馈与沟通**：
    - 提供员工反馈渠道和意见收集功能。
    - 实现员工与管理层之间的沟通和交流。
9. **系统管理和权限控制**：
    - 管理系统用户和权限，确保安全和合规性。

## 项目结构

```bash
SPMS/
  database/
    spms.sql         # mysql数据库还原文件
  document/          # 项目演示视频及文档文件
  resource/          # 资源文件
  server_set/        # 服务器配置示例
  static/
  	css/             # css样式表
  	js/              # js代码
  	uploads/         # 本地文件:图片等
  templates/
    index.html       # HTML页面文件
  app.py             # Flask后端代码
  openai_demo.py     # openai api 接口
  README.md
  requirements.txt   # 项目python环境需求表
```

## 环境配置

1. 安装并成功配置[Anaconda](https://blog.csdn.net/fan18317517352/article/details/123035625)
2. 创建针对该项目的conda环境
    - 该项目python版本：Python 3.9.19
3. 激活该项目环境，并在当前项目根目录 `SPMS/` 下执行以下命令

```bash
conda activate your_env_name
pip install -r requirements.txt
```

## Navicat 数据库还原

https://blog.csdn.net/davidchengx/article/details/75912013

> mysql数据库文件存放在`database/`目录下，文件为`spms.sql`
