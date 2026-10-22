# 黄鹏学术网站配置

- 进入当前独立实施副本，先查 Git、项目 AGENTS 和最新 HANDOFF；目录名不是版本证据。另行保留的原始工作树存在用户修改，不覆盖。
- Jekyll／Academic Pages；`scripts/site build`、`scripts/site check`，本地 `scripts/site serve`。4173 无 watch，改完需重新构建并重启服务；生产 `_site` 与预览 `_site-preview` 分开。
- 六页：`/`、`/publications/`、`/people/`、`/courses/`、`/chips/`、`/software/`。
- 已确认风格：白底、深灰、北大红；Georgia 英文标题，系统无衬线正文；正文17px、引文细节16px、辅助信息15px、条目标题19px。栏目主标题38px，手机32px；首页身份主标题可更大。通过改变分栏适应小屏，不缩小正文。
- 校徽在正文背后 fixed 居中，opacity 0.01，pointer-events none；照片 contain，保留 EXIF 方向。
- 人员页不恢复已删除的两句介绍和 Direct-entry 标签；校友不展示未经核准的年份。课程未核准的课程号、学分、学期不显示。论文审查与原始引文保留，显示选单和源数据分别核对。
- `_data` 是事实数据；`_sass` 是样式入口；`docs`、`.local`、AGENTS 与原件不进入公开站点。新增资料继续沿用项目外原件档案与哈希记录。
- 本次配置形成于2026-10-22。下一轮以用户新指令、项目 AGENTS 及实际文件为准，不从这里推断发布权限。
